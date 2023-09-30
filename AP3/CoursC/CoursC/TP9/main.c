#include <stdio.h>
#include <stdbool.h>  
#include <stdlib.h>
#include <time.h>   

void exo1(){


    int max=10;
    int n=0;
    int nombre=1;  
    
    FILE * fp = fopen ("test.txt","w");

    
    
    while(n<max){//tant que nombre < n alors
         int r=0;//pour compter le nombre de diviseurs
         nombre++;
         for (int i=1 ; i<=nombre ; i++){
             if ((nombre%i)==0){
                r++;
             }
         }
         if(r==2){
            //printf(" %d \n",nombre);
            fprintf(fp,"%d\n",nombre);
            n++;
         }
   }
   
   fclose(fp);
}


void exo2(){
    FILE * fp = fopen ("test2.txt","r");
    char* c = fp;


    printf("%s",c);



    int i = 50;
    while (i<50){
        c =  fgetc(fp);
        printf("%c",c);        
        i++;
    }
    fclose(fp);
}

void exo3(){
    FILE * fp = fopen ("test2.txt","r");
    char tab[50];
    tab[0] = fgetc(fp);
    int i = 0;
    while (tab[i]!= EOF)
    {
        printf("%s",tab[i]);
        i++;
    }
    

}
int main(){
    printf("Hello world\n");
    exo1();
    //exo2();
    exo3();
    return 0;
}
