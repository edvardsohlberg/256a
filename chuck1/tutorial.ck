fun void addGraphics(Envelope env) {
    GTorus donut --> GG.scene();
    0 => donut.sca;
    Color.BLACK => donut.color;

    Math.random2f(-4, 4) => donut.posX;
    Math.random2f(-2.5, 2.5) => donut.posY;
    Math.random2f(-2, 1) => donut.posZ;
    Math.random2f(0, 6.28) => donut.rotZ;

    while (true){ //graphical loop
    GG.nextFrame() => now;
    env.value() * Color.BLUE => donut.color; // change color
    env.value() => donut.sca;
    }
}

fun void addVoice(float midi, dur note_dur, dur loop_dur, dur offset) {
    //dac is sound output;
    SqrOsc Vard => Envelope env => dac; 
    0.1 => Vard.gain;
    Std.mtof(midi) => Vard.freq;
    note_dur => env.duration;

    spork ~ addGraphics(env);

    offset => now;

    // user input 1
    while (true){
    GG.nextFrame() => now;
    Std.mtof(midi + Math.random2f(-.5, .5)) => Vard.freq; //silly noise generator
    if (GWindow.key(GWindow.Key_Space)) { 
        env.keyOn(); // silly noise on
    } else {
        env.keyOff();  // silly noise off
    }
    }
}

spork ~ addVoice(60, 7.7::second, 20.1::second, 1::second + 0.0::second); // C
spork ~ addVoice(63, 7.1::second, 16.2::second, 1::second + 1.9::second); // Eb
spork ~ addVoice(65, 8.5::second, 19.6::second, 1::second + 6.5::second); // F
spork ~ addVoice(53, 9.1::second, 24.7::second, 1::second + 6.7::second); // low F
spork ~ addVoice(68, 9.4::second, 17.8::second, 1::second + 8.2::second); // Ab
spork ~ addVoice(56, 7.9::second, 21.3::second, 1::second + 9.6::second); // low Ab
spork ~ addVoice(61, 9.2::second, 31.8::second, 1::second + 15.0::second); // Db

while(true){
GG.nextFrame() => now;

if (UI.begin("Tutorial")) {
    UI.scenegraph(GG.scene());
} 
UI.end(); // must match UI.begin()
}
