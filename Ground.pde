class Ground{


    int nbSquare = 40;
    int taillePiques = 10;
    int[][] values = new int[nbSquare][nbSquare];
    Slab[][] squares = new Slab[nbSquare][nbSquare];
    
    Ground(int nbsquare, int taillePiques){
        this.squares= new Slab[nbSquare][nbSquare];
        this.values = new int[nbSquare][nbSquare];
        this.taillePiques=taillePiques;
        generatePeakValues();
        drawSurface();
    }

    void generatePeakValues(){
        for(int i = 0; i<nbSquare;i++){
            for(int j = 0 ; j<nbSquare ; j++){
                values[i][j] = (int)random(0,taillePiques);
            }
        }
    }

    /*
    void drawsurface(){
        //generate random values   
        beginShape();
            for(int i =0;i<nbSquare;i++){
                for(int j = 0;j<nbSquare;j++){
                    vertex(i*10,values[i][j],j*10);
                }
            }
        endShape(CLOSE);
    }
    */
    void drawSurface() {
        float squareSize = 10;

        for (int i = 0; i < nbSquare - 1; i++) {
            for (int j = 0; j < nbSquare - 1; j++) {
                float x = i * squareSize;
                float y = values[i][j];
                float z = j * squareSize;
                Point p0 = new Point(x,y,z);

                float x1 = i * squareSize;
                float y1 = values[i][j + 1];
                float z1 = (j + 1) * squareSize;
                Point p1 = new Point(x1,y1,z1);


                float x2 = (i + 1) * squareSize;
                float y2 = values[i + 1][j];
                float z2 = j * squareSize;
                Point p2 = new Point(x2,y2,z2);


                float x3 = (i + 1) * squareSize;
                float y3 = values[i + 1][j + 1];
                float z3 = (j + 1) * squareSize;
                Point p3 = new Point(x3,y3,z3);
                
                Slab slab = new Slab(p0,p1,p2,p3);
                this.squares[i][j]=slab;
                
                

                // Draw a quad for each set of four points
                beginShape();
                    fill(255);
                    vertex(x, y, z);
                    vertex(x1, y1, z1);
                    vertex(x3, y3, z3);
                    vertex(x2, y2, z2);
                endShape(CLOSE);
            }
        }
    }
    /*
    void afficheTableau(Slab[][] squares){
        for(int i = 0; i<nbSquare;i++){
            for(int j = 0; j<nbsquare;j++){
                print(squares[i][j].p1.x,squares[i][j].p1.y,squares[i][j].p1.z,
                squares[i][j].p2.x,squares[i][j].p2.y,squares[i][j].p2.z,
                squares[i][j].p3.x,squares[i][j].p3.y,squares[i][j].p3.z,
                squares[i][j].p4.x,squares[i][j].p4.y,squares[i][j].p4.z
                )
            }
        }
    }
    */
}

