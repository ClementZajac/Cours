#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

/*Questions de cours

1.
char : 1 octet
int : 2 ou 4 octets (selon le systeme d'exploitation)
float : 4 octets
long : 4 octets
double : 8 octets
long double : 10 octets (parfois 12 ou 16 selon les systemes)

2.
for (int i = 0; i<10; i++)
{
    //code
}

3.
entier : int * a

generique : void * b

3eme lettre, avec char * mot = "hello"
char * c = &mot[3]

tableau de tableaud 'entiers : int ** d

4.
calloc() initialise la memoire reservee a 0 bit a bit
*/

// Exercice 1
void exo1(int n) {
    for (int i = 0; i < n; i++) {
        printf("*");
        if (i == 0 || i == n - 1) {
            for (int j = 1; j < n - 1; j++) {
                printf("*");
            }
        }
        else {
            for (int j = 1; j < n - 1; j++) {
                printf(" ");
            }
        }
        printf("* \n");
    }
}

//------------------------------------------------

void triTrois(int* a, int* b, int* c) {
    int buffer = 0;
    if (*a >= *b && *a >= *c)
    {
        buffer = *c;
        *c = *a;
        *a = buffer;
    }
    else if (*b >= *a && *b >= *c)
    {
        buffer = *c;
        *c = *b;
        *b = buffer;
    }
    if (*a >= *b)
    {
        buffer = *b;
        *b = *a;
        *a = buffer;
    }
}

void exo2()
{
    int a = 10;
    int b = 15;
    int c = 5;

    printf("Avant fonction : a = %d, b = %d, c = %d\n", a, b, c);

    triTrois(&a, &b, &c);

    printf("Apres fonction : a = %d, b = %d, c = %d\n", a, b, c);

    return;
}

//------------------------------------------------

void intToString(int nombre, char * cible)
{
    int tmp = nombre;
    int curseur = 0;
    int size = (int)log10(nombre);
    int bitFort;
    while (size>0) {
        bitFort = (int)(tmp / pow(10, size));
        cible[curseur] = (char)(48 + bitFort);
        curseur++;
        tmp = tmp - bitFort*pow(10,size);
        size--;
    }
    cible[curseur] = '\0';
    return;
}

int findString(char* texte)
{
    int curseur = 0;
    while (texte[curseur] != '\0')
    {
        if (texte[curseur] == '%')
        {
            if (texte[curseur + 1] == 'd')
            {
                return curseur;
            }
        }
        curseur++;
    }
    return -1;
}

void copyNChar(char* source, int debutSource, int finSource, char* cible, int debutCible)
{
    int curseur = debutCible;
    for (int i = debutSource; i < finSource; i++)
    {
        cible[curseur] = source[i];
        curseur++;
    }
    cible[curseur] = '\0';

}

char * printfRedo(char* texte, int* valeurs)
{
    int curseurValeur = 0;
    int curseurTexte = 0;
    curseurTexte = findString(texte);

    char* avant = (char*)malloc(50);
    char* insert = (char*)malloc(50);
    char* apres = (char*)malloc(50);

    while (curseurTexte != -1)
    {
        copyNChar(texte, 0, curseurTexte, avant, 0);
        intToString(valeurs[curseurValeur], insert);
        copyNChar(texte, curseurTexte+2, strlen(texte), apres, 0);

        strcat_s(avant, 50, insert);
        strcat_s(avant, 50, apres);

        texte = avant;

        curseurTexte = findString(texte);
        curseurValeur++;

    }
    return texte;
}

void exo3()
{
    char* test = (char*)malloc(100);
    test = "mon texte numero %d contiens la valeur %d";


    printf("avant : %s\n", test);
    int valeurs[2] = { 140, 52 };

    test = printfRedo(test, valeurs);
    printf("apres : %s\n", test);

    return;
}

//------------------------------------------------

typedef struct s_athlete
{
    char* nom;
    char categorie;
    int score;
} * athlete;

athlete genererAthlete()
{
    athlete ath = malloc(sizeof(struct s_athlete));
    ath->categorie = 'a' + (rand() % 4);

    ath->nom = (char*)calloc(4, sizeof(char));
    ath->nom[0] = (char)(rand() % 26 + 'A');
    ath->nom[1] = (char)(rand() % 26 + 'a');
    ath->nom[2] = (char)(rand() % 26 + 'a');
    ath->nom[3] = '\0';

    ath->score = rand() % 11;

    return ath;
}

void exo4()
{
    athlete athletes[40];

    for (int i = 0; i < 40; i++)
    {
        athletes[i] = genererAthlete();
    }

    // affiche l'athlète au meilleur score

    athlete meilleur = athletes[0];
    for (int i = 0; i < 40; i++)
    {
        if (athletes[i]->score > meilleur->score)
        {
            meilleur = athletes[i];
        }
        printf("Athlete %d : nom :%s categorie : %c score : %d\n", i, athletes[i]->nom, athletes[i]->categorie, athletes[i]->score);
    }
    printf("Meilleur athlete : \nnom :%s \ncategorie : %c \nscore : %d\n", meilleur->nom, meilleur->categorie, meilleur->score);

    //tri du tableau par bulle
    
    athlete swapBuffer;
    
    for(int i = 39; i >= 1; i--)
    {
        for(int j = 0; j <= i-1; j++)
        {
            if (
                (athletes[j]->categorie > athletes[j + 1]->categorie) ||  //categorie differente

                ( (athletes[j]->categorie == athletes[j + 1]->categorie) //meme categorie, score plus grand
                    && (athletes[j]->score > athletes[j + 1]->score) ) ||
                
                ( (athletes[j]->categorie == athletes[j + 1]->categorie) //meme categorie, meme score, ordre alphabetique (premiere lettre seulement)
                    && (athletes[j]->score == athletes[j + 1]->score)
                    && (athletes[j]->nom[0] > athletes[j + 1]->nom[0]) )
                )
            {
                swapBuffer = athletes[j];
                athletes[j] = athletes[j + 1];
                athletes[j+1] = swapBuffer;
            }
        }
        printf("Athlete %d : nom :%s categorie : %c score : %d\n", i, athletes[i]->nom, athletes[i]->categorie, athletes[i]->score);
    }
    
    return;
}

//------------------------------------------------

struct  liste_ {
    int  val;
    struct  liste_ * next;
};

typedef  struct  liste_ * liste;

liste  createNew(int v) {
    liste  elt = malloc(sizeof(struct  liste_ ));
    elt ->val = v;
    elt ->next = NULL;
    return  elt;
}

void add(liste l, int  new) {
    if(l==NULL) {
        l=createNew(new);  return ;
    }while(l->next!=NULL) {
        l=l->next;
    }
    l->next=createNew(new);
}

void  printList (liste p){
    int i=0;
    while (p != NULL) {
        printf("Element %d : %d, %p\n", i, p->val, p->next);
        p = p->next;
        i++;
        }
}

liste getElementFromListAtIndex(int idx,liste l){
    int i = 0;
    while(l!=NULL){
        if(i==idx){
            return l;
        }
        if (l->next == NULL)
        {
            return NULL;
        }
        l=l->next;
        i++;
    }
}

// on suppose que n et m sont des indices de la liste
void swapElements(liste list, int n, int m){
    if (n > 0) {
        liste listBeforeN = getElementFromListAtIndex(n - 1, list);
        liste listAtN = getElementFromListAtIndex(n, list);
        liste listAfterN = getElementFromListAtIndex(n + 1, list);

        liste listBeforeM = getElementFromListAtIndex(m - 1, list);
        liste listAtM = getElementFromListAtIndex(m, list);
        liste listAfterM = getElementFromListAtIndex(m + 1, list);
        
        if ((n - m != 1) && (m - n != 1))
        {
            listBeforeN->next = listAtM;
            listAtM->next = listAfterN;

            listBeforeM->next = listAtN;
            listAtN->next = listAfterM;
        }
        else
        {
            listBeforeN->next = listAtM;
            listAtM->next = listAtN;
            listAtN->next = listAfterM;
        }
    }
}

liste triListeChaine(liste target)
{
    int size = 0;
    liste curseur = target;
    liste smallest = target;
    liste smallestPrev = NULL;

    while (curseur != NULL) {
        if (smallest->val > curseur->val) {   
            smallest = curseur; 
            smallestPrev = getElementFromListAtIndex(size - 1, target);
        }
        curseur = curseur->next;
        size++;
    }

    if (smallest != target) {
        liste oldEnd = smallest;
        while (oldEnd->next != NULL) { oldEnd = oldEnd->next; }
        oldEnd->next = target;
        smallestPrev->next = NULL;
    }

    int j = 0;

    for(int i = 0; i <= size; i++)
    {
        j = 1;
        curseur = smallest->next;
        while(curseur->next!=NULL)
        {
            if (curseur->val > curseur->next->val)
            {
                swapElements(smallest, j, j + 1);
                curseur = getElementFromListAtIndex(j, smallest);
            }
            curseur = curseur->next;
            j++;
        }
    }

    return smallest;
}

void exo5()
{
    liste myList = createNew(5);
    add(myList, 3);
    add(myList, 12);
    add(myList, 8);
    add(myList, 0);
    add(myList, 7);

    printf("Liste avant tri\n");
    printList(myList);

    myList = triListeChaine(myList);

    printf("\nListe apres tri\n");
    printList(myList);

    return;
}

//------------------------------------------------

void main()
{
    srand(time(NULL));

    printf("\n Exo 1 : \n");
    exo1(3);
    exo1(5);

    printf("\n Exo 2 : \n");
    exo2();

    printf("\n Exo 3 : \n");
    exo3();

    printf("\n Exo 4 : \n");
    exo4();

    printf("\n Exo 5 : \n");
    exo5();

    return;
}