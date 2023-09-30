#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int nombreMaillon = 9; 
int max_value = 10;
int lectures = 0;
int ecritures = 0;

double aleatoire()
{ /* créer un nombre aléatoire*/
    double nombreAlea = rand() % (max_value+1) ;
    // int nombreAlea2 = ((rand() * rand()) % max_value)+1; /* 2e nombre aléatoire pour question 3*/
    // printf("%d", nombreAlea2);
    return nombreAlea;
}
struct listeS_{
    double val;
    struct listeS_ *next;
};
typedef struct listeS_ *listeS;


listeS createNewS(double value){
    listeS l = (listeS)malloc(sizeof(struct listeS_));
    l->val = value;
    l->next = NULL;
    return l;
}

listeS addS(listeS l, double val){
    if (l == NULL){
        printf("error");
    }
    while (l->next != NULL){
        l = l->next;
    }
    l->next = createNewS(val);
}


void showS(listeS l){
    int i = 0;
    while (l != NULL){
        printf("chaine simple. val = %f. next = %p\n", l->val, l->next);
        l = l->next;
        i++;
    }
    printf("total : %d elements\n", i);
    return;
}

int main (){
    srand( time( NULL ) );
    listeS l = createNewS(500000);
    
    int i = 0;
    int j = 0;

    while (i < nombreMaillon)
    {
        int existe = 0;
        double nombreliste = aleatoire();
        listeS lTemporaire = l;
        while (lTemporaire!= NULL) /* boucle qui vérifie les doublons */
        {
            if (lTemporaire->val == nombreliste)
            { /* si le nombre existe déjà, j'arrête*/
                existe = 1;
                break;
            }
            lTemporaire = lTemporaire->next;
        }
        if (existe == 0)
        {
            addS(l, nombreliste);
            i++;
        }
        
    }
    showS(l);
}