// Case for Greaseweazle v4 board and 3.5" floppy drive
// License: CC BY-SA 4.0

use <GW v4 - Box.scad>;
use <GW v4 - GW.scad>;
include <GW v4 - Drive.scad>;

$fn = 32;
drive_width = 101.6;
drive_height = 25.4;
drive_depth = 150;
distance_drive_to_back = 68;

module gw_pos() {
    translate([12, 190.825, 0]) children();
}

module cutouts() {
    
    // Floppy drive port
    translate([0,0,6]) drive_block();

    // USB port
    translate([-13.525, drive_depth + distance_drive_to_back, 12.5]) cube([12.5, 12, 12], center=true);
}

module case_top() { 
    difference() {
        translate([0, 0, drive_height+12.2]) mirror([0, 0, 1])
            translate([0, (drive_depth + distance_drive_to_back)/2])
                top([drive_width+27, drive_depth + distance_drive_to_back], 7, [2, 4], height=drive_height-1, thickness=1.6, brace=false);
        cutouts();
    }
}

module case_bottom() {
    difference() {
        union() {
            translate([0, (drive_depth + distance_drive_to_back)/2])
                bottom([drive_width+27, drive_depth + distance_drive_to_back], 7, [2, 4], height=11, thickness=1.6);
            bottom_holes() cylinder(d=14, h=5.8);            
        }
 
        translate([0, 0, -0.1]) bottom_holes() {
            cylinder(d=8, h=4);
            cylinder(d=3.8, h=7);
        }
        
        cutouts();
    }
   
    difference() {
        gw_pos() gw_holes() cylinder(d=6.5, h=5);
        translate([0, 0, 2]) gw_pos() gw_holes() cylinder(d=3.15, h=5);
    }
}

module bottom_cube() {
     translate([-100, -0.1, -0.1])
     cube([200, 85.1, 50], center=false);
}

module case_bottom_front() {
    intersection() {
        case_bottom();
        bottom_cube();
    }
}

module case_bottom_back() {
    difference() {
        case_bottom();
        bottom_cube();
    }
}

module top_cube() {
    translate([-100, 39, 0])
    cube([200, 140, 100]);
}

module case_top_middle() {
    intersection() {
        case_top();
        top_cube();
    }
}

module case_top_front() {
    difference() {
        case_top();
        union() {
            top_cube();
            translate([-100, 130, 0])
            cube([200, 200, 200]);
        }
    }
}

module case_top_back() {
    difference() {
        case_top();
        union() {
            top_cube();
            translate([-100, 0, 0])
            cube([200, 40, 200]);
        }
    }
}

// Include the floppy drive model
//translate([0, -0.1, 5]) drive(colour="lightgrey");

// Include greaseweazle model
//gw_pos() gw();

intersection() {
    union() {
        
        // Case - bottom
        color("grey", 1) case_bottom();
        
        // Case - top
        color("orange", 0.5) case_top();
    }
}

