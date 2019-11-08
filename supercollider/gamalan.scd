////////////////////////////////////////////////////////////////////////////////
//
// GAMALAN GENERATOR
////
//
// README PLEASE :)
//
// You can either start a generative sequence below or manually trigger the sound
// The latter plays one shot but you can trigger mulitple times to layer.
//
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// START SEQUENCE
////////////////////////////////////////////////////////////////////////////////

(
// place cursor below this line and execute CMD + enter to PLAY

r = Routine{
    var sustain = 7, transition = 3, overlap = 4;
    var period = transition * 2 + sustain / overlap;
    0.5.wait;            // wait for the synthdef to be sent to the server
    inf.do{
        Synth(\gamaBell, [
            \atk, transition,
            // \amp, 1.0.rand,
            \amp, 0.5.rand,
            \sus, sustain,
            \rel, transition,
            \pan, 1.0.rand2,
            \freqs, {50.0.rrand(4000)}.dup(12),
            \rings, {0.1.rrand(2)}.dup(12)
        ]);
        "waiting for ".post;
        period.postln;
        period.wait;
    }
};
r.play;
)

// STOP SEQUENCE! /////////////////////////////////////////////////////////////

r.stop;


////////////////////////////////////////////////////////////////////////////////
// MANUAL TRIGGER
////////////////////////////////////////////////////////////////////////////////

(
// place cursor below this line and execute CMD + enter to PLAY

Synth(\gamaBell, [
    \atk, 2,
    \sus, 2,
    \rel, 3,
    \amp, 0.5.rand,
    \pan, 1.0.rand2,
    \freqs, {50.0.rrand(4000)}.dup(12),
    \rings, {0.1.rrand(2)}.dup(12)
]);

)