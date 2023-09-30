#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

struct liste_
{
    int value;
    struct liste_ *next;
};
typedef struct liste_ *liste;

struct listeD_ {
    int value;
    struct listeD_ * next;
    struct listeD_ * prev;
};
typedef struct listeD_ * listeD;

liste createNew(int v)
{
    liste elt = malloc(sizeof(struct liste_));
    elt->value = v;
    elt->next = NULL;

    return elt;
}

void add(liste maListe, int new)
{
    while (maListe->next != NULL)
    {
        maListe = maListe->next;
    }
    maListe->next = createNew(new);
}


int compter(liste maListe){
    int somme = 0;
    while (maListe!= NULL){
        //printf("%d\n", maListe->value);
        maListe = maListe->next;
        somme ++;
    }
    return somme;
}

void afficher(liste maListe){
    while (maListe!= NULL){
        printf("%d - ", maListe->value);
        maListe = maListe->next;
    }
    printf("\n");
}

void afficher2(listeD maListe){
    while (maListe!= NULL){
        printf("%d - ", maListe->value);
        maListe = maListe->next;
    }
    printf("\n");
}

void afficher2ParFin(listeD maListe){
    while (maListe->next!= NULL){
        maListe = maListe->next;
    }

    while (maListe!= NULL){
        printf("%d - ", maListe->value);
        maListe = maListe->prev;
    }
    printf("\n");
    
        
}


listeD createNewD(int val){
    listeD l = (listeD)malloc(sizeof(struct listeD_));
    l->value = val;
    l->next = NULL;
    l->prev=NULL;
    return l;
}

listeD addD(listeD l, int val){
    if(l==NULL){ printf("error"); }
    while(l->next!=NULL)
    {
        l=l->next;
    }
    l->next = createNewD(val);
    l->next->prev = l;
}

void fusionListe(liste maListe1, liste maListe2){
    while (maListe1->next != NULL){
        maListe1 = maListe1->next;
    }
    maListe1->next = maListe2;
}

void fusionListeD(listeD maListe1, listeD maListe2){
    while (maListe1->next != NULL){
        maListe1 = maListe1->next;
    }
    maListe1->next = maListe2;
    maListe1->next->prev = maListe1;
    //maListe2 -> prev = maListe2
}

liste addElt(liste maListe, int val, int pos){
    if (pos<0){
        printf("Error");
        return;
    }
    
    int max = compter(maListe);
    if(pos>= max-1){
        //Je met a la fin 
        add(maListe,val);
    }else{
        for (int i = 1; i < pos; i++){
            maListe = maListe->next;
        }
        liste newl = createNew(val);

        newl->next = maListe->next;
        maListe->next = newl;
    }
    if(pos == 0){

        liste result = maListe->next;
        free(maListe);
        return result;
        
    }

    return maListe;

}

void addEltD(listeD maListe, int val, int pos){

}

void space(){
    printf("\n");
}

int main(int argc, char const *argv[]){
    
    printf("\n");
    printf("\n");
    printf("\n");
    
    liste l = createNew(42);
    //add(l, 42);
    add(l, 35);
    add(l, 28);
    add(l, 27);

    liste l2 = createNew(1);
    //add(l, 42);
    add(l2, 2);
    add(l2, 3);
    add(l2, 4);

    
    fusionListe(l,l2);
    printf("Ma nouvelle liste:\n");
    afficher(l);

    listeD lisD = createNewD(50);
    for(int i = 1; i<3; i++)
    {
        addD(lisD, i+50);
    }

    listeD lisD2 = createNewD(60);
    for(int i = 1; i<3; i++)
    {
        addD(lisD2, i+60);
    }
    printf("Ma premiere liste D:\n");
    afficher2(lisD);
    space();
    printf("Ma deuxieme liste D:\n");
    afficher2(lisD2);
    space();
    fusionListeD(lisD,lisD2);
    printf("Ma premiere liste D fusuonee:\n");
    afficher2(lisD);
    space();
    printf("Ma premiere liste D fusuonee par la fin:\n");
    afficher2ParFin(lisD);
    space();
    printf("-------------------------\n");
    printf("Ma liste:\n");
    afficher(l);
    space();
    l = addElt(l,0,0);
    printf("Ma nouvelle liste:\n");
    afficher(l);
    space();
    //addEltD(lisD,0,1);

    //printf("La liste fait %d element(s)", compter(l));
}




