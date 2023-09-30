#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h> //on utilise l'heure pour initialiser les nombres aleatoires

struct eleve{
    char * nom;
    char * promo;
    int * notes;
};
typedef struct eleve * eleveP;  //eleveP sera notre pointeur utilise dans l'exercice 1

eleveP newEleve()  //fonction de creation
{
    eleveP new = (eleveP)malloc(sizeof(struct eleve));
    new -> nom = (char *)calloc(4, sizeof(char));
    new -> nom[0] = (char) (rand()%26+97);
    new -> nom[1] = (char) (rand()%26+97);
    new -> nom[2] = (char) (rand()%26+97);
    new -> nom[3] = '\0';
    new -> promo = "AP3";
    new -> notes = (int *)calloc(10, sizeof(int));  //on doit preparer 10 valeurs
    for (int i = 0; i<10;i++)
    {
        new->notes[i]=rand()%21;                //generation aleatoire
    }
    return new;   
}

float moyenneEleve (eleveP el)
{
    int sum = 0;
    for(int i =0; i<10;i++)
    {
        sum += el->notes[i];
    }
    return (float)sum/10;
}

void ex1()
{
    eleveP test = newEleve();
    printf("New student : %s\nPromo : %s\nNotes : \n",test->nom,test->promo);
    
    for (int i =0; i<10; i++)
    {
        printf("%d\n",test->notes[i]);
    }

    printf("Moyenne : %f\n",moyenneEleve(test));

    eleveP classe[30];

    for(int i = 0; i<30; i++)
    {
        classe[i] = newEleve();
    }

    float totalsum = 0;
    for(int j = 0; j<30; j++)
    {
        totalsum += moyenneEleve(classe[j]);
    }
    printf("moyenne generale : %f\n", totalsum/30);


    return;
}

struct complex {
    int reel;
    int im;
};
typedef struct complex * comP;

comP newComp(int a, int b)
{
    comP new = malloc(sizeof(struct complex));
    new -> reel = a;
    new -> im = b;
    return new;
}

void showComp(comP a)
{
    printf("Partie reele : %d\nPartie imaginaire : %d\n", a->reel, a->im);
    return;
}

comP cAdd(comP a, comP b)
{
    return newComp(a->reel + b-> reel, a->im + b->im);
}

comP cSubstract(comP a, comP b)
{
    return newComp(a->reel - b-> reel, a->im - b->im);
}

comP cMult(comP a, comP b)
{
    return newComp( a->reel * b->reel - a->im * b->im, a->reel * b->im + a->im * b->reel);
}

comP cDivide(comP a, comP b)
{
    comP conjuge = newComp(b->reel, b->im * (-1) );
    int denom = cMult(b, conjuge)->reel;
    if(denom==0)
    {
        printf("ERROR divided by 0");
        return newComp(0,0);
    }
    comP nomin = cMult(a, conjuge);
    return newComp(nomin->reel/denom, nomin->im/denom);
}

void ex2()
{
    comP a = newComp(20,-4);
    comP b = newComp(3,2);
    printf("Addition :\n");
    showComp(cAdd(a,b));
    printf("Soustraction :\n");
    showComp(cSubstract(a,b));
    printf("Multiplication :\n");
    showComp(cMult(a,b));
    printf("Division :\n");
    showComp(cDivide(a,b));
}

struct chat
{
    char * nom;
    char * couleur;
};
typedef struct chat * chatP;

chatP newChat(char * nom)
{
    chatP new = malloc(sizeof(struct chat));
    new->nom = (char *)malloc(sizeof(char)*10);
    strcpy(new->nom, nom);
    new->couleur = (char *)malloc(sizeof(char)*10);
    int randCouleur = rand()%4;
    if (randCouleur==0) { new->couleur = "noir"; }
    if (randCouleur==1) { new->couleur = "gris"; }
    if (randCouleur==2) { new->couleur = "blanc"; }
    if (randCouleur==3) { new->couleur = "orange"; }
    return new;
}

void showChat(chatP el)
{
    printf("Je suis un chat. Mon nom est %s et ma couleur est le %s\n",el->nom, el->couleur);
}

chatP * addChat(chatP * tab, int * nbChatP, char * newName)
{
    chatP * new  = malloc((*nbChatP+1) * sizeof(chatP));
    for(int i = 0; i<*nbChatP; i++)
    {
        new[i]=tab[i];
    }

    free(tab);
       
    new[*nbChatP] = newChat(newName);
    (*nbChatP)++;

    return new;
}

chatP * deleteChat(chatP * tab, int * nbChatP, int index)
{
    chatP * new  = malloc((*nbChatP - 1) * sizeof(chatP));
    int j =0;

    for(int i = 0; i<*nbChatP; i++)
    {
        if(i!=index)
        {
            new[j]=tab[i];
            j++;
        }
    }

    (*nbChatP)--;
    free(tab);
    return new;
}


void ex3()
{
//    chatP test = newChat("palico");
//    showChat(test);

    chatP * tableauChat = (chatP *)malloc(sizeof(chatP));
    
    int nbChats = 1;
    tableauChat[0] = newChat("freya");

    char* tempName = (char *)malloc(2*sizeof(char));

    for(int i =0; i<10; i++)
    {
        tempName[0] = (char)(i+97);
        tempName[1] = '\0'; 
        tableauChat = addChat(tableauChat, &nbChats, tempName);
    }

/*    for(int i =0; i<nbChats; i++)
    {
        showChat(tableauChat[i]);
    }
*/
    tableauChat = deleteChat(tableauChat, &nbChats, 6);
    tableauChat = deleteChat(tableauChat, &nbChats, 3);

/*    for(int i =0; i<nbChats; i++)
    {
        showChat(tableauChat[i]);
    }
*/
    return;
}

int main()
{
    srand(time(NULL));              //initialise l'aleatoire à partir de l'heure actuelle
    //ex1();
    //ex2();
    ex3();
    return 0;
}