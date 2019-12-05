//==================================================================================================
//Set des variables
PImage img;
PrintWriter output;
color[] Color = new color[256];
int[][] arrayColor;

File dir;
File [] files;

int maxCouleurs=256, nbrCouleurs, timer;

//Fin du set de variables
//==================================================================================================


//==================================================================================================
//Initialisation
void setup(){
        dir = new File(sketchPath("images/"));
        files = dir.listFiles();

        for (int ipath = 0; ipath <= files.length - 1; ipath++)
        {
                String path = files[ipath].getAbsolutePath();
                if (path.toLowerCase().endsWith(".bmp"))
                {
                        println(path.toLowerCase() + " " + ipath);
                        img = loadImage(path);
                        output = createWriter("output\\"+ ipath + ".txt"); //Cree le fichier dans le quel le resultat sera écrit.
                        nbrCouleurs=0;
                        timer=0;
                        arrayColor = new int[img.width][img.height];
                        println("Largeur : " + img.width + ", Hauteur : " + img.height);

                        for(int i=0; i<maxCouleurs; i++) Color[i] = 0; //Initialise le tableau

                        for(int y=0; y <= img.height; y++) { //Liste les couleurs de l'image
                                for(int x=0; x <= img.width; x++) { //Scanne tous les pixels de l'image
                                        int colorPixel = img.get(x, y);
                                        for(int i=0; i < Color.length; i++) {
                                                if(colorPixel == Color[i]) {
                                                        timer++;
                                                }
                                        }
                                        if(timer == 0) { //Permet de dresser une liste des couleurs de l'image
                                                int i=0;
                                                while(Color[i] !=0) i++;
                                                Color[i]=colorPixel;
                                                nbrCouleurs++;
                                                println("Got color n"+i+" : "+colorPixel);
                                        }

                                        timer=0;
                                }
                        }

                        output.println(img.width+"|"+img.height+"|"+nbrCouleurs); //(Debug forever)
                        String temp = "";
                        for(int i=0; i<Color.length; i++){
                          if(Color[i]!=0) temp+=(Color[i]+"|"); //(Debug forever)
                        }
                        output.println(temp);

                        for(int y=0; y<img.height; y++) { //Genere le fichier texte
                                String tempx = "";
                                for(int x=0; x<img.width; x++) { //Scanne tous les pixels de l'image
                                        int colorPixel = img.get(x,y);
                                        for(int colors=0; colors<Color.length; colors++) {
                                                if(colorPixel == Color[colors]) {
                                                        tempx += (colors + "|");
                                                        break;
                                                }
                                        }
                                }
                                output.println(tempx);
                        }
                        output.println(path);
                        output.flush();//Ecrit le texte dans le fichier
                }
        }
        exit();
}
//Fin traitement
//==================================================================================================
