// box

$fn=32;


module mirrorkeep(x) {
    children();
    mirror(x) children();
}


module offset_diff(d) {
    difference() {
        offset(d[0]) children();
        offset(d[1]) children();
    }
}


module fill() {
    for (i = [-10:10]) {
        translate([0, i*30]) square([500, 1.2], center=true);
    }
}


module shell(height, thickness, wall, top, gap=1, brace=true) {
    linear_extrude(height=thickness, convexity=2) children();
    linear_extrude(height=height-(gap/2), convexity=2) offset_diff([0, -wall]) children();
    linear_extrude(height=height+(top?2-(gap/2):2+(gap/2)), convexity=2)
        offset_diff(top ? [0, 0.1-wall/2] : [-wall/2, -wall]) children();
    
    if (brace) linear_extrude(height=3, convexity=4) intersection() {
        union() {
            rotate(45) fill();
            rotate(-45) fill();
        }
        children();
    }
}


module outline(size, radius) {
    offset(radius) offset(-radius) square(size, center=true);
}




module screw_pos(size, offset, screws) {
    p = [for (i = size) (i - (offset*2))];
    n = screws[0] - 1;
    for (i = [0:n]) {
        x = n == 0 ? 0 : (i/n) - 0.5;
        mirrorkeep([0, 1]) translate([x*p[0], 0.5*p[1]]) rotate(90) children();
    }
    m = screws[1] - 1;
    for (i = [0:m]) {
        x = m == 0 ? 0 : (i/m) - 0.5;
        mirrorkeep([1, 0]) translate([0.5*p[0], x*p[1]]) children();
    }
}


module bottom(size, radius, screws, height, thickness=1, wall=2, brace=true) {
    difference() {
        union() {
            shell(height, thickness, wall, false) outline(size, radius);
            linear_extrude(height=height, convexity=5) intersection() {
                offset(-(wall/2)-0.1)outline(size, radius);
                union() {
                    screw_pos(size, radius, screws) hull() {
                        circle(r=radius-wall);
                        translate([radius*2, 0]) circle(r=radius-wall+0.5);
                    }
                }
            }
        }
        translate([0, 0, -0.1]) screw_pos(size, radius, screws) {
            cylinder(d=6.0, h=height-4);
            cylinder(d=3.4, h=height+1);
        }
    }
}


module top(size, radius, screws, height, thickness=1, wall=2, brace=true) {
    difference() {
        union() {
            shell(height, thickness, wall, true, brace=brace) outline(size, radius);
            linear_extrude(height=height-0.5, convexity=5) intersection() {
                offset(-wall/2) outline(size, radius);
                union() {
                    screw_pos(size, radius, screws) hull() {
                        circle(r=radius-wall);
                        translate([radius*2, 0]) circle(r=radius-wall+0.5);
                    }
                }
            }
            linear_extrude(height=height+2, convexity=5) intersection() {
                offset(-wall-0.1) outline(size, radius);
                union() {
                    screw_pos(size, radius, screws) hull() {
                        circle(r=radius-wall);
                        translate([radius*2, 0]) circle(r=radius-wall+0.5);
                    }
                }
            }            
        }
        translate([0, 0, height-5]) screw_pos(size, radius, screws) {
            cylinder(d=4, h=height);
            translate([0, 0, -2]) cylinder(d=2.5, h=height);
        }
    }
}


module all(size, radius, screws, height, thickness=1, wall=2) {
    top(size, radius, screws, height, thickness, wall);
    translate([size[0]+10, 0]) bottom(size, radius, screws, height, thickness, wall);
}


all([150, 250], 7, [3, 4], 10, 0.8, 2);
