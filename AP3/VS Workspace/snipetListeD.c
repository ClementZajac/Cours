#include <stdlib.h>
#include <stdio.h>

struct listeD_{
    int val;
    struct listeD_ *next;
    struct listeD_ *prev;
};
typedef struct listeD_ *listeD;

listeD createNewD(int val){
    listeD l = (listeD)malloc(sizeof(struct listeD_));
    l->val = val;
    l->next = NULL;
    l->prev = NULL;
    return l;
}

listeD addD(listeD l, int val){
    if (l == NULL){
        printf("error");
    }
    while (l->next != NULL){
        l = l->next;
    }
    l->next = createNewD(val);
    l->next->prev = l;
}

void showD(listeD l){
    int i = 0;
    while (l != NULL){
        printf("chaine simple. val = %d. next = %p. prev = %p\n", l->val, l->next, l->prev);
        l = l->next;
        i++;
    }
    printf("total : %d elements\n", i);
    return;
}

void fusionD(listeD l1, listeD l2){
    while (l1->next != NULL){
        l1 = l1->next;
    }
    l1->next = l2;
    l2->prev = l1;
    return;
}

listeD addDSpot(listeD l, int val, int spot){
    listeD start = l;
    if (spot == 0){
        listeD newStart = createNewD(val);
        newStart->next = start;
        start->prev = newStart;
        return newStart;
    }
    for (int i = 0; i < spot - 1; i++){ // le -1 est là pour que l'appel soit plus intuitif
    
        if (l == NULL){
            printf("error, list too smal\n");
            return start;
        }
        l = l->next;
    }
    if (l->next != NULL){
        listeD l2 = l->next;
        l->next = createNewD(val);
        l->next->next = l2;
    }else{
        l->next = createNewD(val);
    }
    return start;
}

listeD removeDSpot(listeD l, int spot){
    listeD start = l;
    if (spot == 0){
        listeD result = l->next;
        free(l);
        result->prev = NULL;
        return result;
    }
    for (int i = 0; i < spot - 1; i++){ // le -1 est là pour que l'appel soit plus intuitif
    
        if (l->next == NULL){
            printf("error, list too small\n");
            return start;
        }
        l = l->next;
    }
    if (l->next->next != NULL){
        listeD newNext = l->next->next;
        free(l->next);
        l->next = newNext;
        newNext->prev = l;
    }else{
        free(l->next);
        l->next = NULL;
    }
    return start;
}

void main(){
    //Cree un premier maillon de la chaine "lisD"
    listeD lisD = createNewD(50);

    //Cree ajouter X maillon(s) à la chaine "lisD"
    for (int i = 1; i < 5; i++){
        addD(lisD, i + 50);
    }

    //Cree un premier maillon de la chaine "lisD"
    listeD lisD2 = createNewD(70);

    //Cree ajouter X maillon(s) à la chaine "lisD"
    for (int i = 1; i < 5; i++){
        addD(lisD2, i + 70);
    }
    printf("****\n");
    showD(lisD);
    printf("****\n");
    //Fusionne lisD et lisD2 ==> Attache la fin de lisD au debut de lisD2
    fusionD(lisD, lisD2);
    showD(lisD);

    //Ajoute à la liste "lisD2" l'element "666" a l'emplacement "0"
    lisD = addDSpot(lisD,666,0);
    lisD = addDSpot(lisD,666,2);
    lisD = addDSpot(lisD,666,5);


    showD(lisD);

    //Supprime de la liste "lisD2" l'element "666" a l'emplacement "0"
    lisD = removeDSpot(lisD,0);
    lisD = removeDSpot(lisD,3);

    showD(lisD);

    return;
}
