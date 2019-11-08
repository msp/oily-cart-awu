(
~rbus = Bus.audio(s,2);

// Scale.directory
~scale = Scale.ritusen;

SynthDef(\simpleSine, {|freq = 80, out| Out.ar(out, SinOsc.ar(freq, 0, 0.2)) }).add;


SynthDef(\gamaBell,
    {|out = 0, freqs = #[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], rings = #[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], atk = 5, sus = 8, rel = 5, pan = 0, amp = 0.5|
        var e = EnvGen.kr(Env.linen(atk, sus, rel, 1, 4), doneAction: Done.freeSelf);
        var i = Decay.ar(Impulse.ar(Rand(0.8, 2.2)), 0.03, ClipNoise.ar(0.01));
        var z = Klank.ar(
            `[freqs, nil, rings],     // specs
            i                    // input
        );
        var sound = z*e * amp;
        // Out.ar(out, Pan2.ar(z*e, pan));
        OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan))
}).add;


SynthDef(\hauntedSine, {
    arg freq=440, atk=0.005, rel=0.3, amp=1, pan=0, out=0;
    var sig, env;
    sig = SinOsc.ar(freq);
    env = EnvGen.kr(Env.new([0,1,0], [atk, rel], [1 -1]), doneAction:2);
    sig = Pan2.ar(sig, pan, amp);
    sig = sig * env;
    Out.ar(out, sig);
}).add;

////////////////////////////////////////////////////////////////////////////////
//
// AMBIENT
//
//
// Based up Eli Fieldsteel's excellent wavetable synthesis lessons:
// https://www.youtube.com/watch?v=8EK9sq_9gFI
//
////////////////////////////////////////////////////////////////////////////////

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

// s.sync;

//instantiate reverb and re-instantiate when cmd-period is pressed
~add_reverb = {Synth(\reverb, [\in, ~rbus])};
ServerTree.add(~add_reverb);
s.freeAll;

)
