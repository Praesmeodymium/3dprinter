belt_tensioner();
module belt_tensioner(){
difference() {
    $fn=36;
cylinder (d=11,h=8);
translate ([0,0,4])
rotate ([90,0,0])
cylinder (d=3.2, h=8, center = true);
translate ([0,11/2,11/2])
cube(11, center = true);
}
}