include <lib/threads.scad>
include <lib/utils.scad>

$fn = $preview ? 128 : 128;


h = 8;
d = 9;


module knob() {
    ScrewHole(6, h-1.5, [0,0,1.5]) {
        difference() {
            hull() {
                tr_z(1) cylinder(h = h-2, d = d);
                cylinder(h = h, d = d-2);
            }
            
            notches = 10;
            for(i = [0:notches-1]) {
                rotate_z(i * 360/notches)
                tr_x(d/2+0.7) cylinder(h = h, d = 2);
            }
        }
    }
}

knob();
