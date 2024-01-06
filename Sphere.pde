class Sphere{
    int r = 100;
    Point position;
    Point velocity;
    int nbSquare=40;
    int squareSize=10;
    int width=nbSquare*squareSize;
    float k=0.8;
    Point gravity;
    int x,y,z;
    boolean surfaceFind = false;
    Sphere(int x, int y, int z,int r, Point gravity, float k){
        this.x=x;
        this.y=y;
        this.z=z;
        this.gravity= gravity;
        this.k=k;
        velocity = new Point(0.0,gravity.y,0.0);
        position = new Point(this.x,this.y,this.z);
        this.r=r;
    } 



    void move(){
        velocity.add(gravity);
        //velocity.x *= k;
        //velocity.y *= k;
        //velocity.z *= k;
        position.add(velocity);
    }



    void checkGroundCollision(Ground ground){
        int nbSquare=40;
        int squareSize=10;
        int totalSize=nbSquare*squareSize;
        //si on est en dehors du cube 
        if(position.x < 0 || position.x > totalSize || position.z < 0 || position.z> totalSize) return;

        //on cherche la surface la plus proche de le sphere en x et z
        Slab s = ground.squares[0][0];
        boolean findSurface = false;
        int i = 0;
        while((i<ground.nbSquare-1)&&(!findSurface)){
            int j = 0;
            while((j<ground.nbSquare-1)&&(!findSurface)){
                s= ground.squares[i][j];
                if((abs(s.p1.x) <= abs(this.position.x)) && (abs(s.p3.x) >= abs(this.position.x)) && (abs(s.p1.z) <= abs(this.position.z)) && (abs(s.p3.z) >= abs(this.position.z))){
                    findSurface= true;
                }
                j++;
            } 
            i++;   
        }

        // On récupère le point le plus près de la sphère en x et en z et les segments qui lui sont associés
        //closest point est le point du carré le plus proche du point d'impacte
        //s.point renvoie la liste des 4 points de la surface. 
        Point closest = s.closestPoint(position.x, position.z, s.points);
        Point[] pointsAssocie = s.associatePoints(closest);
        Point paX = pointsAssocie[0]; //en x
        Point paZ = pointsAssocie[1]; //en z


        //donne le y du point d'impact
        float heightSurfaceImpact = s.barrycentric(paX, paZ, closest, position);

        float sphereLedge = position.y;

        for(float alpha = 0; alpha > -PI/2; alpha-= 0.001){
            sphereLedge += r * sin(alpha);
            if(sphereLedge > heightSurfaceImpact){
                return;
            }
        }

        position.y = heightSurfaceImpact -r;

        //milieu segment en x
        float moyX = (abs(closest.x) + abs(paZ.x))/2;
        Point pMilieuX = new Point( moyX,0,closest.z);

        //milieu segment en z
        float moyZ = (abs(closest.z) + abs(paX.z))/2;
        Point pMilieuZ = new Point( closest.x,0, moyZ);

        //Calcul du pourcentage d'influence
        float distX = dist(abs(pMilieuX.x), 0, abs(pMilieuX.z), abs(position.x), 0, abs(position.z));
        float distZ = dist(abs(position.x), 0, abs(position.z), abs(pMilieuZ.x), 0, abs(pMilieuZ.z));
        float distTotal = distX + distZ;
        float coeffX = (distX/distTotal);
        float coeffZ = (distZ/distTotal);

        //calcul des pentes (coeffs directeur des segments en x et en Z)
        float aX = ((paZ.y) - (closest.y)) / ((paZ.x) - (closest.x));
        float aZ = ((paX.y) - (closest.y)) / ((paX.z) - (closest.z));

        println("paZ.x" + paZ.x + "closest.x" + closest.x);
        println("paZ.x" + paZ.x + "closest.x" + closest.x);


        //partie pour x
        float nX = cos((PI/2) - atan(aX * coeffX));
        float nY = sin((PI/2) - atan(aX * coeffX));

        //partie pour z
        float nZ = cos((PI/2) - atan(aZ * coeffZ));
        float nYZ = sin((PI/2) - atan(aZ * coeffZ));
        //System.out.println("nZ:" + nZ);
        //System.out.println("nYZ:" + nYZ);


        float vnX = velocity.x*nX + velocity.y*nY;
        float vnZ = velocity.z*nZ + velocity.y*nYZ;
        //System.out.println("vnX:" + vnX);
        //System.out.println("vnZ:" + vnZ);

        velocity.x += (k+1)*(vnX)*nX;
        velocity.y += -(k+1)*(vnX)*nY + (this.gravity.y);
        
        velocity.z += (k+1)*(vnZ)*nZ;
        velocity.y += -(k+1)*(vnZ)*nYZ;
        //System.out.println("velocity x:" + velocity.x + " y:" + velocity.y + " z:" + velocity.z);
    
        //System.out.println("position.x: " + position.x + " position.z: " + position.z);
        //System.out.println("closest: " + closest);
        //System.out.println("heightSurfaceImpact: " + heightSurfaceImpact);
        //System.out.println("sphereLedge: " + sphereLedge);

    }





    void checkWallCollision(){
        if(position.x>width){
            //position.x= width;
            println("en dehors de la map x");
            //velocity.x *= -k;
        }
        if(position.y<0){
            //position.y=0;
            println("en dehors de la map y");

            //velocity.y*= -k;
        }
        if(position.z>width){
            //position.z=width;
            println("en dehors de la map z");

            //velocity.z*= -k;
        }
    }

    void display(){
        translate(position.x, position.y, position.z);
        noStroke();
        fill(0,0,255);
        sphere(r);
    }
}
