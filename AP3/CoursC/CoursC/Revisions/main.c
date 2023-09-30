#include <stdlib.h>
#include <stdio.h>


//== EXO 4 ============================//
struct matrice_{
    int Aa;
    int Ab;
    int Ac;
    int Ba;
    int Bb;
    int Bc;
    int Ca;
    int Cb;
    int Cc;
};
typedef struct matrice_ *matrice;

matrice createNewMatrice(int v1,int v2,int v3,int v4,int v5,int v6,int v7,int v8,int v9){
    matrice m = (matrice)malloc(sizeof(struct matrice_));
    m->Aa = v1;
    m->Ab = v2;
    m->Ac = v3;
    m->Ba = v4;
    m->Bb = v5;
    m->Bc = v6;
    m->Ca = v7;
    m->Cb = v8;
    m->Cc = v9;
    return m;
}

void afficherMatrice(matrice m){
    printf("%d | %d | %d \n",m->Aa,m->Ab,m->Ac);
    printf("%d | %d | %d \n",m->Ba,m->Bb,m->Bc);
    printf("%d | %d | %d \n",m->Ca,m->Cb,m->Cc);
}

void multiplierMatrices(matrice m1, matrice m2){

    matrice newM = createNewMatrice(0,0,0,0,0,0,0,0,0);
    
    for(int i=0; i<9; i++){
        int res = 0;
        for(int j=0; j<3; j++){
            /*
            printf("%d\n", m1->Aa+j);
            printf("%d\n", m2->Aa+(i%3)+(j*3));
            printf("-----\n");
            */
            res += (m1->Aa+(i%3)+j) * (m2->Aa+(i%3)+(j*3));
            
        }
        printf("res = %d\n", res);
       
    }
    





}

//== EXO 3 ============================//
void newValue(int *a,int *b){
    *a = *a + *b;
}
//=====================================//
void main(){
    printf("Hell world\n");

    //== EXO 3 ============================//
    int a = 5;
    int b = 12;
    newValue (&a , &b);
    printf("Ma val : %d \n",a);
    /*
    
    
    //== EXO 4 ============================//
    matrice m1 = createNewMatrice(1,2,3,4,5,6,7,8,9);
    afficherMatrice(m1);
    printf("\n");
    matrice m2 = createNewMatrice(11,12,13,14,15,16,17,18,19);
    afficherMatrice(m2);

    multiplierMatrices(m1,m2);

    //== EXO 5 ============================//
    */


    printf("\n");
    return;
}

