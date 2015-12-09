//Assembly

//Most settings are adjustable in configuration.scad
include <configuration.scad>;
use <belt_tensioner.scad>;
use <cable_holder.scad>;
use <carriage.scad>;
use <extruder_mount.scad>;
use <motor_mount.scad>;
extruders_assemble();
module extruders_assemble(){
translate ([-body_x/2,0,0])
    rotate ([-90,180,180])
    carriage();
    translate ([0, -20, 37.5])
    belt_tensioner();
    translate([-15,-50,22.5])
    cable_holder();
    translate ([body_x/2,25,12])
    rotate([0,0,180])
    extruder_mount();
    translate ([body_x/2, 27, 67])
    rotate ([0,0,180])
    motor_mount();
}