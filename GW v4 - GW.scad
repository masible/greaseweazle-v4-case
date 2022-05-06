$fn = 32;

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
    
    x = (72.650-(.66+2.15))/2;
    y = (48.560-(.66+2.15))/2;
    
    translate([x, y]) children();
    translate([-x, y]) children();
    translate([x, -y]) children();
    translate([-x, -y]) children();
}

module gw() {
    translate([0, 0, 6]) {
        color("darkgreen") difference() {
            cube([72.650, 48.560, 2], center=true);
            gw_holes() cylinder(d=1.86, h=10, center=true);
        }
        color("black") translate([6.825, -19.175, 6]) cube([50, 10, 10], center=true);
        color("white") translate([-26.745, -19.175, 4]) cube([10, 10, 5], center=true);
        color("grey") translate([-25.485, 17.175, 6.5]) cube([12, 14, 10.5], center=true);
    }
}


gw();