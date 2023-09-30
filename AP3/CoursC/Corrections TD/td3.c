#include <stdlib.h>
#include <stdio.h>

void ex2(void * variable)
{
    printf("adresse : %p\n", variable);
    return;
}

void ex2bis(void * p1, void * p2, void * p3)
{
    void * pBig;
    printf("p1 : %p\np2 : %p\np3 : %p\n",p1, p2, p3);
    if(p1 < p2 && p1 < p3)
    {
        printf("p1 plus petite\n");
    }
    else
    {
        if(p2 < p3)
        {
            printf("p2 plus petite\n");
        }
        else
        {
            printf("p3 plus petite\n");
        }
    }
    return;
}


void getMeanSum (int* tab, int sizeT, int * moyenneP, int * sommeP)
{
    int sum =0;
    for (int i = 0; i<sizeT; i++)
    {
        sum += tab[i];
    }
    int mean = sum / sizeT;

    *moyenneP = mean;
    *sommeP = sum;
    return;
}




void ex4()
{
    char * lorem = "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat";
    char loremS[60][60];
 
    int i = 0;
    int j = 0;
    int k = 0;
    while(lorem[i]!='\0')
    {
        if(lorem[i]==' ')
        {
            loremS[j][k]='\0';
            j++;
            k=0;
        }
        else
        {
            printf("%d : %c with %d and %d\n", i, lorem[i], j, k);        
            loremS[j][k]=lorem[i];
            k++;
        }
        i++;
    }
    loremS[j][k]='\0';

    for(int i = 0; i<50; i++)
    {
        j=0;
        while(loremS[i][j]!='\0')
        {
            if(loremS[i][j]!='f') { printf("%c", loremS[i][j]); }
            j++;
        }
        printf(" ");
        if (i%2==1) { printf("\n");}

    }

}

int main()
{
    int test = 12;
    void * testP = &test;

    ex2(testP);

    int test2 = 0;
    void * test2P = &test2;

    int test3 = 0;
    void * test3P = &test3;

    ex2bis(testP, test2P, test3P);

    int i[5] = {0,2,4,6,8};
    int moyenne = -10;
    int somme = -10;

    // appel de la fonction ’getMeanSum’
    getMeanSum(i,5, &moyenne, &somme);

    printf("La moyenne est %d et la somme est %d\n", moyenne, somme);

    ex4();

    return 0;
}