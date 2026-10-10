//keyboard
//color("red")
//    translate([0,0,15])
//        import("K380S.stl");

//keyboard enclosure        
//color("blue")
//    keyboard_enclosure();

//knob
//color("orange")
//    translate([100,-160,0])
        //scale_import("unkyulee-phone-enclosure/knob.stl");

//iphone XS
//color("black")
//    translate([-73,-215,80])//10
//        iphone();

//color("blue")
  //  translate([0,-180, 40])
//        display();

    //translate([0,-180, 70])
        display_panel();


//TODO
//label();

module display(){
    
    union()
    {
        difference()
        {
            rotate([0,180,00])
                scale_import("unkyulee-phone-enclosure/Display.stl");
            
            //suport telephone
            translate([-130,-65,-40])
                cube([260, 130, 15]);
        }
        
        difference()
        {
            
            translate([-75,-40,-40])
                cube([150, 85, 18]);
                        
            translate([-50,-65,-40])
                cube([100, 127, 20]);
            
            translate([-124,-25,-40])
                cube([245, 50, 20]);  
            
           translate([-73,-35,-32])
                iphone();

        }
        
        
        //trou gauche
        translate([30,-60,-43])
            cube([70,30,2]);
        translate([34,-55,-43.5])
            cube([70,30,2]);
            
       //trou du haut 
       translate([0,-67.5,-39.5])
            cube([80,4.5,15]);     
       translate([7,-63,-43.5])
            cube([70,15,2]);
        translate([8,-66.6,-40])
            rotate([-45,0,0])
                cube([70,5,2]);
         
       //TODO trou prise usb 
    }
}

module iphone(){
    cube([145, 75, 10]);
}

module display_panel()
{
    difference(){
        union()
        {
            scale_import("unkyulee-phone-enclosure/Display Panel.stl");
            translate([-110,-60,21.6])    
                cube([220, 110, 4.5]);
            
        }   
        
        translate([-60,-25,20]){
            cube([130, 62, 10]);//iphone plus petit
        
            /*minkowski()
            {
                r=1;
                h=10;
                cube([122, 55, h]);//iphone plus petit
                cylinder(r,h);
            }
            */
        }
        
        translate([-67,-30,22])        
            cube([144, 72, 5]);//iphone
            
            
    }
}

module label()
{
    union(){
        union(){
            rotate([5,0,0])
            translate([80, -110, -64])
                scale_import("unkyulee-phone-enclosure/Label.stl");
            
        color("blue")
        translate([-5,-4,-1.5])
           minkowski()
            {
                cube([70,10,1], true);
                cylinder(1,0.5);
            }
            
            
            
        }
        /*
        translate([25,2,-3])
            rotate([180,180,0])
                linear_extrude(height = 2) 
                    text("iK380XS", font = "Segoe UI:style=bold italic", size = 12);
        */
    }
}

module keyboard_enclosure()
{
    difference()
    {
        union()
        {
            rotate([0,0,180])
                scale_import("unkyulee-phone-enclosure/Keyboard.stl");
            
            translate([-146.5,-55,6])
            rotate([-3,0,0])
                cube([4.5,30,11]);
            
            translate([-100,-67.5,6])
            rotate([0,0,90])
                cube([4.5,35,11]);
        }
    
        translate([0,0,15])
            import("K380S.stl");
        
        translate([140,-50,10])
            cube([10,20,10]);
    } 
}

module scale_import(stl_path)
{
    s = 1.45;
    scale([s, s, s])
        import(stl_path);
}