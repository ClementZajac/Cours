#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

int main(int argc, char const *argv[]){
    /*
    printf("Hello Etienneeee");

    int nombre = 0;
    int res;
    printf("Entrez une valeur : ");
    res = scanf("%d", &nombre);
    if (res == 1)
    printf("Votre valeur est %d.\n", nombre);
    */
    
    // traitement de l’erreur

    printf("\n");
    printf("\n");
    printf("\n");
    printf("\n");
    printf("\n");

    /*
    int a = 1; 
    int *monPtr = &a;
    getAdress(monPtr);
    */
    //TP3();

    
    
    srand(time(NULL));
    test(int)
    //TP3exo3();
    return 0;
}

void test(int v){
    printf("%d",v);
}

void getAdress(void *var){
    printf("%p\n",var);
    
}

int TP3(){

    typedef struct _etudiant{
        char * nom;
        char * promo;
        int tab[10]
        //int * tab = (int*) malloc (15* sizeof(int ));   
    } etudiant;

    etudiant myStudent;

    myStudent.nom = "Moi";
    //myStudent.tab = {10,2,5,4,5,7,5,5,8,7};
    //myStudent.tab[10] = [1, 2, 6, 5, 2, 1, 9, 8, 1, 5];


    int moyenne = 0;
    for (int i = 0; i < 10; i++){
        moyenne += myStudent.tab[i];
        
        printf("%d\n", moyenne);

    }
    moyenne = moyenne / sizeof(myStudent.tab);

    printf("%d", moyenne);
    
    




}
/*
int TP3exo3(){
    
    typedef struct _chat{
        char * nom;
        char * couleur;
        //int * tab = (int*) malloc (15* sizeof(int ));   
    } chat;

    int r = rand()%4;
    
    chat new = (chat) malloc(sizeof(chat));




}








*/