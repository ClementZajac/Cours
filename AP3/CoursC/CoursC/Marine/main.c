#include<stdio.h>
#include<stdlib.h>
#include <math.h>
#include <time.h>

int partie1_tableau()
{
    int lectures=0;
    int ecritures=0;
    int nombre_cases_tableau=10;

    int compte=0;
    int presence_doublon=0;

    int* tableau = calloc(nombre_cases_tableau,sizeof(int)); //Creer un tableau de la taille voulu

    while (compte!=nombre_cases_tableau)
    {
        int number = (rand()% 15); //Generer un nombre aleatoire
        presence_doublon=0;

        /* Verifier qu'il n'y ai pas de doublon */
        for (int j=0; j<compte; j++)
        {
            if (tableau[j]==number)
            {
                presence_doublon=1;
            }
            lectures++;
        }

        /* Dans le cas où il n'y a pas de doublon */
        if (presence_doublon==0)
        {
            tableau[compte]=number;
            compte++;
            ecritures++;
        }
    }

    /* tri selection */ 
    int lectures_tri=0;
    int ecritures_tri=0;
    int* tableau_tri_selection = calloc(nombre_cases_tableau,sizeof(int));
    int precedente_selection = 0;
    int valeur_choisie = 1000000;
    for (int i=0; i<nombre_cases_tableau; i++)
    {
        for (int n=0; n<nombre_cases_tableau; n++)
        {
            if ((tableau[n]<valeur_choisie) && (tableau[n]>precedente_selection))
            {
                valeur_choisie = tableau[n];
            }
            lectures_tri++;
        }
        tableau_tri_selection[i] = valeur_choisie;
        ecritures_tri++;
        precedente_selection = valeur_choisie;
        valeur_choisie = 1000000;
    }

    printf("Recherche\n \n");
    /*chercher la presence d'un nombre aleatoire*/
    int lectures_cherche_nombre_non_trie = 0;
    int lectures_cherche_nombre_trie = 0;
    int presence_nombre_alea = 0;
    int nombre_a_chercher = (rand() % 12);
    printf("Je cherche %d\n", nombre_a_chercher);
    for (int a = 0; a < nombre_cases_tableau; a++)
    {
        printf("%d - ", tableau[a]);
        lectures_cherche_nombre_non_trie++;
        if (nombre_a_chercher==tableau[a])
        {
            printf("JE SUIS  \n");
            presence_nombre_alea=1;
            break;
        }
    }
    presence_nombre_alea = 0;
    for (int b = 0; b < nombre_cases_tableau; b++)
    {
        lectures_cherche_nombre_trie++;
        if (nombre_a_chercher==tableau_tri_selection[b])
        {
            printf("JE SUIS LA 2 \n");
            presence_nombre_alea=1;
            break;
        }
    }
    if (presence_nombre_alea==1)
    {
        printf("Nombre aleatoire present dans le tableau\n");
    }
    


    /*AFFICHER*/
    /*for (int g=0; g<nombre_cases_tableau; g++)
    {
        printf("avant tri\n");
        printf("%d\n",tableau[g]);
    }

    printf("\n");

    for (int f=0; f<nombre_cases_tableau; f++)
    {
        printf("apres tri\n");
        printf("%d\n",tableau_tri_selection[f]);
    }*/

    printf("nombre de lectures: %d\nnombre d'ecritures: %d\n", lectures,ecritures);
    /* J'ai realise 5 executions du code et j'ai touve une moyenne de: 1 068 121 455,2 */
    printf("nombre de lectures pour le tri: %d\nnombre d'ecritures pour le tri: %d\n", lectures_tri,ecritures_tri);
    printf("nombre de lectures pour chercher un nombre dans un tableau non trie: %d\nnombre de lectures pour chercher un nombre dans un tableau trie: %d\n", lectures_cherche_nombre_non_trie,lectures_cherche_nombre_trie);
}

int main(){
    srand( time( NULL ) );
    partie1_tableau();
    return 0;
}
