yb=75;//local y
zb=13.5;//[bearing_h/2+wall_thick]//local z

$fn=36;
include <configuration.scad>;
difference(){
union(){
difference () {    
cube ([body_x, yb, zb]);

bearings();

weight();
}
beltloop();
translate ([0,yb/2,8])
cube([body_x/2-30.5,6,3.35]);
translate ([body_x/2+30.5, yb/2,8])
cube([(body_x-body_x/2-30.5),6,3.35]);
}
boltpattern();
translate ([0,yb/2+6,8])
cube ([body_x,2,6]);
}
module boltpattern(){
    for (i= [
        [ wall_thick+mount_bolt/2, 50, -.1],
          [body_x-wall_thick-mount_bolt/2, 50, -.1],
          [wall_thick+mount_bolt/2, 72, -.1],
          [body_x-wall_thick-mount_bolt/2, 72, -.1],
          [body_x/2,yb/2+4, -.1]
    ])
    {
        translate(i)
cylinder (h=20, d=mount_bolt);
        translate ([body_x/2,yb/2+4, zb/2])
        cylinder (h=9, d=nut, $fn=6);
    }
     for (x=([wall_thick+mount_bolt/2, body_x/2, body_x-wall_thick-mount_bolt/2 ]))
     for (y=([wall_thick+mount_bolt/2,wall_thick*2+mount_bolt/2+21]))
    {
        
        translate ([x,y, -.1])
        cylinder (h=body_y*2+.2, d=mount_bolt, center=true);
    }
}
        
module bearings(){
    for (x=[wall_thick*2+mount_bolt, body_x-wall_thick*2-mount_bolt-bearing_l], 
        y=[15,60],
         z=[bearing_l/2+wall_thick])
    {
        translate([x,y,z])
rotate([90,0,90])
cylinder(d=13, h=80, $fn=36,center = true);
          translate([x,y,z])
rotate([90,0,90])
cylinder(d=21, h=30, $fn=36);
    }
    //zipties
for (x = ([(mount_bolt+bearing_l/2), body_x/2+mount_bolt+bearing_l/2]))
 for (y = [2, 26.75, 47, 72])
     {translate([x,y,-.1])
    cube ([4,1.5,21]);
     translate ([x, 3, -.1])
         cube([4, 24, 1.5]);
       translate ([x, 48, -.1])
         cube([4, 24, 1.5]); 
         }
}

 module beltloop(){
translate ([body_x/2-32,yb/2+4,8])
rotate ([0,0,180])
     beltsupp();
translate ([body_x/2+32,yb/2+4,8])
beltsupp();
translate ([body_x/2-9,yb/2+4,4])
rotate ([0,180,180])
beltsupp();
translate ([body_x/2+9,yb/2+4,4])
rotate ([0,180,0])
beltsupp();

translate ([body_x/2-13,yb/2+4,6])

cube([8,8,4],center=true);
translate ([body_x/2+13,yb/2+4,6])

cube([8,8,4],center=true);
     //center
translate ([body_x/2-5.5, yb/2, 0])
     cube ([11, 8,8]);
     
 }
 module weight(){
     translate([body_x/2-24, yb/2, -.1])
    cube([48,8,zb+.2]);
     translate([0,yb/2-7,8])
     cube ([body_x+.2,15,19.2]);
// cutout for cabling
     translate ([body_x/2-7.5, 51, -.1])
     cube([15, 15, 20]);
     }
 

 module beltsupp(){
     pad = 0.1; // Padding to maintain manifold
b = 8;
h = 5;
w = 8;
r = 2; // Radius of round
smooth = 360; // Number of facets of rounding cylinder

z = h - r*h/b - r*pow(pow(h,2)+pow(b,2),0.5)/b;
x3 = r*h/pow(pow(h,2)+pow(b,2),0.5) + r;

difference() {
rotate(a=[90,-90,0])
linear_extrude(height = w, center = true, convexity = 10, twist = 0)
polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
translate([0,0,z])
difference() {
translate([-x3/2,0,(h-z)/2])
cube([x3+pad,w+2*pad,h-z],center=true);
translate([-r,0,0])
rotate(a=[0,90,90])
cylinder(w+4*pad,r,r,center=true,$fn=smooth);

}
}
}

 //b for base
