#include <stdlib.h>
#include <stdio.h>
#include <time.h>

//srand(time(NULL));

void exo1(int n)
{
    // On considère que le carré ne peux pas etre
    // plus petit que 2*2 sinon pas de creux
    for (int i = 0; i < n; i++)
    {
        printf("*");
    }
    printf("\n");
    for (int i = 0; i < n - 2; i++)
    {
        printf("*");
        for (int i = 0; i < n - 2; i++)
        {
            printf(" ");
        }
        printf("*\n");
    }

    for (int i = 0; i < n; i++)
    {
        printf("*");
    }
}

exo2()
{
    int *a = 10;
    int *b = 15;
    int *c = 5;
    triTrois(a, b, c);
    /*
    int *a = 1;
    int *b = 2;
    int *c = 3;
    triTrois(a, b, c);

    int*a = 3;
    int*b = 1;
    int*c = 2;
    triTrois(a, b, c);

    int*a = 2;
    int*b = 3;
    int*c = 1;
    triTrois(a, b, c);
    */

    //             *a = 10, *b = 15 et *c = 5
    // dorénavent, *a = 5, *b = 10 et *c = 15
}

exo3()
{
    int a = 20;
    char *b = (char)a;

    printf("Mon nombre en string : %s\n", b);

    char *maString = "Clement";
    int tab[3] = {10, 20, 30};
    // exo3(maString,tab);
}
struct athlete_
{
    char *nom;
    char categorie;
    int score;
};
typedef struct athlete_ *athlete;
exo4()
{
    // cree 40 athletes
    for (int i = 0; i < 40; i++)
    {
        createNewA();
    }
}

athlete createNewA()
{
    athlete a = (athlete)malloc(sizeof(struct athlete_));
    // maniere de fauire un random
    int n = rand() % 10; // nombre entre 0 et 9

    // a->nom = (faire un random avec les lettre de l'alphabet pour donner des initiales)
    // a->categorie = (faire un random etre 0 et 4, et 4 if pour asssocier les valeurs a b ou c)
    a->score = rand() % 11;
    return a;
}

struct listeS_
{
    int value;
    struct listeS_ *next;
};
typedef struct listeS_ *listeS;

/**
 * @brief Cree un nouveau maillon listeS
 *
 * @param value valeur entiere
 * @return listeS
 */
listeS createNewS(int value)
{
    listeS l = (listeS)malloc(sizeof(struct listeS_));
    l->value = value;
    l->next = NULL;
    return l;
}
/**
 * @brief Ajoute un element a une liste chainee
 *
 * @param l Liste
 * @param val Valeur à ajouter
 * @return listeS
 */
listeS addS(listeS l, int val)
{
    if (l == NULL)
    {
        printf("error");
    }
    while (l->next != NULL)
    {
        l = l->next;
    }
    l->next = createNewS(val);
}

/**
 * @brief affiche tout les elets d'une liste
 * 
 * @param l 
 */
void showSAll(listeS l)
{
    while (l != NULL)
    {
        printf("Value = %d. next = %p\n", l->value, l->next);
        l = l->next;
    }
    return;
}
/**
 * @brief conte le nbr d elements dans une liste
 * 
 * @param l 
 * @return int 
 */
int count(listeS l)
{
    int i = 0;
    while (l != NULL)
    {

        l = l->next;
        i++;
    }
    printf("Nbr elts : %d\n", i);
    return i;
}
/**
 * @brief
 *
 * @param l Liste dans la quel rechercher l element
 * @param val Position de l'element à afficher, avec 0 le preier element
 */
void showSIndex(listeS l, int val)
{
    if (count(l) - 1 < val)
    {
        printf("Erreur, valeur trop grande, la liste n'est pas assez longue\n");
    }
    for (int i = 0; i < val; i++)
    {

        l = l->next;
    }
    printf("Value = %d. next = %p\n", l->value, l->next);
    return;
}
exo5()
{
    printf("Exercice 5 \n");
    listeS lisS = createNewS(5);
    addS(lisS, 3);
    addS(lisS, 12);
    addS(lisS, 8);
    addS(lisS, 0);
    addS(lisS, 7);

    showSAll(lisS);
    count(lisS);
    showSIndex(lisS, 1);
}

void triTrois(int *a, int *b, int *c)
{
    printf("%d - %d - %d\n", a, b, c);

    int premier = 0;
    int deux = 0;
    int trois = 0;
    if (a > b && b < c && c > a)
    {
        printf("le plus grand chiffre est %d\n", c);
        premier = c;
        if (a < b)
        {
            // a plus petit
            deux = b;
            trois = a;
        }
        else
        {
            // b plus petit
            deux = a;
            trois = b;
        }
    }
    else if (b > a && c < b)
    {
        premier = b;
        printf("le plus grand chiffre est %d\n", b);
        if (a < c)
        {
            // a plus petit
            deux = c;
            trois = a;
        }
        else
        {
            // c plus petit
            deux = a;
            trois = c;
        }
    }
    else if (a > c && b < a)
    {
        premier = a;
        printf("le plus grand chiffre est %d\n", a);
        if (b < c)
        {
            // b plus petit
            deux = c;
            trois = b;
        }
        else
        {
            // c plus petit
            deux = b;
            trois = c;
        }
    }
    else
    {
        trois = a;
        deux = b;
        premier = c;
    }
    c = premier;
    b = deux;
    a = trois;
    printf("%d - %d - %d\n", a, b, c);
    return;
}

void main()
{
    // initialiser le random
    srand(time(NULL));
        /*
        //Pensez à découmenter le code pour tester les fonctions :)
        exo1(7);
        exo2();
        */
        // exo3();
        // exo4();
        // exo5();

        /*QUESTION DE COURS*/
        /*
    1)
        char 1 octets
        int 4 octets
        float 4 octets
        double 8 octets
        long 4 octets

    2)

       for (int i = 0; i < 10; i++){
           printf("%d\n",i);
       }

    3)
        int * test1;

        int test = 12;
        void * testP = &test;

        char * tab[5]= {'1','2','3','4','5'};
        char * p = tab[2];

        int * t1[2];
        int * t2[2];
        int * t3[2];
        int * tab2[3] = {t1,t2,t3};
        int * a = tab2;

    4)
        Calloc permet de mettre tout les octels que l'on reserve a 0
    */

        /*
        printf("Print d'un INT : %d \n",1);
        printf("Print d'un FLOAT : %f \n",1.2);
        printf("Print d'un CHAR : %s \n","a");
        //printf("Print d'un POINTEUR : %p \n","-mettre mon pointeur ici-");
        printf("Print d'un STRING : %s \n","Blablabla");
        printf("Print d'un hexadecimal : %x \n",12);
        printf("Print d'un octal : %o \n",8);
        */

        return;
}