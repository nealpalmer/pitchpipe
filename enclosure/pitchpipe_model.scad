
VERSION = "r1";
// Version 1:
// Cons:
// - Didn't have the version number in the plastic.
// - Lid doesn't fit completely flush.  Need to subtract 0.1mm from the battery end of the lid and base.
// - Side button indents seem to have too small of a sphere radius.  Need to see how hard it is to press the buttons.
// - Took 1hr5min to print
// - Between base and lid has an apparent gap.  I should probably add a feature to fix:  2 more screws?  top/bottom clips?  Battery slide in cover+ screw down button cover?
// - M3 screws into plastic will need a smaller hole than 3.0mm.  Haven't tried the insertable nuts yet (might not bother).
// - volume switch seems VERY small
// - forgot to put holes in the lid for the leds.
// Pros:
// - Feels small in my hand.
// - Top button holes feel pretty good.
// - 15% gyroid, 2 wall shells, 3 bottom&top solid makes a pretty sturdy case out of PLA.
// - good print, no mess, no apparent overhang issues
// - M3 screws sit pretty flush.


INCH = 25.4;

WALL = 3;

SPKR_D = 1.1*INCH;
SPKR_D2 = 0.5*INCH;
SPKR_H = 6;

SCREW_D = 3;
SCREW_LEN = 18;
SCREW_HEAD_D = 6;
SCREW_HEAD_H = 3;
NUT_Z = WALL+WALL;
NUT_W = 5.5;
NUT_H = 2.4;

BUTTON_H = 7;
BUTTON_D = 3;
BUTTON_W = 5;
BUTTON_SIDE_Y = 31;
BUTTON_SIDE_Z = 4.1;
BUTTON_SIDE_D = 3.4;
BUTTON_SIDE_LEN = (5.85-2.5-0.35); // should be 3mm
BUTTON_SIDE_W = 7;
BUTTON_SIDE_L = 8;
BUTTON_SIDE_H = 7.5;

//BATT_W = 36;
//BATT_L = 60;
//BATT_H = 7;
BATT_L = 34; // amazon 103450 battery
BATT_W = 50;
BATT_H = 10;

ESP_W = 0.7*INCH;
ESP_L = 0.7*INCH;
ESP_H = 0.062*INCH+0.1*INCH;
USB_L = 9;
USB_H = 3;
USB_STICK_OUT = 1.7; // need to re-measure me.
USB_Y = 0;
USB_Z = 0;
USB_CONN_W = 8.3+0.7;
USB_CONN_H = 2.65+0.35;
USB_CABLE_W = 12.2+0.8;
USB_CABLE_H = 6.3+0.7;
ESP_BUTTONS_D = 1.5;
ESP_BUTTONS_XY = [
	[18,4.5],
	[18,13.25]
];

PIC_W = 7.8;
PIC_L = 7.2;
PIC_H = 2.0;

PCB_W = 54;
PCB_L = 44;
PCB_H = 0.062*INCH;

LEDGE_W = 2;
LEDGE_TOP = 1;
LEDGE_H = 3;

SWITCH_W = 12.6; // OS103011
SWITCH_L = 4.3;
SWITCH_H = 4.0;
SWITCH_H2 = 4+4;
SWITCH_TRAVEL = 6;
SWITCH_X = 13.462;
SWITCH_Y = 13.208;

MCLR_W = 1.7+0.2;
MCLR_L = 2.5+0.2;
MCLR_H = 1;
MCLR_X = 4.5;
MCLR_Y = 9.3;
MCLR_D = 1;

CORNER_QUALITY = 40;

ESP_BUTTONS_H = PCB_H+0.1+PCB_H+1.5;

W = WALL+PCB_W+WALL;
L = PCB_L+WALL+WALL+BATT_L;
H = WALL+(BATT_H+1)+(BUTTON_H+1); // 22mm thick
SPLIT = H-8; // where the base and lid split apart
CORNER_R = 2;

SPKR_X = W/2;
SPKR_Y = L-WALL-SPKR_D/2;

screws_xy = [
	//[6,6],
	//[W-6,6],
	//[WALL+SCREW_D/2,L-(WALL+SCREW_D/2)],
	//[W-(WALL+SCREW_D/2),L-(WALL+SCREW_D/2)]
	[WALL+3,L-(WALL+3)],
	[W-(WALL+3),L-(WALL+3)]
];

buttons = [
	[12+0*7.5,PCB_L-9,"white",90],   // 12,   35
	[12+1*7.5,PCB_L-9+4,"black",0], // 19.5, 39
	[12+2*7.5,PCB_L-9,"white",90],   // 27,   35
	[12+3*7.5,PCB_L-9+4,"black",0], // 34.5, 39
	[12+4*7.5,PCB_L-9,"white",90],   // 42,   35

	[4.5+0*7.5,PCB_L-22,"white",90],   // 4.5,  22
	[4.5+1*7.5,PCB_L-22+4,"black",0], // 12,   26
	[4.5+2*7.5,PCB_L-22,"white",90],   // 19.5, 22
	[4.5+3*7.5,PCB_L-22+4,"black",0], // 27,   26
	[4.5+4*7.5,PCB_L-22,"white",90],   // 34.5, 22
	[4.5+5*7.5,PCB_L-22+4,"black",0], // 42,   26
	[4.5+6*7.5,PCB_L-22,"white",90],   // 49.5, 22
];
BUTTON_DEPRESSION_R = 17;

// outside of the box
module box(is_lid) {
 // color("gray")
//intersection() {
 //cube([W+1,L+1,SPLIT])

difference() {
 if (0) 
		// square corners everywhere
 	cube([W,L,H /*(is_lid ? H : SPLIT)*/]);
 else {
		// rounded corners for bottom 7/8th
	hull() {
		for (x=[CORNER_R,W-CORNER_R], y=[CORNER_R,L-CORNER_R], z=[CORNER_R,SPLIT+WALL-CORNER_R])
			translate([x,y,z])
				sphere(r=CORNER_R,$fn=CORNER_QUALITY);
	}
		// rounded corners for top  1/8th
	hull() {
		for (x=[CORNER_R,W-CORNER_R], y=[1+WALL+BATT_L+0,L-CORNER_R], z=[CORNER_R])
			translate([x,y,z])
				sphere(r=CORNER_R,$fn=CORNER_QUALITY);
		for (x=[CORNER_R,W-CORNER_R], y=[1+WALL+BATT_L+13,L-CORNER_R], z=[H-CORNER_R])
			translate([x,y,z])
				sphere(r=CORNER_R,$fn=CORNER_QUALITY);
	}
 	//cube([W,L,H /*(is_lid ? H : SPLIT)*/]);
 }
	// general top depression
 //translate([3,3,H-3])
 	//cube([W-6,L-6,3+1]);
 if (is_lid) {
	translate([-0.5,-0.5,-0.1])
		cube([W+1,L+1,SPLIT+0.1]);

	difference() {
		translate([-0.5,-0.5,SPLIT-0.01])
			cube([W+1,WALL+0.5,WALL+0.1]);
		hull() {
			translate([WALL,WALL/2,SPLIT])
				cube([W-2*WALL,WALL,0.0001]);
			translate([WALL,WALL,SPLIT+WALL/2])
				cube([W-2*WALL,WALL,0.0001]);
		}
	}
 } else {
	translate([-0.5,WALL,SPLIT])
		cube([W+1,L+1,H]);
		// notch for top to fit into
	hull() {
		translate([WALL,WALL/2,SPLIT])
			cube([W-2*WALL,WALL,0.0001]);
		translate([WALL,WALL,SPLIT+WALL/2])
			cube([W-2*WALL,WALL,0.0001]);
	}
 }

	// depression above battery
 if (0)
 hull() {
 	translate([-1,-1,SPLIT+WALL])
		cube([W+2,1+WALL+BATT_L+10,10]);
 	translate([-1,-1,H])
		cube([W+2,1+WALL+BATT_L+13,10]);
 }

	// general inside hole
 difference() {
 	translate([WALL,WALL,WALL])
 		cube([W-2*WALL,L-2*WALL,SPLIT-WALL+0.01]);

		// screw bosses
	for (xy=screws_xy)
		translate([xy[0],xy[1],0.1])
			cylinder(d=SCREW_D+WALL*2,h=SPLIT-0.1-PCB_H,$fn=20);

		// speaker mount
	difference() {
		translate([SPKR_X,SPKR_Y,WALL-0.01])
			cylinder(d=SPKR_D+WALL*2,h=WALL,$fn=60);
		translate([SPKR_X,SPKR_Y,WALL])
			cylinder(d=SPKR_D,h=WALL,$fn=60);
	}

		// battery compartment
	translate([0.1,WALL+BATT_L,0.1])
		cube([W-0.2,WALL,WALL+4-0.1]);

		// PCB edges
	for (xylr=[ [WALL,WALL+BATT_L+ESP_L+0.5,20,0], [WALL,L-WALL,W-2*WALL,90], [W-WALL,L-WALL,PCB_L,180] ]) {
		translate([xylr[0],xylr[1],SPLIT-PCB_H]) 
		rotate(v=[0,0,-1],a=xylr[3])
		hull() {
			translate([-LEDGE_W,0,-LEDGE_TOP])
				cube([LEDGE_W*2,xylr[2],LEDGE_TOP]);
			translate([-0.0001,0,-LEDGE_H])
				cube([0.0001,xylr[2],LEDGE_TOP]);
		}
	}

		// ESP buttons BOSS
 	for (xy = ESP_BUTTONS_XY) {
		translate([WALL+xy[0],L-WALL-PCB_L+xy[1],0]) {
			cylinder(d=ESP_BUTTONS_D+4,h=SPLIT-PCB_H-ESP_BUTTONS_H,$fn=15);
		}
 	}

		// PCB support near battery
	translate([WALL,WALL+BATT_L+1.7/2,0])
	hull() {
		for (x=[21+1.7/2,32-1.7/2]) translate([x,0,0])
			cylinder(d=1.7,h=SPLIT-PCB_H,$fn=20);
	}
	
		// version text for base
	translate([W/2,WALL+BATT_L+WALL+2,WALL-0.01])
	linear_extrude(0.5)
		text(text=VERSION,size=8);

 }

		// version text for lid
	translate([W/2+7,WALL+BATT_L+WALL+8,SPLIT-0.01])
	scale([-1,1,1])
	linear_extrude(0.3)
		text(text=VERSION,size=8);

	// top buttons cut-outs
 translate([WALL,L-WALL-PCB_L,SPLIT-PCB_H])
 for (xy = buttons)
	translate([xy[0],xy[1],PCB_H])
	rotate(a=xy[3],v=[0,0,1]) {
		hull() 
			button(xy[2],BUTTON_H-3); // the shorter hull() makes it have a nice shaft at the top
		button(xy[2],BUTTON_H);
	}

	// side buttons
 translate([WALL,L-WALL-PCB_L,SPLIT-PCB_H]) {
	translate([0,BUTTON_SIDE_Y,-BUTTON_SIDE_Z]) {
		translate([5.555,0,0]) {
				// hole for button shaft
			rotate(a=-90,v=[0,1,0])
				cylinder(d=BUTTON_SIDE_D+0.5, h=BUTTON_SIDE_LEN+10.555, $fn=30);

				// finger indent
			translate([-5.555-WALL-(5-1.5),0,0])
				sphere(r=5,$fn=30);

				// cut for switch body
			translate([-5.555,BUTTON_SIDE_L/-2,-BUTTON_SIDE_H+BUTTON_SIDE_Z+0.01])
				cube([BUTTON_SIDE_W,BUTTON_SIDE_L,BUTTON_SIDE_H]);
		}
		translate([PCB_W-5.555,0,0]) {
				// hole for button shaft
			rotate(a=90,v=[0,1,0])
				cylinder(d=BUTTON_SIDE_D+0.5, h=BUTTON_SIDE_LEN+10.555, $fn=30);

				// finger indent
			translate([5.555+WALL+(5-1.5-0.75),0,0])
				sphere(r=5,$fn=30);

				// cut for switch body
			translate([5.555-BUTTON_SIDE_W-0.75,BUTTON_SIDE_L/-2,-BUTTON_SIDE_H+BUTTON_SIDE_Z+0.01])
				cube([BUTTON_SIDE_W,BUTTON_SIDE_L,BUTTON_SIDE_H]);

				// vertical slot to insert button
			translate([5.555-0.1-3,0,0])
			hull() {
				rotate(a=90,v=[0,1,0])
					cylinder(d=BUTTON_SIDE_D+0.5,h=BUTTON_SIDE_LEN+3-1+0.1,$fn=30);
				translate([0,-(BUTTON_SIDE_D+0*0.5)/2,BUTTON_SIDE_Z+PCB_H-1+0.001])
					//rotate(a=90,v=[0,1,0])
						//cylinder(d=BUTTON_SIDE_D+0.5,h=BUTTON_SIDE_LEN+3-1+0.1,$fn=30);
						cube([BUTTON_SIDE_LEN+3-1+0.1,BUTTON_SIDE_D+0*0.5,1]);
			}
		}
		// do something with BUTTON_SIDE_L cutout in the support ridges
	}
 }

	// MCLRn button
 translate([WALL+MCLR_X,L-WALL-PCB_L+MCLR_Y,SPLIT-0*PCB_H]) {
	cylinder(d=MCLR_D+0.2,h=100,$fn=15);
	cube([MCLR_W,MCLR_L,MCLR_H*2],center=true);

 }

	// ESP buttons access holes
 for (xy = ESP_BUTTONS_XY) {
	translate([WALL+xy[0],L-WALL-PCB_L+xy[1],0]) {
		cylinder(d=ESP_BUTTONS_D+0.2,h=SPLIT,$fn=15);
	}
 }

	// volume switch
	// switch
 translate([WALL,L-WALL-PCB_L,SPLIT]) {
	hull () {
		translate([SWITCH_X-SWITCH_W/2-0.1,SWITCH_Y-SWITCH_L/2-0.1,0])
			cube([SWITCH_W+0.2,SWITCH_L+0.2,SWITCH_H+0.1]);
		translate([SWITCH_X-SWITCH_TRAVEL/2-0.1,SWITCH_Y-2/2-0.1,0])
			cube([SWITCH_TRAVEL,2,SWITCH_H+0.5]);
	}
	translate([SWITCH_X-SWITCH_TRAVEL/2-0.1,SWITCH_Y-2/2-0.1,PCB_H])
		cube([SWITCH_TRAVEL,2,SWITCH_H2]);
		// depression for fingertip
	hull() {
		translate([SWITCH_X-SWITCH_TRAVEL/2,SWITCH_Y,SWITCH_H2+2])
			sphere(r=4,$fn=30);
		translate([SWITCH_X+SWITCH_TRAVEL/2,SWITCH_Y,SWITCH_H2+2])
			sphere(r=4,$fn=30);
	}
	
 }

	// depressions at top buttons for fingertips
 for (xy = buttons)
	translate([WALL,L-WALL-PCB_L,0])
	translate([xy[0],xy[1],H+BUTTON_DEPRESSION_R/2-WALL])
		sphere(d=BUTTON_DEPRESSION_R,$fn=60);

	// holes for speaker sound
 intersection() {
	translate([SPKR_X,SPKR_Y,-0.1])
		cylinder(d=SPKR_D,h=WALL*2,$fn=60);
	translate([SPKR_X,SPKR_Y,0])
	rotate(v=[0,0,1],a=45)
	for (x=[-3,-2,-1,0,1,2,3], y=[-3,-2,-1,0,1,2,3])
		translate([x*WALL*1.8,y*WALL*1.8,0])
			cube([WALL*1.2,WALL*1.2,2.1*WALL],center=true);
 }
	
 for (xy = screws_xy) {
		// screw insets in lid
	translate([xy[0],xy[1],H-SCREW_HEAD_H])
		cylinder(d=SCREW_HEAD_D+0.2,h=SCREW_HEAD_H+0.01,$fn=20);

	// screw holes in lid (loose)
	translate([xy[0],xy[1],SPLIT])
		cylinder(d=SCREW_D+0.2,h=H,$fn=20);

	// screw holes in base (tight)
	translate([xy[0],xy[1],H-SCREW_LEN])
		cylinder(d=SCREW_D+0.1,h=SCREW_LEN,$fn=20);

	// nut holes in boss
	hull() {
		translate([xy[0],xy[1],NUT_Z])
			cylinder(d=NUT_W+0.25,h=NUT_H,$fn=20);

			// make a slot to insert the screw, and make it have a sloped overhang
		translate([W/2,L-W/2,NUT_Z+2.99])
			cylinder(d=NUT_W+0.25,h=NUT_H,$fn=20);
	}
 }

	// USB hole in the side
 //translate([2,10,10]) 
 translate([WALL-USB_STICK_OUT,L-WALL-PCB_L+ESP_W/2,SPLIT-PCB_H-ESP_H-USB_H/2])
 rotate(v=[0,1,0],a=-90)
 {
	hull() {
		translate([0,USB_CONN_W/2-USB_CONN_H/2,0])
			cylinder(d=USB_CONN_H,h=2*WALL+1,$fn=20,center=true);
		translate([0,-USB_CONN_W/2+USB_CONN_H/2,0])
			cylinder(d=USB_CONN_H,h=2*WALL+1,$fn=20,center=true);
	}
	hull() {
		translate([0,USB_CABLE_W/2-USB_CABLE_H/2,0])
			cylinder(d=USB_CABLE_H,h=2*WALL+1,$fn=20,center=false);
		translate([0,-USB_CABLE_W/2+USB_CABLE_H/2,0])
			cylinder(d=USB_CABLE_H,h=2*WALL+1,$fn=20,center=false);
	}
 }

}
}


module screws() {
for (xy = screws_xy) {
	color("GREY") 
	difference() {
		union() {
			translate([xy[0],xy[1],H-SCREW_LEN])
				cylinder(d=SCREW_D,h=SCREW_LEN,$fn=20);
			translate([xy[0],xy[1],H-SCREW_HEAD_H])
				cylinder(d=SCREW_HEAD_D,h=SCREW_HEAD_H,$fn=20);
		}
		translate([xy[0],xy[1],H-2.5])
			cylinder(d=SCREW_D,h=4,$fn=6);
	}
		// nuts
	translate([xy[0],xy[1],NUT_Z])
	difference() {
		cylinder(d=7,h=2,$fn=6);
		translate([0,0,-0.1])
		cylinder(d=SCREW_D,h=2.2,$fn=20);
	}
}
}


// speaker
module speaker() {
translate([W/2,L-WALL-SPKR_D/2,WALL])
color("black") {
	cylinder(d=SPKR_D,h=WALL,$fn=30);
	translate([0,0,WALL])
	cylinder(d1=SPKR_D,d2=SPKR_D2,h=SPKR_H-WALL,$fn=30);
}
}

// battery
module battery() {
translate([W/2-BATT_W/2,WALL,WALL])
color("grey") {
	cube([BATT_W,BATT_L,BATT_H]);
}
}

// ESP32
module esp32() {
translate([WALL,L-WALL-PCB_L,SPLIT-PCB_H-ESP_H]) {
	difference() {
		cube([ESP_W,ESP_L,ESP_H]);
			// holes in the board
		for (x=[-1,1], y=[0,1,2,3,4,5,6]) {
			translate([(y+0.5)*0.1*INCH,x*0.3*INCH+ESP_L/2,-1])
				cylinder(d=0.04*INCH,h=INCH,$fn=20);
		}
	}
		// usb connector
	//translate([-USB_STICK_OUT,ESP_L/2-USB_L/2,-USB_H])
	//%cube([0.5*INCH,USB_L,USB_H]);

	color("red")
	translate([-USB_STICK_OUT+0.5*INCH,ESP_L/2,-USB_H/2])
	rotate(v=[0,1,0],a=-90)
	difference() {
		hull() {
			translate([0,USB_CONN_W/2-USB_CONN_H/2,0])
				cylinder(d=USB_CONN_H,h=0.5*INCH,$fn=20,center=false);
			translate([0,-USB_CONN_W/2+USB_CONN_H/2,0])
				cylinder(d=USB_CONN_H,h=0.5*INCH,$fn=20,center=false);
		}
		hull() {
			translate([0,USB_CONN_W/2-USB_CONN_H/2,-0.010])
				cylinder(d=USB_CONN_H-0.2,h=0.5*INCH+0.1,$fn=20,center=false);
			translate([0,-USB_CONN_W/2+USB_CONN_H/2,-0.010])
				cylinder(d=USB_CONN_H-0.2,h=0.5*INCH+0.1,$fn=20,center=false);
		}
	}
}
}

// Board
module board() {
translate([WALL,L-WALL-PCB_L,SPLIT-PCB_H]) {
	color("green")
	difference() {
		cube([PCB_W,PCB_L,PCB_H]);
		for (x=[0,1,2,3,4])
			translate([20+x*0.1*INCH,0.55*INCH,-1])
				cylinder(d=0.04*INCH,h=10,$fn=20);
	}
		// top buttons
	for (xy = buttons)
		translate([xy[0],xy[1],PCB_H])
		button(xy[2],BUTTON_H);

		// PIC
	translate([0.8*INCH,20,-PIC_H-0*PCB_H])
		cube([PIC_W,PIC_L,PIC_H]);

		// volume switch
	translate([SWITCH_X-SWITCH_W/2,SWITCH_Y-SWITCH_L/2,PCB_H])
		cube([SWITCH_W,SWITCH_L,SWITCH_H]);
	translate([SWITCH_X-2/2,SWITCH_Y-2/2,PCB_H])
		cube([2,2,SWITCH_H2]);

		// side buttons
	translate([0,BUTTON_SIDE_Y,-BUTTON_SIDE_Z]) {
		rotate(a=-90,v=[0,1,0])
			cylinder(d=BUTTON_SIDE_D, h=BUTTON_SIDE_LEN, $fn=30);
		translate([PCB_W-0.75,0,0])
			rotate(a=90,v=[0,1,0])
				cylinder(d=BUTTON_SIDE_D, h=BUTTON_SIDE_LEN, $fn=30);
	}
}
}

module button(button_color,height) {
	color("blue")
	translate([0,0,1.5])
		cube([BUTTON_W,BUTTON_W,BUTTON_D],center=true);
	color("grey") {
		translate([-BUTTON_W/2+.5,0,0.25])
			cube([1,BUTTON_W+3,0.5],center=true);
		translate([BUTTON_W/2-.5,0,0.25])
			cube([1,BUTTON_W+3,0.5],center=true);
	}
	
	color(button_color)
	cylinder(d=BUTTON_D,h=height,$fn=30);
}




//color("purple") box(0); // base
color("blue") box(1); // lid

//board();
//esp32();
//battery();
//speaker();
//screws();
