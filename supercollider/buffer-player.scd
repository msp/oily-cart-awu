////////////////////////////////////////////////////////////////////////////////
//
// BUFFER PLAYER
//
// Based up Eli Fieldsteel's SC Buffer lessons:
// https://youtu.be/_GZmuvmgtUc
//
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Load Samples (once only or when samples change)
////////////////////////////////////////////////////////////////////////////////
(
~soundz = Array.new;
~numChannels = 1;


// You can drag and drop a folder location into the editor here to find it's path.
// The samples need to exist on your computer and you'll need to update this :)

// ~sampleDirectory = "/Users/spatial/Library/Application Support/SuperCollider/downloaded-quarks/Dirt-Samples/metal/";
~sampleDirectory = "/Users/spatial/Library/Application Support/SuperCollider/downloaded-quarks/Dirt-Samples/form-msp8/";
~folder = PathName.new(~sampleDirectory);

~folder.entries.size;


(
~folder.entries.do({
    arg path;
    ~soundz = ~soundz.add(Buffer.read(s, path.fullPath));
});
)
)

(
// Play a random sample directly from the buffer
~soundz.at(rrand(0, ~soundz.size-1)).play;
)


////////////////////////////////////////////////////////////////////////////////
// Create a synth to play our loaded sample buffers
////////////////////////////////////////////////////////////////////////////////
(
(
SynthDef.new(\playbuf_test, {
	arg amp=1, out=0, buf, rate=1, t_trig=1, start=0, loop=0, da=2;
	var sig;
	sig = PlayBuf.ar(~numChannels, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, da);
	sig = sig * amp;
	Out.ar(out, sig!2);
}).add;
)
)

(
// Rate is interpreted as a ratio, so 1 is the normal sample rate, 2 would be twice as fast,

Synth.new(\playbuf_test, [\buf, ~soundz[8].bufnum, \rate, 2]);

// and 0.5 would be twice as slow.
Synth.new(\playbuf_test, [\buf, ~soundz[0].bufnum, \rate, 0.5]);

// and 0.1 would bevery low.
Synth.new(\playbuf_test, [\buf, ~soundz[0].bufnum, \rate, 0.1]);

x = Synth.new(\playbuf_test, [\buf, ~soundz[0].bufnum, \loop, 1, \rate, 2]);
x.set(\loop, 0);
)

////////////////////////////////////////////////////////////////////////////////
// Randomly scrub through a sample buffer, granular stylee
////////////////////////////////////////////////////////////////////////////////
(
(
SynthDef.new(\bufrd_noise, {
	arg amp=1, out=0, buf, freq=0.75, start, end;
	var sig, ptr;
	ptr = LFDNoise1.ar(freq).range(start, end);
	sig = BufRd.ar(~numChannels, buf, ptr);
	sig = sig * amp;
	Out.ar(out, sig!2);
}).add;
)
)

(
x = Synth.new(\bufrd_noise, [\buf, ~soundz[0].bufnum, \start, 0, \end, ~soundz[0].numFrames-1]);
x.free;

z = Synth.new(\bufrd_noise, [\buf, ~soundz[12].bufnum, \start, 0, \end, ~soundz[12].numFrames-1]);
z.free;
)