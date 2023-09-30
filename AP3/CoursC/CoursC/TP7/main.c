#include <stdlib.h>
#include <stdio.h>

int div10(int a){
  return a/10;
}

int mult10(int a){
    return a*10;
}

int presenceMaj(char * string){
    int i = 0;
    while(string[i] != '\0') {
        int temp = string[i];
        
        if(temp>=60 && temp <= 90){
            /*
            printf("%c.",string[i]);
            printf("%d.",temp);
            printf("Fin");
            */
            return 1;

        }
        i++;
    }
    return 0;
}

int is100e(char * string){
    int i = 0;
    int count = 0;
    while(string[i] != '\0') {
        if(string[i] == 'e'){
            //printf("Fin");
            count++;
        }
        i++;
    }
    if(count>100){
        return 1;
    }else{
        return 0;
    }
}

int isNAfterA(char * string){
    int i = 0;
    while(string[i] != '\0') {
        if(string[i] == 'a' && string[i+1] == 'n'){
            return 1;
        }
        i++;
    }
    return 0;
}

int isChiffre(char * string){
        int i = 0;
    while(string[i] != '\0') {
        int temp = string[i];
        if(temp>=48 && temp <= 57){
            return 1;
        }
        i++;
    }
    return 0;
}

int main (void){
    printf("\n");

    int nbr = 11;
    int (*pt)(int) = &div10;
    if(nbr%10 == 0){
        pt= &div10;
    }else{
        pt = &mult10;
    }
    //printf ("%d\n",(*pt)(nbr)); // affiche 9

    char * string = "Mon test an0 test";
    /*
    int (*pt1)(int) = &presenceMaj;
    int (*pt2)(int) = &is100e;
    int (*pt3)(int) = &isaAfter;
    int (*pt4)(int) = &isChiffre;
    */
    int (*p[4]) (char* chaine) = {presenceMaj,is100e,isNAfterA,isChiffre};
    
    for(int i=0; i<4;i++){
        printf ("Return: %d\n",(*p[i])(string));
    }

    printf("\n");   
    return 0;
}