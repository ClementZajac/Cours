#include <stdlib.h>
#include <stdio.h>

struct book_{
    char * title;
    char * author;
    int yearP;
    struct book_ *next;
};
typedef struct book_ *book;

book cBook(char * pTitle, char * pAuthor, int pYearP){
    book l = (book)malloc(sizeof(struct book_));
    l->title = pTitle;
    l->author = pAuthor;
    l->yearP = pYearP;
    l->next = NULL;
    return l;
}

void aBook(book pLibrary ,char * pTitle, char * pAuthor, int pYearP){
    if(pLibrary == NULL){
        printf("Error\n");
    }
    while (pLibrary->next != NULL){
        pLibrary = pLibrary->next;
    }
    pLibrary->next = cBook(pTitle,pAuthor,pYearP);
}

void bBook(book l){
    printf("title = %s. author = %s. Annee publi = %d\n", l->title, l->author, l->yearP);
}

void bAllBook(book l){
    int i = 0;
    while (l != NULL){
        printf("N°%d - Tire:%s Auteur: %s AnneeP:%d\n", i+1, l->title, l->author, l->yearP);
        l = l->next;
        i++;
    }
    printf("total : %d livres dans la bibliotheque\n", i);
}

void bBookFromAuthor(book l, char * pAuthor){
    int i = 0;
    int find = 0;
    printf("Affichage des livre(s) dont l'author est : %s\n",pAuthor);
    while (l != NULL){
        if(l->author == pAuthor){
            bBook(l);
            find++;
        }
        l = l->next;
        i++;
    }
    if(find==0){
        printf("Aucun livre trouvé avec l'author: %s\n", pAuthor);
    }
}

void bBookFromTitle(book l, char * pTitle){
    int i = 0;
    int find = 0;
    printf("Affichage des livre(s) dont le title est : %s\n",pTitle);
    while (l != NULL){
        if(l->title == pTitle){
            bBook(l);
            find ++;
        }
        l = l->next;
        i++;
    }
    if(find==0){
        printf("Aucun livre ne comporte le tire %s\n", pTitle);
    }

}

book dBook(book l, int spot){
    book start = l;
    if (spot == 0){
        book result = l->next;
        free(l);
        return result;
    }
    for (int i = 0; i < spot - 1; i++){ // le -1 est là pour que l'appel soit plus intuitif
    
        if (l->next == NULL){
            printf("error, list too small\n");
            return start;
        }
        l = l->next;
    }
    book newNext = l->next->next;
    free(l->next);
    l->next = newNext;
    return start;
}

//=====================================//
void main(){
    printf("Hello world\n");
    
    book bibliotheque = cBook("title","Aut",220321);

    aBook(bibliotheque,"pTitle","pAuthor",220321);
    aBook(bibliotheque,"pTitle","pAuthor",220321);
    aBook(bibliotheque,"pTitle","pAuthor",220321);
    aBook(bibliotheque,"pTitle","pAuthor",220321);

    //bBookFromTitle(bibliotheque,"pTitle");
    bBookFromAuthor(bibliotheque, "Aut");

    /*
    bAllBook(bibliotheque);
    dBook(bibliotheque,1);
    bAllBook(bibliotheque);

    
    bAllBook(bibliotheque);
    bibliotheque = dBook(bibliotheque,0);
    bAllBook(bibliotheque);
    
    */
    //dBook(1);

    /*
    for (int i = 0; i < 5; i++){
        addS(lisS, i + 30);
    }
    */
}



/*
void fusionS(book l1, book l2){
    while (l1->next != NULL){
        l1 = l1->next;
    }
    l1->next = l2;
    return;
}
*/

/*
book addSSpot(book l, int val, int spot){
    book start = l;
    if (spot == 0){
        book newStart = createNewS(val);
        newStart->next = start;
        return newStart;
    }

    for (int i = 0; i < spot - 1; i++){ // le -1 est là pour que l'appel soit plus intuitif
    
        if (l == NULL){
            printf("error, list too small\n");
            return start;
        }
        l = l->next;
    }

    if (l->next != NULL){
        book l2 = l->next;
        l->next = createNewS(val);
        l->next->next = l2;
    }else{
        l->next = createNewS(val);
    }
    return start;
}
*/




