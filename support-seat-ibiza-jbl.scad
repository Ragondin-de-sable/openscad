
//base
cube([48, 28, 2], true);

//triangle avant
difference()
{
    translate([15,0,4])
        cube([8, 28, 8], true);
        
    translate([12,0,7])
        rotate([0,45,0])
            cube([8, 30, 11], true);
}

union(){
    //triangle arrière
    difference()
    {
        
        translate([-16.5,0,8.5])
            cube([15, 28, 17], true);
        
        translate([-4,0, 10.5])
            rotate([0,75,0])
                cube([18, 30, 15], true);
        
        translate([-22,0, 8.6])
            cube([16, 30, 17], true);
    }

    //fixation triangle arrière
    translate([-13,0, 15])
        rotate([0,75,0])
            cube([30, 28, 1], true);
}
//troue pilier

//pilier
