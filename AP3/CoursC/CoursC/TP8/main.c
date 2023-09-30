#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <stddef.h>
#include <string.h>

void affEntier(int a){
    printf("Mon entier = %d\n",a);
}

void affDouble(double a){
    printf("Mon double = %f\n",a);
}

int divi(double a, double b){
    void (*pt)();
    double var = a/b;
    printf("ma val = %f \n",var);
    if(var = (int)var){
        pt = affEntier;
    }else{
        pt = affDouble;
    }
    pt(var);
    return 0;
}

void tabSymboles(int nbr, ...){
    int cpt = 0;
    va_list ap;
    va_start (ap, nbr );

    for (int i = 0; i < nbr; i++)
    {
        chaine = va_arg (ap, char *);
    }
    

int main(){
    printf("Hello world\n");
    /*
    divi(10,2);
    printf("--------\n");
    divi(10,3);
    */

    //sumNumbers(5,2,3,4,5,6);

    int a = tabSymboles(3,"o","!",".");
    return 0;
}


void sumNumbers(int argNum, ...) {
    va_list ap;
    va_start (ap, argNum);
    int somme = 0;
    while (argNum > 0) {
        int n = va_arg(ap, int);
        somme += n;
        printf("Argument index : %d, Argument value %d, Sum : %d\n", argNum, n, somme);
        argNum--;
    }
    va_end(ap);
    printf("Somme totale = %d\n", somme);
}



/*
#include <stdio.h>
void entier(int res){//mÃªme type de retour pour les 2 fonctions
    printf("%d",res);
}
void virgule (double res){//envoie un double car ptr generique ne gere pas float
    printf("%f",res);
}
void main(){
    int a=5;
    int b=2;
    void (*ptr)();//pointeur generique
    float c=(float)a/b;
    if (c!=(int)c)
    {
        (ptr)=&virgule;
    }
    else
    {
        (ptr)=&entier;
    }
    (ptr)(c);
    
}
*/


/*
void sumNumbers(int argNum, ...) {
    va_list ap;
    va_start (ap, argNum);
    int somme = 0;
    while (argNum > 0) {
        int n = va_arg(ap, int);
        somme += n;
        printf("Argument index : %d, Argument value %d, Sum : %d\n", argNum, n, somme);
        argNum--;
    }
    va_end(ap);
    printf("Somme totale = %d\n", somme);
}
*/



