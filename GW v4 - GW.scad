$fn = 32;

module gw_pos() {
    translate([-14.4, 190, 0]) children();
}

board_w = 72.240;
board_h = 48.140;
hole_d = 2;

module gw_holes() {
    // floppy connector
    x1 = (board_w-(.53+hole_d))/2;
    y1 = (board_h-(.66+hole_d))/2;
    translate([x1, -y1]) children();
    
    // power connector
    x2 = (board_w-(.66+hole_d))/2;
    y2 = (board_h-(.65+hole_d))/2;
    translate([-x2, -y2]) children();

    // USB connector
    x3 = (board_w-(.75+hole_d))/2;
    y3 = (board_h-(.6+hole_d))/2;
    translate([-x3, y3]) children();

    x4 = (board_w-(.61+hole_d))/2;
    y4 = (board_h-(.49+hole_d))/2;
    translate([x4, y4]) children();
}

module gw() {
    translate([0, 0, 6]) {
        color("darkgreen") difference() {
            cube([board_w, board_h, 2], center=true);
            gw_holes() cylinder(d=hole_d, h=10, center=true);
        }
        //color("red") translate([-10, -19.175, 1]) linear_extrude(height = 1) text("Floppy");
        color("black") translate([6.825, -19.175, 6]) cube([50, 10, 10], center=true);
        color("white") translate([-26.745, -19.175, 4]) cube([10, 10, 5], center=true);
        color("grey") translate([-25.485, 17.175, 6.5]) cube([12, 14, 10.5], center=true);
    }
}


gw();