
//le clavier



module keyboard_logitech_pebble_keys_2_K380S(){
    long=280;
    larg=125;
    hmax=19;
    hmin=7;
    
    difference()
    {
        difference(){
            cube([long, larg, hmax], true);
            union(){
                translate([0,0,9])
                   rotate([-5.8,0,0])
                        cube([long+5, larg+5, 10], true);
                 
                 translate([0,0,10+hmin])
                     rotate([-5.8,0,0])
                    cube([long+5, larg+5, 10], true);
            }
        }
        
        keyboard_logitech_pebble_keys_2_K380S8_bottom_left_corner(long, larg, hmax);
        keyboard_logitech_pebble_keys_2_K380S8_bottom_right_corner(long, larg, hmax);
        keyboard_logitech_pebble_keys_2_K380S8_top_left_corner(long, larg, hmax);
        keyboard_logitech_pebble_keys_2_K380S8_top_right_corner(long, larg, hmax);
    }
}

module keyboard_logitech_pebble_keys_2_K380S8_bottom_left_corner(long, larg, hmax){
    r=10;
    difference()
    {
        translate([(long/2)-r,(larg/2)-r,-hmax])
            cube([r+1, r+1, hmax+1]);
        
        translate([(long-r)/2,(larg-r)/2,-hmax/2])
            cylinder(h=hmax+10, d1=r, d2=r, center=true);
        
        
        translate([(long/2)-r,(larg/2)-r*1.5,-hmax])
            cube([r+10, r+1, hmax+10]);
        
        translate([(long/2)-r*1.5,(larg/2)-r,-hmax])
            cube([r+1, r+10, hmax+10]);
    }
}

module keyboard_logitech_pebble_keys_2_K380S8_bottom_right_corner(long, larg, hmax)
{
    translate([0, 0, -hmax])
        rotate([0,180,0])
            keyboard_logitech_pebble_keys_2_K380S8_bottom_left_corner(long, larg, hmax);
}

module keyboard_logitech_pebble_keys_2_K380S8_top_left_corner(long, larg, hmax)
{
    translate([0, 0, -hmax/2])
        rotate([180,0,0])
            keyboard_logitech_pebble_keys_2_K380S8_bottom_left_corner(long, larg, hmax);
}

module keyboard_logitech_pebble_keys_2_K380S8_top_right_corner(long, larg, hmax)
{
    translate([0, 0, hmax/2])
        rotate([180,180,0])
            keyboard_logitech_pebble_keys_2_K380S8_bottom_left_corner(long, larg, hmax);
}

keyboard_logitech_pebble_keys_2_K380S();