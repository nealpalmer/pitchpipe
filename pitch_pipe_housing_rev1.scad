INCH = 25.4;
BOARD_WID = 38;
BOARD_HEI = 25;
BOARD_THICK = 0.062*INCH;
BOARD_CLAMP = 1; // how much the clamp can extend into the circuit board
SPACING_X = BOARD_WID/4;
SPACING_Y = BOARD_HEI/3;
BATTERY_DIA = 14;
BATTERY_LEN = 50;
SPEAKER_DIA = 23;
SPEAKER_THICK = 6;
GRILL_THICK = 2;
GRILL_SPACE = 3;
BUTTON_HEIGHT = 5; // 3.8, 5, 7
USB_WID = 15;
USB_HEI = 5;
WALL_THICK = 3;
WALL_R = 1.0; // radius of curve on edges of box
CORNER_FN = 27;
BUTTON_RECESSED = (0 ? 3 : BATTERY_DIA/2+WALL_THICK-BUTTON_HEIGHT-0.062*INCH); // how far the buttons are recessed from the top of the chassis (fixed distance, or put PCB bottom in the middle for a simpler plastic split)
BOARD_Z = BATTERY_DIA/2-0.062*INCH-BUTTON_HEIGHT+WALL_THICK-BUTTON_RECESSED;

module battery_14500()
{
 cylinder(h=BATTERY_LEN,d=BATTERY_DIA,$fn=60);
}

module button_tl3055()
{
 color("white")
 translate([-4.5/2,-4.5/2,0])
 	cube([4.5,4.5,2.5]);
 color("black")
 	cylinder(h=BUTTON_HEIGHT,d=2.5,$fn=20);
}

module button_board()
{
 color("green")
 	cube([BOARD_WID,BOARD_HEI,BOARD_THICK]);
 for (x=[0,1,2,3],y=[0,1,2])
	translate([(x+0.5)*SPACING_X,(y+0.5)*SPACING_Y,BOARD_THICK])
		button_tl3055();
}

module speaker_23mm()
{
 cylinder(d=SPEAKER_DIA,h=SPEAKER_THICK/3);
 cylinder(d=SPEAKER_DIA*.66,h=SPEAKER_THICK);
}

module esp8266()
{
/*
 color("green")
 	cube([25,34,0.062*INCH]); // board
 color("white")
	translate([25/2-8/2,34-10,0.062*INCH])
 		cube([8,10,4]); // usb connector
 color("white")
	translate([25/2-18/2,0,-3])
 		cube([18,20,3]); // cpu module
*/

 // https://www.seeedstudio.com/Seeed-XIAO-ESP32C3-p-5431.html?gad=1&gclid=CjwKCAjwvpCkBhB4EiwAujULMlrZZ5Q0jjppgrKAlHmH8MwtqOZir_gmsqyHkT8n8zwmO707Zjyk1BoCyFoQAvD_BwE
 // 22x18mm
 
 color("green")
 	cube([17.5,21,0.062*INCH]); // board
 color("white")
	translate([17.5/2-10/2,21-7+1,0.062*INCH])
 		cube([10,7,4]); // usb connector
 color("white")
	translate([25/2-18/2,0,0.062*INCH])
 		cube([13.2,12.5,2.4]); // cpu module
}

module m3_with_locknut(dist,len)
{
 color("grey") {
 cylinder(d=3,h=len,$fn=15);
 translate([0,0,-3]) {
	difference() {
 		cylinder(d=6,h=3,$fn=15); // bolt head
		translate([0,0,-1])
 			cylinder(d=2.5,h=3,$fn=6); // hex key
	}
 }
 translate([0,0,dist]) {
 	cylinder(d=5.5,h=3,$fn=6); // nylock
	translate([0,0,3])
 		cylinder(d1=4.77,d2=4,,h=1,$fn=25); // nylock

	translate([0,0,3-0.1])
 		cylinder(d=5.5,h=30,$fn=6); // plastic cut-out
 }
 }
}

module torus(r1=1, r2=2, angle=360, endstops=0, $fn=50){
    if(angle < 360){
        intersection(){
            rotate_extrude(convexity=10, $fn=$fn)
            translate([r2, 0, 0])
            circle(r=r1, $fn=$fn);
            
            color("blue")
            wedge(h=r1*3, r=r2*2, a=angle);
        }
    }else{
        rotate_extrude(convexity=10, $fn=$fn)
        translate([r2, 0, 0])
        circle(r=r1, $fn=$fn);
    }
    
    if(endstops && angle < 360){
        rotate([0,0,angle/2])
        translate([0,r2,0])
        sphere(r=r1);
        
        rotate([0,0,-angle/2])
        translate([0,r2,0])
        sphere(r=r1);
    }
}

module speaker_grill()
{
 rotate(a=17,v=[0,0,1])
 intersection() {
	cylinder(d=SPEAKER_DIA-2,h=10,$fn=30);
	difference() {
		for(x=[-SPEAKER_DIA:GRILL_THICK+GRILL_SPACE:SPEAKER_DIA])
			translate([x,-SPEAKER_DIA/2,0])
				cube([GRILL_SPACE,SPEAKER_DIA,WALL_THICK*2]);
		for (y=[-SPEAKER_DIA/5,SPEAKER_DIA/5])
		translate([-SPEAKER_DIA/2,y-GRILL_THICK/2,0])
			cube([SPEAKER_DIA,GRILL_THICK,WALL_THICK*2]);
	}
 }
}


/*
translate([-50/2,0,0])
	rotate(a=90,v=[0,1,0])
		battery_14500();
*/

translate([-BOARD_WID/2-0,BATTERY_DIA/2,BOARD_Z])
	button_board();

/*
translate([-8,BATTERY_DIA/2+SPEAKER_DIA/2,-7])
	speaker_23mm();
translate([3,BATTERY_DIA/2+0*17.5+6,0*(-0.062*INCH-0.1*INCH)+BOARD_Z])
	rotate(a=90,v=[0,0,1])
	rotate(a=180,v=[1,0,0])
		esp8266();
//for (x=[-1,1])
	//translate([x*(BOARD_WID/2+3),BATTERY_DIA/2+3,BATTERY_DIA/2-3+WALL_THICK])
		//rotate(a=180,v=[1,0,0])
			//m3_with_locknut(BATTERY_DIA-4+3-1,17);
*/

module chassis() 
{
 difference() {
		// the outside of the chassis
 	union() {
			// around the battery
		difference() {
			translate([-(BATTERY_LEN+2*WALL_THICK-WALL_R*2)/2,0,0])
				rotate(a=90,v=[0,1,0])
					cylinder(d=BATTERY_DIA+2*WALL_THICK,h=BATTERY_LEN+2*WALL_THICK-WALL_R*2,$fn=70);
			translate([-BATTERY_LEN/2,BATTERY_DIA/2,-BATTERY_DIA/2])
				cube([BATTERY_LEN,WALL_THICK,BATTERY_DIA]);
			translate([-BATTERY_LEN/2-1,0,-BATTERY_DIA/4])
				cube([BATTERY_LEN+2,BATTERY_DIA,BATTERY_DIA/2]);
		}
			// top/bottom sides
		for(z=[-1,1])
			translate([-(BATTERY_LEN+2*WALL_THICK-WALL_R*2)/2,0,z*BATTERY_DIA/2+z*WALL_THICK/2-WALL_THICK/2])
				cube([BATTERY_LEN+2*WALL_THICK-WALL_R*2,BATTERY_DIA/2+BOARD_HEI+WALL_THICK-WALL_R,WALL_THICK]);
			// left/right sides
		for (x=[-1,1])
			translate([x*(BATTERY_LEN/2+WALL_THICK/2)-WALL_THICK/2+0.01,0,-BATTERY_DIA/2-WALL_THICK+WALL_R])
				cube([WALL_THICK,BATTERY_DIA/2+BOARD_HEI+WALL_THICK-WALL_R,BATTERY_DIA+2*WALL_THICK-2*WALL_R]);
			// away side
		translate([-BATTERY_LEN/2-WALL_THICK+WALL_R,BATTERY_DIA/2+BOARD_HEI,-BATTERY_DIA/2-WALL_THICK+WALL_R])
			cube([BATTERY_LEN+2*WALL_THICK-2*WALL_R,WALL_THICK,BATTERY_DIA+2*WALL_THICK-2*WALL_R]);
			// speaker mount
		translate([-8,BATTERY_DIA/2+SPEAKER_DIA/2,-BATTERY_DIA/2])
		difference() {
			cylinder(d=SPEAKER_DIA+2*WALL_THICK,h=WALL_THICK,$fn=100);
			translate([0,0,-0.1])
				cylinder(d=SPEAKER_DIA,h=WALL_THICK+1,$fn=100);
		}

			// radiused corners
				// left/right side corners
		for (x=[-1,1],z=[1,-1])
			translate([x*(BATTERY_LEN/2+WALL_THICK-WALL_R),0,z*(BATTERY_DIA/2+WALL_THICK-WALL_R)])
				rotate(a=-90,v=[1,0,0])
					cylinder(r=WALL_R,h=BATTERY_DIA/2+BOARD_HEI+WALL_THICK-WALL_R,$fn=CORNER_FN);
		for (x=[-1,1],z=[0])
			translate([x*(BATTERY_LEN/2+WALL_THICK-WALL_R),0,z*(BATTERY_DIA/2+WALL_THICK-WALL_R)])
				rotate(a=90,v=[0,1,0])
					hull()
						torus(r1=WALL_R, r2=(BATTERY_DIA+2*WALL_THICK-2*WALL_R)/2, angle=360, endstops=0, $fn=150);
				// away side corners
		for (z=[1,-1])
			translate([-BATTERY_LEN/2-WALL_THICK+WALL_R,BATTERY_DIA/2+BOARD_HEI+WALL_THICK-WALL_R,z*(BATTERY_DIA/2+WALL_THICK-WALL_R)])
				rotate(a=90,v=[0,1,0])
					cylinder(r=WALL_R,h=BATTERY_LEN+2*WALL_THICK-2*WALL_R,$fn=CORNER_FN);
		for (x=[1,-1])
			translate([x*(BATTERY_LEN/2+WALL_THICK-WALL_R),BATTERY_DIA/2+BOARD_HEI+WALL_THICK-WALL_R,-BATTERY_DIA/2-WALL_THICK+WALL_R])
					cylinder(r=WALL_R,h=BATTERY_DIA+2*WALL_THICK-2*WALL_R,$fn=CORNER_FN);

		// bolt mounts
		for (x=[1,-1])
			translate([x*(BOARD_WID/2+3),BATTERY_DIA/2+3,-BATTERY_DIA/2]) {
				cylinder(d=6,h=BATTERY_DIA,$fn=21);
				for (z=[0,BATTERY_DIA-3])
					translate([0,0,z])
						cylinder(d=9,h=5,$fn=21);
			}
		// board mounts
		translate([-BOARD_WID/2,BATTERY_DIA/2+BOARD_HEI-1,-BATTERY_DIA/2-0.1])
			cube([BOARD_WID,1+WALL_THICK-0.1,BATTERY_DIA/2+0.1]); // away side support beam
		translate([-BOARD_WID/2+BOARD_WID/2+1,BATTERY_DIA/2+0*BOARD_HEI-1,-BATTERY_DIA/2-0.1]) {
			hull() {
				cube([BOARD_WID/2,1+1,BATTERY_DIA/2+0.1]); // battery side support beam (1/2 length)
				cube([BOARD_WID/2,1+1+3,0.1]); // battery side support beam (1/2 length)
			}
		}
 	} 
	// hole for battery
	translate([-50/2,0,0])
		rotate(a=90,v=[0,1,0])
			battery_14500();
	// hole for USB port
	translate([BATTERY_LEN/2-0.1,BATTERY_DIA/2+6+17.5/2-USB_WID/2,-USB_HEI-0.062*INCH+USB_HEI/2-4/2])
		cube([WALL_THICK*10,USB_WID,USB_HEI]);
	// speaker output holes
	translate([-8,BATTERY_DIA/2+SPEAKER_DIA/2,-BATTERY_DIA/2-WALL_THICK-0.1])
		speaker_grill();
	// esp8266 programming button access hole
		// Neal, todo, fixme
	// hole for board to fit in the M3 holes
		// Neal, todo, fixme
	// hole for buttons
		// Neal, todo, fixme

	// M3 bolt holes
	for (x=[-1,1])
		translate([x*(BOARD_WID/2+3),BATTERY_DIA/2+3,BATTERY_DIA/2-3+WALL_THICK])
			rotate(a=180,v=[1,0,0])
				m3_with_locknut(BATTERY_DIA-4+3-1,17);
 }
}

	// bottom half of case
color("red")
	difference() {
		chassis();
		translate([-50,-50,0])
			cube([100,100,20]);
	}

	// top half of case
color("red")
	translate([60,0,0])
	rotate(a=180,v=[0,1,0])
	difference() {
		chassis();
		translate([-50,-50,-20])
			cube([100,100,20+0.01]);
	}
