//hotend-clamp
include <configuration.scad>;
base();//uncomment for the carriage to hotend interface
translate ([0,-10,0])
clamp();//uncomment for the clmap and nozzle holder
local_y=11;
localz=22;
module extruder_mount(){
    base();
    translate([0,-10,0])
    clamp();
}
module clamp (){  
difference(){
front();
base();
}
}

module front () {
    difference(){
translate ([nut+wall_thick*2,-hotend_dia/2+1, 0])
           cube([(body_x-nut*2-wall_thick*4),local_y,groovez*2+wall_thick*4]);
    
    for (x=([(body_x/2-nema_body/2-motorgap+hob_d1),(body_x/2+nema_body/2+motorgap-hob_d1)
        ])
    )
    for (y=([ptfe/2+wall_thick]))
    {
        translate ([x, y,-.1])
        cylinder (d=ptfe, h=localz+.2);
// hotend cutout
        translate ([x, y,groovez])
        cylinder (d=hotend_dia, h=groovez);
        translate ([x, y,0])
        cylinder (d=groove, h=groovez);
        translate([x, y, groovez*2+1])
       cylinder (d=nut, h=3, $fn=6, center=true); 

    }
    translate([body_x/2,0, wall_thick+nut/2])
            rotate ([90,0,0])
            cylinder (h=body_y*2+.2, d=mount_bolt, center=true);

}
}
module base() {
    //carriage-hotend interface

difference(){
cube ([body_x, body_y,localz]);
weight();

ptfe_path();
lowermount();
    }
module ptfe_path(){
for (x=([(body_x/2-nema_body/2-motorgap+hob_d1),(body_x/2+nema_body/2+motorgap-hob_d1)
        ])
    )
    for (y=([ptfe/2+wall_thick]))
    {
        translate ([x, y,-.1])
        cylinder (d=ptfe, h=localz+.2);
// hotend cutout
        translate ([x, y,groovez])
        cylinder (d=hotend_dia, h=groovez);
        translate ([x, y,0])
        cylinder (d=groove, h=groovez);
        translate([x, y, groovez*2+1])
       cylinder (d=nut, h=3, $fn=6, center=true); 
                translate ([x,0,0])
        cube([hotend_dia, hotend_dia/2-1, groovez*4], center = true);
    }
}
     
    module lowermount(){
        for (x=([wall_thick+mount_bolt/2,body_x/2, body_x-wall_thick-mount_bolt/2 ]))
            for(z=([(wall_thick+mount_bolt/2+nut):(localz-wall_thick*2)]))
        {
        //the slotted nut hole
        translate ([x,0, z])
            rotate([90,0,0])
        cylinder (h=body_y*2+.2, d=mount_bolt, center=true);
//the depression for clearance of the slotted nut head
            translate ([x,0, z])
            rotate([90,45,0])
        cylinder (h=body_y*2-wall_thick*4, d=mount_bolthead, center=true, $fn=4);
            
            translate([body_x/2,0, wall_thick+nut/2])
            rotate ([90,0,0])
            cylinder (h=body_y*2+.2, d=mount_bolt, center=true);
            translate([body_x/2,body_y, wall_thick+nut/2])
            rotate ([90,0,0])
            cylinder (d=nut, h=5, $fn=6);
    }
}
module weight(){
    translate ([body_x/2, 0, localz-groovez+wall_thick/2])
   cube ([(body_x-4*wall_thick-nut-mount_bolt-ptfe), (2*body_y-4*wall_thick), (localz-groovez*2-wall_thick/2)], center=true);
  
 
    }

}
