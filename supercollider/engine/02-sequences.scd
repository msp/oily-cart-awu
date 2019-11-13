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
            \n, Pseq([Prand([0,1,6])], inf),
            \speed, Pseq([0.8, 1, 0.5, 1.2], inf),
            \dur, 8 * Pseq([1, Rest(1/2), 2, Rest(2), 1/2], inf),
            \shape, 0.3,
            \distort, 0.01,
            \cutoff, 50,
            \orbit, ~out1_2
        ),
        Pbind(
            \type, \dirt,
            \s, 'form-msp5',
            \n, Pseq([0, 1], inf),
            \speed, Pseq([0.2, 0.5], inf),
            \dur, Pseq([16, Rest(1)], inf),
            \gain, 0.8,
            \room, Pseq([0, 0, 0.4], inf),
            \orbit, ~out1_2
        )
    ])
);


//// industrial ////////////////////////////////////////////////////////////////
Pdef(\industrial,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \soundfx,
            \n, Pseq([1], inf),
            \speed, Pseq([Prand([0.2, 0.1, 0.5, 1.2])], inf),
            \dur, Pseq([8, Rest(2)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([0, 0.25, 0.75, 1], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);

//// rain //////////////////////////////////////////////////////////////////////
Pdef(\rain,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \soundfx,
            \n, Pseq([0,3], inf),
            \speed, Pseq([0.2, 0.1, 0.5, 1.2], inf),
            \dur, Pseq([8, Rest(2)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([1, 0.75, 0.25, 0], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);

//// pool //////////////////////////////////////////////////////////////////////
Pdef(\pool,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \soundfx,
            \n, Pseq([2], inf),
            \speed, Pseq([Prand([0.2, 0.5, 1])], inf),
            \dur, Pseq([32, Rest(8)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([1, 0.75, 0.25, 0], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);

//// charger ///////////////////////////////////////////////////////////////////
Pdef(\charger,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \soundfx,
            \n, Pseq([4], inf),
            \speed, Pseq([Prand([0.2, 0.5, 1, 2])], inf),
            \dur, Pseq([8, Rest(6)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([1, 0.75, 0.25, 0], inf),
            \comb, Pseq([Prand([0.2, 0.5, 0.8])], inf),
            \hbrick, Pseq([Pwrand([0, 0.1, 0.2],[0.7, 0.2, 0.1])], inf),
            \gain, 0.7,
            \orbit, ~out1_2
        )
    ])
);

//// tester ////////////////////////////////////////////////////////////////////
Pdef(\seqtest,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \cr,
            \n, Pseq([1, 0, 1, 5], inf),
            \speed, 1,
            \dur, 1,
            \gain, 0.7,
            \orbit, ~out1_2
        )
    ])
);

//// cymbals ///////////////////////////////////////////////////////////////////
Pdef(\cymbals,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \cr,
            \n, Pseq([1, 0, 1, 5], inf),
            \speed, Pseq([Prand([0, 0.1, 0.15])], inf),
            \dur, Pseq([Prand([5, 10])], inf),
            // \dur, Pseq([Prand([3])], inf),
            \crush, 6,
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([1, 0.75, 0.25, 0], inf),
            \comb, 0.5,
            \hbrick, Pseq([Pwrand([0, 0.1, 0.2],[0.7, 0.2, 0.1])], inf),
            \enhance, 0.05,
            \gain, 0.6,
            \orbit, ~out1_2
        )
    ])
);

//// twinkle ///////////////////////////////////////////////////////////////////
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
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \freqs, Pfunc({50.0.rrand(4000)}.dup(12)),
            \rings, Pfunc({0.1.rrand(2)}.dup(12)),
            \speed, 1,
            \dur, 10,
            \gain, 1,
            \orbit, ~out1_2
        )
    ])
);

//// haunted ///////////////////////////////////////////////////////////////////
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
        \amp, Pkey(\harmonic).reciprocal * 0.2,
        \pan, Pwhite(-0.8, 0.8, inf),
        \gain, 0.4,
        \orbit, ~out1_2
    );
);

//// gravity ///////////////////////////////////////////////////////////////////
Pdef(\gravity,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, 'form-msp5',
            \n, Pseq([8], inf),
            \speed, Pseq([Prand([5, 0.2, 0.1, 0.5, 1.2, 2, 0.8])], inf),
            \dur, Pseq([8, Rest(4)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0, 0.25, 0.75], inf),
            \size, Pseq([0.75, 0.25, 0], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);

//// cellophane ////////////////////////////////////////////////////////////////
Pdef(\cellophane,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \Paper,
            \n, Pseq([0], inf),
            \speed, Pseq([Prand([2, 1, 0.6])], inf),
            \dur, Pseq([16, Rest(8)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0, 0.25, 0.75, 1], inf),
            \size, Pseq([1, 0.75, 0.25, 0], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);

//// paper /////////////////////////////////////////////////////////////////////
Pdef(\paper,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \Paper,
            \n, Pseq([Prand([1,2,3,4,5,6,7])], inf),
            \speed, Pseq([Prand([2, 1, 0.6])], inf),
            \dur, Pseq([16, Rest(8)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0.75, 0.25, 0], inf),
            \size, Pseq([0.75, 0.25, 0], inf),
            \gain, 0.8,
            \orbit, ~out1_2
        )
    ])
);

//// pad ///////////////////////////////////////////////////////////////////////
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
);

//// pad2 //////////////////////////////////////////////////////////////////////
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
);

//// bells /////////////////////////////////////////////////////////////////////
Pdef(\bell_1,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \prayer_bell,
            \dur, Pseq([8, 20], inf),
            // \dur, Pseq([5, 5], inf),
            \freq, Pseq([800, 500], inf),
            \amp, 0.5,
            \lag, 0,
            \trig, Pseq([0.1], inf) * Pwhite(0.5, 1, inf) * Pwrand([0, 1], [1, 5].normalizeSum, inf),
            \sing_switch, Pseq((0!4) ++ (1!4), inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \delay, 0.8,
            \delayt, 0.1,
            \delayfb, 0.8,
            \room, Pseq([0.75, 0.25, 0], inf),
            \size, Pseq([0.75, 0.25, 0], inf),
            \gain, 0.9,
            \orbit, ~out1_2
        )
    ])
);

Pdef(\bell_2,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \prayer_bell,
            \dur, Pwhite(8, 20, inf),
            \trig, Pwhite(0.05, 0.09),
            \sing_switch, Pwrand([0, 1], [5, 3].normalizeSum, inf),
            \freq, Prand((240, 360 .. 2000), inf),
            \amp, 0.3,
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \gain, 0.9,
            \orbit, ~out1_2
        )
    ])
);

Pdef(\bell_3,
    Ppar([
        Pmono(\prayer_bell,
            \freq, 100,
            \dur, 1,
            \trig, 0,
            \sing_switch, Pwrand([0, 1], [10, 3].normalizeSum, inf),
            \amp, Pwhite(0.1, 0.4)
        ),
        Pmono(\prayer_bell,
            \freq, 200,
            \dur, 3,
            \trig, 0,
            \sing_switch, Pwrand([0, 1], [10, 3].normalizeSum, inf),
            \amp, Pwhite(0.1, 0.3)
        ),
        Pmono(\prayer_bell,
            \freq, 300,
            \dur, 1,
            \trig, 0,
            \sing_switch, Pwrand([0, 1], [10, 3].normalizeSum, inf),
            \amp, Pwhite(0.1, 0.4)
        )
    ])
);

/*Pdef(\bell_3,
Ppar([
Pbind(
\type, \dirt,
\s, \prayer_bell,
\freq, 100,
\dur, 16,
\trig, 1,
\sing_switch, Pwrand([0, 1], [10, 3].normalizeSum, inf),
\amp, Pwhite(0.1, 0.4),
\pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
\gain, 0.9,
\orbit, ~out1_2
),
Pbind(
\type, \dirt,
\s, \prayer_bell,
\freq, 200,
\dur, 16,
\trig, 1,
\sing_switch, Pwrand([0, 1], [10, 3].normalizeSum, inf),
\amp, Pwhite(0.1, 0.4),
\pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
\gain, 0.9,
\orbit, ~out1_2
),
Pbind(
\type, \dirt,
\s, \prayer_bell,
\freq, 300,
\dur, 16,
\trig, 1,
\sing_switch, Pwrand([0, 1], [10, 3].normalizeSum, inf),
\amp, Pwhite(0.1, 0.4),
\pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
\gain, 0.9,
\orbit, ~out1_2
)
])
);*/

//// noise /////////////////////////////////////////////////////////////////////
Pdef(\noise,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \supernoise,
            // \dur, Pseq([8, Rest(1)], inf),
            \dur, Pseq([4, Rest(1)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \distort, 0.3,
            // \cutoff, Pseq([1750, 5000, 10000]),
            \resonance, Pseq([0.9, 0.2, 0.3], inf),
            \phaserrate, 0.4,
            \phaserdepth, 0.6,
            // why no workie?!
            // \delaytime, 0.4,
            // \delayfeedback, 0.5,
            // \delaySend, 1,
            \gain, 0.85,
            \orbit, ~out1_2
        ),
        Pbind(
            \type, \dirt,
            \s, \superstatic,
            \freq, Pseq([Pwrand([100, 500, 1000, 1500, 2000], [5, 3, 2, 3, 6].normalizeSum)], inf),
            \dur, Pseq([8, Rest(3)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \crush, 4,
            \distort, 0.1,
            \gain, 0.75,
            \orbit, ~out1_2
        )
    ])
);


//// chimes ///////////////////////////////////////////////////////////////////
Pdef(\chimes,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \soundfx,
            \n, Pseq([Prand([5,6,7])], inf),
            \speed, Pseq([Prand([0.1, 0.6, 1, 2])], inf),
            \dur, Pseq([16, Rest(8)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \gain, 0.9,
            \orbit, ~out1_2
        )
    ])
);

//// modular ///////////////////////////////////////////////////////////////////
Pdef(\modular,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \modular,
            \n, Pseq([Prand([0,1,2])], inf),
            \speed, Pseq([Prand([0.5, 1, 2])], inf),
            \dur, Pseq([4, Rest(4)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0.5, 0.25, 0], inf),
            \size, Pseq([0.5, 0.25, 0], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);

//// scissors //////////////////////////////////////////////////////////////////
Pdef(\scissors,
    Ppar([
        Pbind(
            \type, \dirt,
            \s, \soundfx,
            \n, Pseq([Prand([8,9,10])], inf),
            \speed, Pseq([Prand([0.5, 1, 2])], inf),
            \dur, Pseq([4, Rest(4)], inf),
            \pan, Pseq([Prand([0, 0.25, 0.75, 1])], inf),
            \room, Pseq([0.5, 0.25, 0], inf),
            \size, Pseq([0.5, 0.25, 0], inf),
            \gain, 0.85,
            \orbit, ~out1_2
        )
    ])
);





"".postln;
"List all sequences........".postln;
Pdef.all.do(_.postln);

PdefAllGui(20);
)