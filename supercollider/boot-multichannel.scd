(
////////////////////////////////////////////////////////////////////////////////
//
// BOOT MULTICHANNEL
//
//
// This file needs to be copied into the Supercollider startup file.
// Clock File > Open Startup File and cut and paste the contents wholesale into that.
//
////////////////////////////////////////////////////////////////////////////////


// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html

s.options.numBuffers = 1024 * 256;
s.options.memSize = 8192 * 32;
s.options.maxNodes = 1024 * 32;
s.options.numOutputBusChannels = 5;
s.options.numInputBusChannels = 2;

// SET YOUR AUDIO DEVICE HERE ////////////////////////////////////////////////
//
// You should see all audio devices listed in the post window when you start SuperCollider
//
// s.options.device = "Saffire 6USB";

// boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(5, s); // two output channels, increase if you want to pan across more channels
    // ~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
    ~dirt.loadSoundFiles("/Users/TouringMac/Dropbox/oily-cart-awu-samples/*");

	// s.sync; // optionally: wait for samples to be read
	~dirt.start(57120, 0 ! 12);   // start listening on port 57120, create two busses each sending audio to channel 0

	// optional, needed for convenient access from sclang:
	(
		~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
		~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
		~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
		~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	);
};

s.latency = 0.3; // increase this if you get "late" messages
);