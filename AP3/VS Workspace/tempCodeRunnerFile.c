#include <stdlib.h>
#include <stdio.h>

struct listeS_{
    int val;
    struct listeS_ *next;
};
typedef struct listeS_ *listeS;

listeS createNewS(int val){
    listeS l = (listeS)malloc(sizeof(struct listeS_));
    l->val = val;
    l->next = NULL;
    return l;
}

listeS addS(listeS l, int val){
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
        printf("chaine simple. val = %d. next = %p\n", l->val, l->next);
        l = l->next;
        i++;
    }
    printf("total : %d elements\n", i);
    return;
}

void fusionS(listeS l1, listeS l2){
    while (l1->next != NULL){
        l1 = l1->next;
    }
    l1->next = l2;
    return;
}

listeS addSSpot(listeS l, int val, int spot){
    listeS start = l;
    if (spot == 0){
        listeS newStart = createNewS(val);
        newStart->next = start;
        return newStart;
    }

    for (int i = 0; i < spot - 1; i++){ // le -1 est là pour que l'appel soit plus intuitif
    
        if (l == NULL){
            printf("error, list too small\n");
            return start;
        }
        l = l->next;
    }

    if (l->next != NULL){
        listeS l2 = l->next;
        l->next = createNewS(val);
        l->next->next = l2;
    }else{
        l->next = createNewS(val);
    }
    return start;
}

listeS removeSSpot(listeS l, int spot){
    listeS start = l;
    if (spot == 0){
        listeS result = l->next;
        free(l);
        return result;
    }
    for (int i = 0; i < spot - 1; i++){ // le -1 est là pour que l'appel soit plus intuitif
    
        if (l->next == NULL){
            printf("error, list too small\n");
            return start;
        }
        l = l->next;
    }
    listeS newNext = l->next->next;
    free(l->next);
    l->next = newNext;
    return start;
}

void main(){

    printf("Print d'un INT : %d \n",1);
    printf("Print d'un FLOAT : %f \n",1.2);
    printf("Print d'un CHAR : %s \n","a");
    //printf("Print d'un POINTEUR : %p \n","-mettre mon pointeur ici-");
    printf("Print d'un STRING : %s \n","Blablabla");
    printf("Print d'un hexadécimal : %x \n",12);
    printf("Print d'un octal : %o \n",12);
    listeS lisS = createNewS(0);
    for (int i = 1; i < 5; i++){
        addS(lisS, i);
    }

    listeS lisS2 = createNewS(31);
    for (int i = 0; i < 5; i++){
        addS(lisS, i + 30);
    }

    showS(lisS);

    fusionS(lisS, lisS2);
    showS(lisS);

    lisS = addSSpot(lisS, -3, 5);
    lisS = addSSpot(lisS, -9, 0);
    lisS = addSSpot(lisS, -15, 23);

    showS(lisS);
    lisS = removeSSpot(lisS, 2);
    lisS = removeSSpot(lisS, 0);

    showS(lisS);

    return;
}