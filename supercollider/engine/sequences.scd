////////////////////////////////////////////////////////////////////////////////
// SEQUENCES
////////////////////////////////////////////////////////////////////////////////

(
// place cursor below this line and execute CMD + enter to execute the section)



//// rumble sequence ///////////////////////////////////////////////////////////
Pdef(\rumble,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \rumble,
            \n, Pseq([0], inf),
            \speed, Pseq([0.8, 1, 0.5, 1.2], inf),
            \dur, 4 * Pseq([1, 1/2, 1, 2, Rest(2), 1/2], inf),
            // \shape, 0.3,
            // \distort, 0.01,
            \lpf, 50
        ),
        Pbind(
            \type, \dirt,
            \s, 'form-msp5',
            \n, Pseq([1,2,3,4], inf),
            \speed, Pseq([1], inf),
            \dur, Pseq([8, Rest(8)], inf),
            // \room, Pseq([0, 0, 0.4], inf),
            // \lpf, 50
        )
    ])
);



Pdef(\industrial,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \soundfx,
            \n, Pseq([1], inf),
            \speed, Pseq([0.2, 0.1, 0.5, 1.2], inf),
            \dur, Pseq([8, Rest(2)], inf),
            \pan, Pseq([0, 0.25, 0.75, 1], inf),
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([0, 0.25, 0.75, 1], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);

Pdef(\rain,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \soundfx,
            \n, Pseq([0], inf),
            \speed, Pseq([0.2, 0.1, 0.5, 1.2], inf),
            \dur, Pseq([8, Rest(2)], inf),
            \pan, Pseq([0, 0.25, 0.75, 1], inf),
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([1, 0.75, 0.25, 0], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);

Pdef(\seqtest,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \cr,
            \n, Pseq([1], inf),
            \speed, 1,
            \dur, 1,
            \gain, 0.7,
            \orbit, ~out1_2
        )
    ])
);

Pdef(\twinkle,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \gamaBell,
            // \instrument, \gamaBell,
            \n, Pseq([1, 5, 10, 3, 6, 4], inf),
            \atk, 2,
            \sus, 2,
            \rel, 3,
            \pan, 1.0.rand2,
            \freqs, {50.0.rrand(4000)}.dup(12),
            \rings, {0.1.rrand(2)}.dup(12),
            \speed, 1,
            \dur, 10,
            \gain, 0.95,
            \orbit, ~out1_2
        )
    ])
);

Pdef (
	\haunted,
	Pbind(
		\instrument, \hauntedSine,
		\dur, Pwhite(0.05, 0.5, inf),
        \midinote, Pseq([33], inf),
        \harmonic, Pexprand(1, 80, inf).round,
        // \freq, Pexprand(300, 600, inf),
		\atk, Pwhite(2.0, 3.0, inf),
		\rel, Pwhite(5.0, 10.0, inf),
		\amp, Pkey(\harmonic).reciprocal * 0.3,
		\pan, Pwhite(-0.8, 0.8, inf),
	);
);

Pdef(\gravity,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, 'form-msp5',
            \n, Pseq([8], inf),
            \speed, Pseq([Prand([5, 0.2, 0.1, 0.5, 1.2, 2, 0.8])], inf),
            \dur, Pseq([8, Rest(4)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([1, 0.75, 0.25, 0], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);




"".postln;
"List all sequences........".postln;
Pdef.all.do(_.postln);

PdefAllGui();
)