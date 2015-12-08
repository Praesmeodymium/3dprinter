//motor mount and carriage interface
include <configuration.scad>;
$fn=32;
motor_mount();
module motor_mount(){
difference(){
cube ([body_x,body_y,body_z]);
motor();
ptfe_path();
mount();
}
module motor(){
    for (x=([(body_x/2-nema_body/2-motorgap),(body_x/2+nema_body/2+motorgap)])
    )
{
    translate ([x-nema_body/2,(hob_offy+ptfe/2+wall_thick) ,wall_thick*2+mount_bolt])
    cube (nema_body);
    translate ([x,(hob_offy+ptfe/2+wall_thick) ,wall_thick*2+mount_bolt+nema_body/2])
    rotate([90,0,0])
    for (i=[0:3]) {
      rotate([0, 0, 90*i]) translate([nema_mount/2, nema_mount/2, 0])
cylinder(h=hob_offy+ptfe/2+wall_thick+.1, d=nema_bolt, $fn=36);
}    
    
}
for (x=([(body_x/2-nema_body/2-motorgap),(body_x/2+nema_body/2+motorgap)])
    )
;}
module ptfe_path(){
    for (x=([(body_x/2-nema_body/2-motorgap+hob_d1),(body_x/2+nema_body/2+motorgap-hob_d1)
        ])
    )
    for (y=([ptfe/2+wall_thick]))
    {
        translate ([x, y,-.1])
        cylinder (d=ptfe, h=body_z+.2);
        
        // cutout using the ptfe as refernce
        translate ([body_x/2, 0])
        cube ([((body_x/2-nema_body/2+motorgap+hob_d1-wall_thick*2)-ptfe), (hob_offy+ptfe/2)*2, body_z*2], center=true);
        }
}

module mount(){
    for (x=([wall_thick+mount_bolt/2, body_x/2, body_x-wall_thick-mount_bolt/2 ]))
     
    {
        
        translate ([x, -.1, wall_thick+mount_bolt/2])
        rotate ([90,0,0])
        cylinder (h=body_y*2+.2, d=mount_bolt, center=true);
    }
}
}