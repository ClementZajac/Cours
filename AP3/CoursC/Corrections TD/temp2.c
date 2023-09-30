#include <stdio.h>

int ex1(int tableau[4], int cases)
{
    int temp = tableau[0];
    for(int i = 0; i < cases; i++)
    {
        if (temp>tableau[i])
        {
            return 0;
        }
        else
        {
            temp = tableau[i];
        }
    }
    return 1;
}

void ex2(int key)
{
    char buffer[100];
    int temp = 0;
    scanf("%s", buffer);
    printf("texte : %s\n",buffer);
    for(int i = 0; i < 100; i++)
    {
        temp = (int)buffer[i];
        if(temp==0)
        {
            break;
        }
        buffer[i] = (char) ((temp-97+key)%27+97);
    }
    printf("exo 2 : %s\n",buffer);
    return;
}

void ex3(int a[3], int b[7], int result[10])
{
    int sizeA= 3;
    int sizeB= 7;
    int tmpA = 0;
    int tmpB = 0;
    int finA = 0;
    int finB = 0;
    for(int i = 0; i < sizeA+sizeB; i++)
    {
        if(finA == 1) 
        {
            result[i] = b[tmpB];
            tmpB++;
        }
        else if(finB == 1) 
        {
            result[i] = a[tmpA];
            tmpA++;
        }
        else if(a[tmpA]<b[tmpB])
        {
            result[i] = a[tmpA];
            tmpA++;
            if (tmpA == sizeA){finA=1;}
        }
        else
        {
            result[i] = b[tmpB];
            tmpB++;
            if (tmpB == sizeB){finB=1;}
        }
    }
    return;
}

int main()
{
    int test1[4] = {0,5,2, 10};
    printf("exo 1 : %d\n",ex1(test1,4));

//    ex2(4);
    
    int ex3a[3] = {1,3,5}; 
    int ex3b[7] = {2, 4, 6, 8, 10, 12, 14};
    int ex3result[10] = {0};
//    ex3(ex3a, ex3b, ex3result);

//    for(int i =0; i<10; i++) { printf("%d ", ex3result[i]); }
    return 0;
}