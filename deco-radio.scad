$fa = 1;
$fs = 0.4;

centralLong = 235;
centralLarg = 26;
centralHeight = 7;
offsetZ = -3;

module mainCenterBlock(hollow){
    difference()
    {
        color("red")
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

module step(height, larg, long)
{
    borderRadius = larg / 2;

    union()
    {
        difference(){
            translate([0,0,offsetZ])
                cube([larg, long ,height],center=true);

            translate([(borderRadius/2), -((long/2)-borderRadius/2), offsetZ])
                cube([borderRadius+1, borderRadius+1, height+1],center=true);

            translate([(borderRadius/2), (long/2)-borderRadius/2, offsetZ])
                cube([borderRadius+1, borderRadius+1, height+1],center=true);

        }
        translate([0, (long/2)-borderRadius+0.001, offsetZ])
            cylinder(h=height,r=borderRadius, center=true);
        translate([0, -((long/2)-borderRadius)-0.001, offsetZ])
            cylinder(h=height,r=borderRadius, center=true);    
    }
}

module addSteps(nbStep, stepHeight){
    lastStepDepth = 1.3;
    sizeDiffCoef = 3;

    union()
    {
        difference(){
            union()
            {
                for (i=[1:1:nbStep]) {
                    sizeDiff = i*sizeDiffCoef;
                    translate([0,0,stepHeight*i])
                        step(stepHeight, centralLarg-sizeDiff, centralLong-sizeDiff);
                }
            }
            
            sizeDiff = nbStep*sizeDiffCoef;
            translate([0,0,stepHeight*nbStep])
                step(stepHeight+0.1, centralLarg-sizeDiff-lastStepDepth, centralLong-sizeDiff-lastStepDepth);
        }
    
        beamWidth = 0.1;
        beamHeight = 0.5;
        margin = 0.5;
        sizeDiff = (nbStep)*sizeDiffCoef;
        nbBeams = 40;
        color("blue")
            translate([0,0,stepHeight*(nbStep-1)+beamHeight])
                difference()
                {
                    width=centralLarg-sizeDiff;
                    step(beamHeight, width, centralLong-sizeDiff);
                    union(){
                        translate([(margin+beamWidth),0,-stepHeight*(stepHeight/beamHeight)+beamHeight])
                            cube([beamWidth, centralLong-sizeDiff-lastStepDepth, beamHeight],center=true);
                        for(j=[1:1:nbBeams]){
                            translate([width-(margin+beamWidth)*j,0,-stepHeight*(stepHeight/beamHeight)+beamHeight])
                            cube([beamWidth, centralLong-sizeDiff-lastStepDepth, beamHeight],center=true);
                      }
                    }
                }              
    }
}


nbSteps = 4;
stepHeight = 1.3;

union()
{
    difference()
    {
        translate([0,0,-(nbSteps)*stepHeight])
            addSteps(nbSteps, stepHeight);

        //pin au centre a 24 mm, juste des trous ?
        translate([0, centralLong/2-24, -8])
            cylinder(4, 4, 4, center = true);
        
        translate([0, -centralLong/2+24, -8])
            cylinder(4, 4, 4, center = true);
    }
    addCenterBlock();
}
