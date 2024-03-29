(
SynthDef("Pdefhelp", { arg out, freq, sustain=1, amp=1, pan;
    var env, u=1;
    env = EnvGen.kr(Env.perc(0.01, sustain), 1, doneAction: Done.freeSelf);
    5.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
    Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));
}).add;
)

Synth(\Pdefhelp)


Pbindef(\a, \instrument, \Pdefhelp).play;

Pbindef(\a, \degree, [-12, 12, 0, 1, 2]);

Pbindef(\a, \degree, 12);

Pbindef(\a, \degree, Pfunc({
            (-12,-10..0).scramble[0..rrand(1,3)]
        })
);
// Pbindef(\a, \degree, Pseq([0, 2, 5b, 1b], inf));


Pbindef(\a, \dur, 1);

Pbindef(\a, \midinote, Pseq([67,\,70], inf));




(1..2).class

Array.rand(1, 3, 5)

rrand(3,10)

// Pbindef(\a, \dur, Pseq([2, 1, Rest(7.rand)], inf));


Pbindef(\a, \degree, -10);

Pbindef(\a, \degree, Pseq([1b, 5, 3, 1b, 6, 2, 5, 0, 3, 0, 2], inf));
Pbindef(\a, \legato, Prand([1.0, 2.4, 0.2], inf), \mtranspose, -3);
Pbindef(\a, \mtranspose, nil); // remove key

Pbindef(\a, \degree, Pseq([1, 2, 3, 4, 5, 6], 1));
Pbindef(\a, \degree, Pseq([1, 2, 3, 4, 5, 6], 3), \dur, 0.02);
Pbindef(\a, \degree, Pseq([1, 2, 3, 4, 5, 6], 3), \dur, 0.1);



Pbindef(\a).stop;



Pbind(\note, Pseq([0, 4, 7, 11], inf), \dur, Pseq([2, 1, Rest(1)], inf) / 5).play;


Platform.systemAppSupportDir

File.mkdir(Platform.userAppSupportDir)

Platform.userAppSupportDir

/Users/spatial/Library/Application Support/SuperCollider/downloaded-quarks



