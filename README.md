# pitchpipe
DIY electronic pitchpipe

A work in progress, and not everything is working yet - Jan 2025.

This is a design for a small electronic pitchpipe.
Features:
- 3W speaker with 3W amplifier - it should be loud enough to be heard across a fairly large chorus
- 12 buttons for the 12 pitches
- white buttons for the 7 pitches, with 1 led for each.
- black buttons for the 5 #/b pitches
- 2 side buttons for repeat last note, sustain, "shift"
- 1 3-position switch for volume control (chorus loud, quartet, quiet so that the director can't hear you playing a pitch)
- built in rechargeable battery with about 4hours of runtime (i.e. 4 hours of continuously playing a pitch) - at least the basic math shows it running that long
- USB-C 0.5A and 1A charging (not sure when to select which, and probably ends up being a compile option only), 2 or 4 hour charge time
- Can charge and run at the same time (at a reduced charging rate)
- Can possibly set the output frequency to be exactly the right pitch (better than 0.1cents=100ppm of the oscillator).
- It is possible to set the range of the pitches (i.e. C4-B4 or F4-E5).
- You can use your imagination to set more features using the side buttons to choose some new set of features.

This git repository contains:
- circuit board with schematic and PCB layout (order from oshpark for about $20 for 3 copies).
- enclosure to be 3d printed out of ABS or PETG - openscad & .STL & bambu
- C Source code for the pic microcontroller
- C Source code for the esp32c5 ARM processor (wifi and bluetooth not used)
- C Source code for windows command line application to program the pic microcontroller through USB
- instructions for compiling and programming all 3 applications using free compilers (Arduino, MPLAB, gcc/cygwin)
