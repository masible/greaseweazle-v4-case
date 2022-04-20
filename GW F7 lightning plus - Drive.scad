drive_width = 101.6;
drive_height = 25.4;
drive_depth = 150;




module bottom_holes_y() {
    translate([0, 35]) children();
    translate([0, 105]) children();
}

module bottom_holes() {
    translate([3.7 - drive_width/2, 0]) bottom_holes_y() children();
    translate([drive_width/2 - 3.7, 0]) bottom_holes_y() children();
}

module side_holes_y() {
    translate([0, 25]) children();
    translate([0, 85]) children();
    translate([0, 115]) children();
}

module side_holes() {
    
    translate([0, 0, 6.35]) {
        translate([drive_width/2, 0])rotate([0, 90, 0]) side_holes_y() children();
        translate([-drive_width/2, 0]) rotate([0, -90, 0]) side_holes_y() children();
    }
}



module diskslot() {
    translate([0, 0, 16]) {
        translate([0, 4]) cube([90, 4, 4], center=true);
        hull() {
            translate([0, 1]) cube([90, 2.1, 4], center=true);
            translate([0, -1]) cube([94, 1, 9], center=true);
        }
    }
    
    translate([0, 0, 12.7]) {
        hull() {
            translate([0, 4.1, 3.3]) cube([29, 2, 7], center=true);
            translate([0, -1]) cube([34, 1, 20], center=true);
        }
    }
}


module bezel(colour="beige") {
    color(colour) {
        difference() {
            translate([-drive_width/2, 0]) cube([drive_width, 4.01, drive_height]);
            diskslot();
            translate([30, 0, 5]) cube([14, 10, 6], center=true);
            translate([-32, 0, 5]) cube([6, 10, 2], center=true);
        }
        translate([30, 0, 5]) cube([13, 10, 5], center=true);
        translate([0, 5, 16]) cube([90, 1, 10], center=true);
        
    }
    color([1, 0.5, 0]) translate([-32, 1, 5]) cube([6, 1, 2], center=true);
}


module drive(colour="beige") {
    
    difference() {
        translate([-drive_width/2, 4]) color("lightgrey") cube([drive_width, drive_depth-4, drive_height]);
        translate([-drive_width/2 + 1, 3, 1]) color([0, 0, 0]) cube([drive_width-2, drive_depth-4, drive_height-2]);
        color("black") {
            
            bottom_holes() cylinder(d=3, h=10, center=true);
            side_holes() cylinder(d=3, h=10, center=true);
        }
    }
    bezel(colour);
}


module drive_block() {
    difference() {
        translate([-(drive_width+0.4)/2, -1, -0.2]) cube([drive_width+0.4, drive_depth+1, drive_height+0.4]);
    }
}
