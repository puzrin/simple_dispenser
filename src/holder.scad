include <lib/Round-Anything/polyround.scad>

fn = $preview ? 10 : 40;
e = 0.01;

// From lever part: lever_wy - lever_w/2 - hinge_y = 49 - 8/2 - 28 = 17 
hinge_axis_offset = 17;

lever_w = 8;
lever_head_wz = 12.2;
lever_inner_wz = 5.9;

holder_id = 19.1;
holder_od = 29;
holder_h = 10;
holder_wall_top = 2;
holder_wall_vert = 2;

//support_edge = holder_id/2 + 10.5;
support_edge = hinge_axis_offset + lever_w/2;
support_w = 12;

hinge_h = 12;
hinge_rod_len = lever_head_wz + 0.5;

function radii_circle(r=1) = [[-r,-r, r], [-r,r,r], [r,r,r], [r,-r,r]];

module tr_z(z) { translate ([0, 0, z]) children(); }

module holder() {

    // Central part
    $fn = 128; // for rotate_extrude
    rotate_extrude() polygon(polyRound([
        [holder_id/2, 0, 0.5],
        [holder_id/2, holder_h, 0.5],

        [holder_od/2, holder_h, 1.25],
        [holder_od/2, holder_h - holder_wall_top, 1.25],

        [
            holder_id/2 + holder_wall_vert,
            holder_h - holder_wall_top - (holder_od/2 - holder_id/2 - holder_wall_vert)*2/3,
            0.5
        ],      
        [holder_id/2 + holder_wall_vert, 0, 0.5]
    ], fn));

    // hinge support
    difference () {

        translate([0, support_w/2, 0]) rotate([90, 0, 0])
        polyRoundExtrude([
            [0, 0, 0],
            [0, holder_h, 0],
            
            [support_edge, holder_h, 1],
            [support_edge, holder_h - holder_wall_top, 2],

            [support_edge - (holder_h - holder_wall_top), 0, 2],
        ], support_w, 1, 1, fn);
        
        cylinder(h = 30, d = holder_id+1, center=true);
    }
    
    // hinge + pin/hole
    translate([support_edge - lever_w, 0, holder_h])
    rotate([90,0,0])
    union() {
        tr_z(-lever_inner_wz/2)
        polyRoundExtrude([
            [0, -1, 0],
            [0, hinge_h, 5],
            [lever_w, hinge_h, 5],
            [lever_w, -1, 0]
        ], lever_inner_wz, 1, 1, fn);
        
        translate([lever_w/2, hinge_h - lever_w/2, -hinge_rod_len/2])
        polyRoundExtrude(radii_circle(3/2), hinge_rod_len, 1, 1, fn);
    }
}

//rotate([90, 0, 0]) lever();
holder();
