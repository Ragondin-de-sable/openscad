$fa = 1;
$fs = 0.4;

centralLong = 235;
centralLarg = 38;
centralHeight = 7;
offsetZ = -3;

module mainCenterBlock(hollow){
    difference()
    {
        translate([0,-30,0])
            cube([30,90,13],center=true);
        
        if(hollow){
            translate([0,-30,0])
                cube([28,88,15],center=true);
        }
        
        translate([0,-57,20])
            rotate([0,90,0])
                rotate([0,0,10])
                    scale([0.8,2,2])
                        cylinder(h=30, r1=18, r2=18, center=true);
        
        translate([0,-22,12])
            rotate([0,90,0])
                rotate([0,0,-3])
                    scale([0.5,2.8,2])
                        cylinder(h=30, r1=18, r2=18, center=true);
    }
}

module centralBlockFacade()
{
    difference(){
        mainCenterBlock(false);
    
        translate([-2,-30,0])
            cube([33,92,20],center=true);
    }
}

module addCenterBlock(){
    translate([0,6.5,0])
    union(){
        mainCenterBlock(true);
        translate([0,0,-1])
                mainCenterBlock(false);   

        translate([0,0,-1.3])
            resize(newsize=[31,91,12])
                mainCenterBlock(true);
        
        for(k=[1:1:29]){
            translate([-30+k+0.5,0,-0.5])
                centralBlockFacade();
        }

        color("orange")
            translate([-20,0,0])
                scale([1.8,1,1])
                    centralBlockFacade();
        
        color("orange")
            translate([-33,0,0])
                scale([1.8,1,1])
                    centralBlockFacade();
    }
}


nbSteps = 4;
stepHeight = 2;

union()
{
    translate([0,0,-(nbSteps)*stepHeight])
        newAddSteps(nbSteps, stepHeight);
    
    scale([1.1,1,1])
        addCenterBlock();
}

module newStep(height, larg, longTotal){
    offset = 7;     // rétrécissement des côtés
    long = longTotal/2;
    
    union()
    {
        difference()
        {     
            baseStep(height, larg, long);       
            
            /* coin des arrondis*/
            translate([(borderRadius/2), -(long)+borderRadius/2, 0])
                cube([borderRadius+1, borderRadius+1, height+10],center=true);

            translate([(borderRadius/2), (long)-borderRadius/2, 0])
                cube([borderRadius+1, borderRadius+1, height+10],center=true);
        }
    
        //ellipses
        borderRadius = larg / 2;
        
        difference()
        {
            translate([-3.5, (long)-borderRadius+0.001, 0])
                scale([1.12, 1.4, 2])
                    cylinder(h=height-1,r=borderRadius, center=true);

            translate([-larg+borderRadius/2, (long)-borderRadius/2, 0])
                rotate([0,0,4])
                    cube([borderRadius+1, 70, height+1],center=true);
        }
        
        difference()
        {
            translate([-3.5, -((long)-borderRadius)-0.001, 0])
                scale([1.12, 1.4, 2])
                    cylinder(h=height-1,r=borderRadius, center=true); 
            
            translate([-larg+borderRadius/2, -(long)+borderRadius/2, 0])
                    rotate([0,0,-4])
                        cube([borderRadius+1, 70, height+1],center=true);
        }
    }
}

module baseStep(height, larg, long){
    offset = 7;     // rétrécissement des côtés
    
    union()
    {    
        translate([0,-long,0]){
            linear_extrude(height = stepHeight, center = true) {
                polygon(points = [
                    [-larg/2, 0],              // point 0: bas gauche
                    [larg/2, 0],               // point 1: bas droit
                    [(larg - 2*offset)/2, long],    // point 2: haut droit (rétrécit)
                    [-(larg - 2*offset)/2, long]    // point 3: haut gauche (rétrécit)
                ]);
            }
        }
                
        rotate([0,0,180]){
            translate([0,-long,0])
                linear_extrude(height = stepHeight, center = true) {
                    polygon(points = [
                        [-larg/2, 0],              // point 0: bas gauche
                        [larg/2, 0],               // point 1: bas droit
                        [(larg - 2*offset)/2, long],    // point 2: haut droit (rétrécit)
                        [-(larg - 2*offset)/2, long]    // point 3: haut gauche (rétrécit)
                    ]);
                }
        }          
    }
    
}


module newAddSteps(nbStep, stepHeight){
    sizeDiffCoef = 3;

    union()
    {
        difference()
        {
            union()
            {
                for (i=[1:1:nbStep]) {
                    sizeDiff =  1-((i-1)*0.055);
                    sizeDiff2 =  1-((i-1)*0.1);
                    translate([0,0,stepHeight*i])
                        scale([sizeDiff2, sizeDiff, 1])
                            newStep(stepHeight, centralLarg, centralLong);
                }
            }
            
            sizeDiff =  1-(nbStep*0.05);
            sizeDiff2 =  1-(nbStep*0.1);
            lastStepDepth = 0.3;
            translate([0,0,stepHeight*nbStep+lastStepDepth])
                scale([sizeDiff2, sizeDiff, 1])
                    newStep(stepHeight+0.1, 
                            centralLarg+0.1, 
                            centralLong+0.1);
            
        }
    
        color("blue")
            addStepBeams(nbStep, sizeDiffCoef, stepHeight);
    }
}

module addStepBeams(nbStep, sizeDiffCoef, stepHeight){    
    beamWidth = 0.5;
    margin = 0.5;
    sizeDiff = (nbStep)*sizeDiffCoef;

    sizeDiff =  1-(nbStep*0.05);
    sizeDiff2 =  1-(nbStep*0.1);
    lastStepDepth = 0.3;
    
    translate([0,0,stepHeight*nbStep-stepHeight/2])
        difference()
        {
            scale([sizeDiff2, sizeDiff, 1])
                newStep(stepHeight+0.1, 
                        centralLarg+0.1, 
                        centralLong+0.1);
            
            translate([-15,0,0])//magic numbers 
                for(j=[1:1:25]){
                    translate([j,0,0])
                        cube([beamWidth, 
                                centralLong-sizeDiff-lastStepDepth, 
                                100],
                            center=true);
            }
        }
}
