include <configuration.scad>;
cable_holder();
module cable_holder(){
//cable loop
l=30;
w=30;
h=12;
thick=wall_thick;//wall thickness
bolt=mount_bolt;//size of the boltholes
difference (){
   cube([l,w,h]);
    translate ([l/2,w/2,h/2])
    rotate ([90,0,0])
    cylinder (d=bolt, h=w+1, center = true);
    translate ([l/2,w/2,h/2])
    rotate ([0,90,0])
    cylinder (d=bolt, h=w+1, center = true);
    translate([thick,thick,-.1])
    cube (l-thick*2, w-thick*2, h+.2);
    }
}