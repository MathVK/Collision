class Slab{
    Point p1, p2, p3, p4;
    int nbSquare;
    Point[] points;

    Slab(Point p1, Point p2, Point p3, Point p4){
        this.p1=p1;
        this.p2=p2;
        this.p3=p3;
        this.p4=p4;
        this.points = new Point[] {p1,p2,p3, p4};
    }

    Point closestPoint(float targetx, float targetz, Point[] points) {
        Point closest = p1;
        float minDelta = Float.MAX_VALUE;
        for(int i = 0; i < 4; i++){
            float delta = dist(abs(targetx), abs(targetz), abs(points[i].x), abs(points[i].z));
            if(delta < minDelta) {
                minDelta = delta;
                closest = points[i];
            }
        }
        return closest;
    }

    Point[] associatePoints(Point closest){
        Point[] associatePoints = new Point[2];
        if((closest.x == p1.x) && (closest.z == p1.z)) {
            associatePoints[0] = p2;
            associatePoints[1] = p3;
        } else if((closest.x == p2.x) && (closest.z == p2.z)){
            associatePoints[0] = p1;
            associatePoints[1] = p4;      
        } else if((closest.x == p3.x) && (closest.z == p3.z)){
            associatePoints[0] = p4;
            associatePoints[1] = p1;      
        } else if((closest.x == p4.x) && (closest.z == p4.z)){
            associatePoints[0] = p3;
            associatePoints[1] = p2;      
        }
        return associatePoints;
    }

    float barrycentric(Point p1, Point p2, Point p3, Point pos) {
        float det = (p2.z - p3.z) * (p1.x - p3.x) + (p3.x - p2.x) * (p1.z - p3.z);
        float l1 = ((p2.z - p3.z) * (pos.x - p3.x) + (p3.x - p2.x) * (pos.z - p3.z)) / det;
        float l2 = ((p3.z - p1.z) * (pos.x - p3.x) + (p1.x - p3.x) * (pos.z - p3.z)) / det;
        float l3 = 1.0f - l1 - l2;
        return l1 * p1.y + l2 * p2.y + l3 * p3.y;
    }

    void equationDuPlan(Point p1, Point p2, Point p3){
        //calcul des vecteurs
        Point v = new Point(p2.x-p1.x, p2.y-p1.y, p2.y-p1.z);
        Point w = new Point(p3.x-p1.x, p3.y-p1.y, p3.z-p1.z);

        //calcul produit vectoriel
        float i = (v.y * w.z) - (v.z * w.y);
        float j = (v.z * w.x) - (v.x * w.z);
        float k = (v.x - w.y) - (v.y * w.x);

        //vecteur normal
        Point n = new Point(i,j,k);

        //calcul de la constante
        float d = n.x* p1.x + n.y * p1.y + n.z * p1.z;
    }

    void display(){
        beginShape(QUADS);
            stroke(0,0,0);
            fill(255,0,0);
            vertex(p1.x, p1.y, p1.z);
            vertex(p2.x, p2.y, p2.z);
            vertex(p3.x, p3.y, p3.z);
            vertex(p4.x, p4.y, p4.z);
        endShape();            
    }

}