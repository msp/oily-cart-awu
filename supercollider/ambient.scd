(
////////////////////////////////////////////////////////////////////////////////
//
// AMBIENT
//
//
// Based up Eli Fieldsteel's excellent wavetable synthesis lessons:
// https://www.youtube.com/watch?v=8EK9sq_9gFI
//
////////////////////////////////////////////////////////////////////////////////
//cleanup
Pdef.all.do(_.clear);
Pbindef.all.do(_.clear);
~wt_buf.do(_.free);
t.stop;
ServerTree.remove(~add_reverb);

//initialization
s = Server.local;
t = TempoClock.new(100/60).permanent_(true);
s.newBusAllocators;
// s.options.device = "Fireface UCX (23733485)";
~rbus = Bus.audio(s,2);

// Scale.directory
~scale = Scale.ritusen;

s.waitForBoot({

	//10 wavetables with increasing complexity
	~wt_sig = 10.collect({
		arg i;

		//random number of envelope segments
		var numSegs = i.linexp(0,9,4,40).round;

		Env(
			//env always begins and ends with zero
			//inner points are random from -1.0 to 1.0
			[0]++({1.0.rand}.dup(numSegs-1) * [1,-1]).scramble++[0],

			//greater segment duration variety in higher-index wavetables
			{exprand(1,i.linexp(0,9,1,50))}.dup(numSegs),

			//low-index wavetables tend to be sinusoidal
			//high index wavetables tend to have sharp angles and corners
			{[\sine,0,exprand(1,20) * [1,-1].choose].wchoose([9-i,3,i].normalizeSum)}.dup(numSegs)
		).asSignal(1024);
	});

	//load into 10 buffers in wavetable format
	~wt_buf = Buffer.allocConsecutive(10, s, 2048, 1, {
		arg buf, index;
		buf.setnMsg(0, ~wt_sig[index].asWavetable);
	});

	SynthDef(\osc, {
		arg buf=0, freq=200, detune=0.2,
		amp=0.2, pan=0, out=0, rout=0, rsend=(-20),
		atk=0.01, sus=1, rel=0.01, c0=1, c1=(-1);
		var sig, env, detuneCtrl;
		env = EnvGen.ar(
			Env([0,1,1,0],[atk,sus,rel],[c0,0,c1]),
			doneAction:2
		);

		//array of eight Oscs with uniquely detune frequencies
		//and unique initial phase offsets
		detuneCtrl = LFNoise1.kr(0.1!8).bipolar(detune).midiratio;
		sig = Osc.ar(buf, freq * detuneCtrl, {Rand(0,2pi)}!8);

		sig = Splay.ar(sig); //spread 8 signals over stereo field
		sig = LeakDC.ar(sig); //remove DC bias
		sig = Balance2.ar(sig[0], sig[1], pan, amp); //L/R balance (pan)
		sig = sig * env;
		Out.ar(out, sig);
		Out.ar(rout, sig * rsend.dbamp); //"post-fader" send to reverb
	}).add;

	SynthDef(\reverb, {
		arg in=0, out=0, dec=4, lpf=1500;
		var sig;
		sig = In.ar(in, 2).sum;
		sig = DelayN.ar(sig, 0.03, 0.03);
		sig = CombN.ar(sig, 0.1, {Rand(0.01,0.099)}!32, dec);
		sig = SplayAz.ar(2, sig);
		sig = LPF.ar(sig, lpf);
		5.do{sig = AllpassN.ar(sig, 0.1, {Rand(0.01,0.099)}!2, 3)};
		sig = LPF.ar(sig, lpf);
		sig = LeakDC.ar(sig);
		Out.ar(out, sig);
	}).add;

	s.sync;

	//instantiate reverb and re-instantiate when cmd-period is pressed
	~add_reverb = {Synth(\reverb, [\in, ~rbus])};
	ServerTree.add(~add_reverb);
	s.freeAll;

	s.sync;

	//background pad using simple wavetables
	Pbindef(\pad,
		\instrument, \osc,
        \dur, Pseq([Rest(10.rand), Prand([1,6,12]),2   , Rest(5.rand), 1.5, 0.5], inf),
		\atk, Pexprand(3,6),
		\sus, 0,
		\rel, Pexprand(5,10),
		\c0, Pexprand(1,2),
		\c1, Pexprand(1,2).neg,
		\detune, Pfunc({rrand(0.15,0.4)}!3),
        \buf, Prand(~wt_buf[0..3], inf),
		\scale, ~scale,
		\degree, Pfunc({
			(-12,-10..12).scramble[0..rrand(1,3)]
		}),
		\amp, Pexprand(0.05,0.07),
		\pan, Pwhite(-0.4,0.4),
		\out, 0,
		\rout, ~rbus,
		\rsend, -10,
	).play;

	Pbindef(\pad2,
		\instrument, \osc,
        \dur, Prand([
            Pseq([Rest(10.rand), Prand([12,16,20]),2   , 1.5, 0.5], 1),
            Pseq([Rest(10.rand), Prand([12,16,20]),1.5, 1   , 1.5], 1),
        ],inf),
        // \degree, Pfunc({
        //     (-12,-10..0).scramble[0..rrand(1,3)]
        // }), // Not if using midinotes - see hierachy at pBind detunedFreq help
        \atk, rrand(3,10),
		\sus, 0.3,
		\rel, rrand(2, 5),
		\c0, -2,
		\c1, -2,
		\detune, Pexprand(0.18,0.25),
		\buf, Pwrand([
			Pseq([~wt_buf[0]],4),
			Pseq([~wt_buf[3]],4),
			Pseq([~wt_buf[7]],4),
		],[15,3,1].normalizeSum,inf),
        \scale, ~scale,
        \midinote, Pxrand([
            Pseq([\,67,60,Prand([58,70,\])],1),
            Pseq([\,67,58,Prand([57,63,\])],1),
            Pseq([\,70,72,Prand([65,79,\])],1)
        ],inf),
		\amp, Pseq([0,0.18,0.24,0.28],inf),
		\out, 0,
		\rout, ~rbus,
		\rsend, -6,
	).play(t, quant:1);

});
)

// view wavetables
// (
// ~wt_sig.reverseDo(_.plot);
// )
//
// (
// Pbindef(\pad).stop;
// Pbindef(\pad2).stop;
// )
//
// (
// Pbindef(\pad).play;
// Pbindef(\pad2).play;
// )
//
// (
// Pbindef(\pad).isPlaying;
// Pbindef(\pad2).isPlaying;
// )
