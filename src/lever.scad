include <lib/Round-Anything/polyround.scad>

fn = $preview ? 10 : 40;
e = 0.01;

lever_w = 8;
lever_wx = 82;
lever_wy = 49;
lever_wz = 10.2;
lever_head_wz = 12.2;

wall = 2;
lever_inner_wz = 5.9;

hinge_y = 28;
hinge_outer_d = 17;
hinge_innner_d = 10;
hinge_wz = 14.3;

function radii_circle(r=1) = [[-r,-r, r], [-r,r,r], [r,r,r], [r,-r,r]];

module tr_z(z) { translate ([0, 0, z]) children(); }

module tr_to_hinge() {
    translate([lever_w/2, hinge_y, 0]) children();
}

module lever() {
    lever1_radiiPoints = [
        [0, 0, 15],
        [0, hinge_y-5, 0],
        [lever_w, hinge_y-5, 0],
        [lever_w, lever_w, 15 - lever_w],
        [lever_wx, lever_w, 1],
        [lever_wx, 0, 1],
                
        // finger slot
        [lever_wx - wall, 0, 10],
        [lever_wx - wall - 30/2, lever_w, 100],
        [lever_wx - wall - 30, 0, 10],
    ];

    lever1_inner_radiiPoints = [
        [0, 0, 15 -wall],
        [0, /*lever_wy*/ hinge_y-5, 0],
        [lever_w, /*lever_wy*/ hinge_y-5, 0],
        [lever_w, lever_w, 15 - lever_w -wall],
        [lever_wx -(wall*2), lever_w, 0],
        //[lever_wx, 0, 1],
                
        // finger slot
        [lever_wx - wall -(wall), 0, 5],
        [lever_wx - wall - 30/2 -(wall), lever_w, 100],
        [lever_wx - wall - 30 -(wall), 0, 0],
    ];

    lever2_radiiPoints = [
        [0, hinge_y+5, 0],
        [0, lever_wy, lever_w/2],
        [lever_w, lever_wy, lever_w/2],
        [lever_w, hinge_y+5, 0]
    ];

    difference() {

        union () {
            tr_z(-lever_wz/2)
            polyRoundExtrude(lever1_radiiPoints, lever_wz, 1, 1, fn);

            tr_to_hinge() tr_z(-hinge_wz/2)
            polyRoundExtrude(radii_circle(hinge_outer_d/2), hinge_wz, 1, 1, fn);

            tr_z(-lever_head_wz/2)
            polyRoundExtrude(lever2_radiiPoints, lever_head_wz, 1, 1, fn);
            
            
        }

        // Inner
        translate([wall,wall,0])
        tr_z(-lever_inner_wz/2)
        polyRoundExtrude(lever1_inner_radiiPoints, lever_inner_wz, 0.5, 0.5, 10);
                
        translate([0, 100/2 + hinge_y - hinge_outer_d/2 + 1, 0])
        cube([100, 100, lever_inner_wz], center=true);

        // Roller hole
        tr_to_hinge() tr_z(-hinge_wz/2 -e)
        polyRoundExtrude(radii_circle(hinge_innner_d/2), hinge_wz + e*2, -1, -1, fn);
        
        // Parts connector hole
        translate([lever_w/2, lever_wy - lever_w/2, -20/2])
        polyRoundExtrude(radii_circle(3.3/2), 20, 0, 0, fn);
    };
    
}

rotate([90, 0, 0])
lever();
