# Ring Oscillator PUF on FPGA

This is my final project for the Hardware Security Class at Rutgers. This project involved desinging, simulating, and implementing a Ring Oscillator PUF on a Zybo Z7-10.

## File Structure

Files that end with `test.vhd` are used for simulation, and the other files are used for synthesis. Because PUFs utilize process variation, the test files incorporate random and different
timing delays in. The other files are used for synthesis, and are otherwise identical outside of the items for timing delays.

## How to use

A bitstream is already generated targeting the Zybo Z7-10. If a different FPGA needs to be used, the constraint file will need to be modified accordingly. 

The PUF top level design utilizes 4 LEDs, 4 Buttons, and 4 Switches.

From left-most to right-most, the four buttons are:
1. MUX Select 2
2. MUX Select 1
3. LED Toggle
4. PUF Enable

The switches are used for generating a challenge input to the PUF. This can be done by:
1. Set the switches to a 4-bit value
2. Press the `MUX Select 1` button
3. Set the switches to another 4-bit value
4. Press the `MUX Select 2` button
5. Press the `PUF Enable` button

The switches are used to change the 4-bit select signal to both multiplexers, with the `MUX Select` buttons choosing which MUX select signal to update.

After pressing the `PUF Enable` button, the four LEDs will light up. The four LEDs correspond to the lower 4 bits of the difference in time between which any two selected Ring Oscillators oscillate 65,535 times.

The `LED Toggle` button will switch the LEDs to show the PUF output, the current MUX 1 select signal, and the current MUX 2 select signal. Changing a MUX select signal automatically
makes the LEDs show the new MUX select signal, and pressing the `PUF Enable` button automatically shows the output of PUF challenge.
