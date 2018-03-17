/* cc create_lig.c -lm -o create_lig -O3 */


/* Rong Chen 1/15/2002 */

#include <strings.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

void rotateAtom(float, float, float, float *, float *, float *,
		float, float, float );
void creatPDB(char *, char *, float, float, float, float, float,
	      float, float, float, float, float, float, float, 
	      int, int, int, int, float);

/**********************************************/
/* Function rotateAtom  */
/*  rotates around 3 euler angles  */
/**********************************************/
void rotateAtom (float oldX, float oldY, float oldZ,
                 float *newX, float *newY, float *newZ,
                 float psi, float theta, float phi )
{
  float r11, r21, r31, r12, r22, r32, r13, r23, r33;
  r11 = cos(psi)*cos(phi)  -  sin(psi)*cos(theta)*sin(phi);
  r21 = sin(psi)*cos(phi)  +  cos(psi)*cos(theta)*sin(phi);
  r31 = sin(theta)*sin(phi);

  r12 = -cos(psi)*sin(phi)  -  sin(psi)*cos(theta)*cos(phi);
  r22 = -sin(psi)*sin(phi)  +  cos(psi)*cos(theta)*cos(phi);
  r32 = sin(theta)*cos(phi);

  r13 = sin(psi)*sin(theta);
  r23 = -cos(psi)*sin(theta);
  r33 = cos(theta);

  *newX = r11 * oldX + r12 * oldY + r13 * oldZ;
  *newY = r21 * oldX + r22 * oldY + r23 * oldZ;
  *newZ = r31 * oldX + r32 * oldY + r33 * oldZ;

} /* rotateAtom */

/**************************************************************/
void creatPDB(char *out, char *in, float rand1, float rand2, float rand3,
	      float r1, float r2, float r3, float l1, float l2, float l3, 
	      float a1, float a2, float a3, int t1, int t2, int t3, int N,
	      float spacing)
{
  FILE *new, *old;
  char liner[85], coord1[10], coord2[10], coord3[10], lastline[85];
  float tx1, ty1, tz1, tx2, ty2, tz2, oldx, oldy, oldz;
  new = fopen(out, "w");
  old = fopen(in, "r");
  while ((fgets(liner,31,old))!=NULL){
    fgets(coord1,9,old); /* get coordinate_x */
    oldx=atof(coord1)-l1;          /* convert coordinate to float */
    fgets(coord2,9,old); /* get coordinate_y */
    oldy=atof(coord2)-l2;          /* convert coordinate to float */
    fgets(coord3,9,old); /* get coordinate_z */
    oldz=atof(coord3)-l3;          /* convert coordinate to float */
    fgets(lastline,40,old); /* get stuff after coords in pdb */
    rotateAtom(oldx, oldy, oldz, &tx1, &ty1, &tz1, rand1, rand2, rand3);
    rotateAtom(tx1, ty1, tz1, &tx2, &ty2, &tz2, a1, a2, a3);
    /* adjust so coordinates are in the box */
    if (t1 >= N/2) t1 -= N;
    if (t2 >= N/2) t2 -= N;  
    if (t3 >= N/2) t3 -= N;  
  	
    /* write to the file using grid-adjusted coords */
    fprintf (new,"%s%8.3f%8.3f%8.3f%s", liner, tx2-t1*spacing+r1, 
	     ty2-t2*spacing+r2, tz2-t3*spacing+r3, lastline); 
  }
  fclose(old);
  fclose(new);
}
 /* createPDB */
/***********************************************/
/* The main function of the program that */
/*  dishes out all the dirty work.    */
/***********************************************/
int main(int argc, char **argv )  
{ 

  char out[30], in[30]; /* new file and old file */
  float r1, r2, r3, l1, l2, l3, a1, a2, a3, t1, t2, t3, rand1, rand2, rand3, spacing;
  int N;

  if (argc != 20){
    printf("\n%s new_pdb ligand.pdb rand1 rand2 rand3 r_x r_y r_z l_x l_y l_z angle_x angle_y angle_z trans_x trans_y trans_z N spacing", argv[0]);
    printf("\n  **Note: files must be in PDB format.\n");
    exit( -1 );
  }
  
  strcpy(out, argv[1]);
  strcpy(in, argv[2]);
  rand1=atof(argv[3]);
  rand2=atof(argv[4]);
  rand3=atof(argv[5]);
  r1=atof(argv[6]);
  r2=atof(argv[7]);
  r3=atof(argv[8]);
  l1=atof(argv[9]);
  l2=atof(argv[10]);
  l3=atof(argv[11]);
  a1=atof(argv[12]);
  a2=atof(argv[13]);
  a3=atof(argv[14]);
  t1=atoi(argv[15]);
  t2=atoi(argv[16]);
  t3=atoi(argv[17]);
  N=atoi(argv[18]);
  spacing=atof(argv[19]);

  creatPDB(out, in, rand1, rand2, rand3, r1, r2, r3, l1, l2, l3, 
	   a1, a2, a3, t1, t2, t3, N, spacing);
  
  return 1;
  
} /* main */
