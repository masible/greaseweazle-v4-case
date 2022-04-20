module gw_pos() {
    translate([-14.4, 190, 0]) children();
}

module gw_holes() {
    /*
    for (y = [-1, 1]) {
        for (x = [-1, 1]) {
            translate([x*34.5, y*16.2]) children();
        }
    }
    */
    
    translate([-1, 30]) children();
    translate([30.0, -14]) children();
    translate([-30.0, -14]) children();
}

module gw() {
    translate([0, 0, 6]) {
        color("darkgreen") difference() {
            cube([64, 64, 2], center=true);
            gw_holes() cylinder(d=3, h=10, center=true);
        }
        color("black") translate([-7, -27, 6]) cube([50, 10, 10], center=true);
        color("white") translate([26.5, -27, 4]) cube([10, 10, 5], center=true);
        color("grey") translate([22.7, 25, 6.5]) cube([12, 14, 10.5], center=true);
    }
}


gw();