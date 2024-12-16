include <lib/threads.scad>
include <lib/Round-Anything/polyround.scad>

$fn = 256;


h = 7;
d = 13.3;

module knob() {
    ScrewHole(6, h-1) {
        difference () {
            //$fn = 128; // for rotate_extrude
            rotate_extrude() polygon(polyRound([
                [0, 0, 0],
                [0, h+2.2, 0],
                [4/2, h+1.9, 0],
                [d/2, h, 0.3],
                [d/2, 0, 0.3]
            ], 32));
            
            cylinder(h=h, d=1);
        }
    }
}

knob();
