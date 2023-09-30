#include <stdlib.h>
#include <stdio.h>

struct listeS_ {
    int val;
    struct listeS_ * next;
};
typedef struct listeS_ * listeS;

struct listeD_ {
    int val;
    struct listeD_ * next;
    struct listeD_ * prev;
};
typedef struct listeD_ * listeD;

listeS createNewS(int val){
    listeS l = (listeS)malloc(sizeof(struct listeS_));
    l->val = val;
    l->next = NULL;
    return l;
}

listeD createNewD(int val){
    listeD l = (listeD)malloc(sizeof(struct listeD_));
    l->val = val;
    l->next = NULL;
    l->prev=NULL;
    return l;
}

listeS addS(listeS l, int val){
    if(l==NULL){ printf("error"); }
    while(l->next!=NULL)
    {
        l=l->next;
    }
    l->next = createNewS(val);
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


void showS(listeS l){
    int i = 0;
    while(l!=NULL)
    {
        printf("chaine simple. val = %d. next = %p\n", l->val, l->next);
        l=l->next;
        i++;
    }
    printf("total : %d elements\n", i);
    return;
}

void showD(listeD l){
    int i = 0;
    while(l!=NULL)
    {
        printf("chaine simple. val = %d. next = %p. prev = %p\n", l->val, l->next, l->prev);
        l=l->next;
        i++;
    }
    printf("total : %d elements\n", i);
    return;
}

void fusionS(listeS l1, listeS l2){
    while(l1->next!=NULL)
    {
        l1=l1->next;
    }
    l1->next = l2;
    return;
}

void fusionD(listeD l1, listeD l2){
    while(l1->next!=NULL)
    {
        l1=l1->next;
    }
    l1->next = l2;
    l2->prev = l1;
    return;
}

listeS addSSpot(listeS l, int val, int spot){
    listeS start = l;
    if (spot==0)
    {
        listeS newStart = createNewS(val);
        newStart->next=start;
        return newStart;
    }
    for(int i = 0; i<spot-1; i++)  //le -1 est là pour que l'appel soit plus intuitif
    {
        if(l==NULL) {printf("error, list too small"); return start;}
        l=l->next;
    }
    if(l->next!=NULL) { 
        listeS l2 = l->next;
        l->next = createNewS(val);
        l->next->next = l2; 
    }
    else { l->next = createNewS(val); }
    return start;
}

listeD addDSpot(listeD l, int val, int spot){
    listeD start = l;
    if (spot==0)
    {
        listeD newStart = createNewD(val);
        newStart->next=start;
        start->prev = newStart;
        return newStart;
    }
    for(int i = 0; i<spot-1; i++) //le -1 est là pour que l'appel soit plus intuitif
    {
        if(l==NULL) {printf("error, list too small"); return start;}
        l=l->next;
    }
    if(l->next!=NULL) { 
        listeD l2 = l->next;
        l->next = createNewD(val);
        l->next->next = l2; 
    }
    else { l->next = createNewD(val); }
    return start;
}

listeS removeSSpot(listeS l, int spot){
    listeS start = l;
    if (spot==0)
    {
        listeS result = l->next;
        free(l);
        return result;
    }
    for(int i = 0; i<spot-1; i++)  //le -1 est là pour que l'appel soit plus intuitif
    {
        if(l->next==NULL) {printf("error, list too small"); return start;}
        l=l->next;
    }
    listeS newNext = l->next->next;
    free (l->next);
    l->next = newNext; 
    return start;
}

listeS removeDSpot(listeD l, int spot){
    listeD start = l;
    if (spot==0)
    {
        listeS result = l->next;
        free(l);
        result->prev = NULL;
        return result;
    }
    for(int i = 0; i<spot-1; i++)  //le -1 est là pour que l'appel soit plus intuitif
    {
        if(l->next==NULL) {printf("error, list too small"); return start;}
        l=l->next;
    }
    if(l->next->next!=NULL) { 
        listeD newNext = l->next->next;
        free (l->next);
        l->next = newNext;
        newNext->prev = l;
    }
    else { 
        free(l->next);
        l->next = NULL;
    }
    return start;
}


void main()
{
    listeS lisS = createNewS(1);
    for(int i = 0; i<10; i++)
    {
        addS(lisS, i);
    }
    listeS lisS2 = createNewS(31);
    for(int i = 0; i<10; i++)
    {
        addS(lisS, i+30);
    }

    listeD lisD = createNewD(51);
    for(int i = 0; i<10; i++)
    {
        addD(lisD, i+50);
    }
    listeD lisD2 = createNewD(71);
    for(int i = 0; i<10; i++)
    {
        addD(lisD, i+70);
    }

    //showS(lisS);
    //showD(lisD);

//    fusionS(lisS, lisS2);
//    fusionD(lisD, lisD2);
//    showS(lisS);
//    showD(lisD);

    lisS = addSSpot(lisS, -3,5);
    lisS = addSSpot(lisS, -9,0);
    lisS = addSSpot(lisS, -15,23);

    showS(lisS);

    lisS = removeSSpot(lisS, 7);
    lisS = removeSSpot(lisS, 0);
    

    showS(lisS);

    return;
}