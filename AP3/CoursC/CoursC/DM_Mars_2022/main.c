#include <stdio.h>
#include <stdbool.h>  
#include <stdlib.h>
#include <time.h>

int lecture = 0;
int ecriture = 0;

int NBR_CASES_TABLEAU = 10;
int MAX_RANDOM_VALUE = 100;

float temps;
clock_t t1, t2;
typedef struct tree_{
    double val;
    struct tree_ *gauche;
    struct tree_ *droite;
};
typedef struct tree_ *tree;
struct liste_{
    double val;
    struct liste_ *next;
};
typedef struct liste_ *liste;

 
void debCalculTempsExe(){
    t1 = clock();
}

void finCalculTempsExe(){
    t2 = clock();
    temps = (float)(t2-t1)/CLOCKS_PER_SEC;
    printf("    Temps d'execution: %f\n", temps);
}
int genererRandom(){
    return rand() %(MAX_RANDOM_VALUE +1);
}

double remplirSansDoublons(double* tab, int max){
    int random = genererRandom();
    double randomDouble = (double)random;
    bool isPresent = false;
    //On parcours le tableau pour chercher les doublons
    for (int j = 0; j < max; j++){
        lecture++;
        if (tab[j] == randomDouble) {
            isPresent = true;
            break;
        }
    }
    if (isPresent) {
        //si il y a un doublon alors on re fait un random
        return remplirSansDoublons(tab, max);
    }else{
        return randomDouble;
    }
}

void afficherLecture(){
    printf("    Nbr lecture : %d \n", lecture);
    lecture = 0;
}

void afficherEcriture(){
    printf("    Nbr ecriture : %d \n", ecriture);
    ecriture = 0;
}

void afficherLectureEcriture(){ 
    afficherLecture();
    afficherEcriture();
}

void partie1Exo1(double tab[]){
    for (int i = 0; i < NBR_CASES_TABLEAU; ++i) {
        tab[i] = remplirSansDoublons(tab, i);
        ecriture++;
    }
    afficherLectureEcriture();
}

void partie1Exo2(double tab[], double tabTrie[]){

    int precedenteSelection = 0;
    for (int i = 0; i < NBR_CASES_TABLEAU; ++i) {
        int plusPetiteValeur = MAX_RANDOM_VALUE;
        for (int j = 0; j < NBR_CASES_TABLEAU; ++j) {
            double currentValue = tab[j];
            lecture++;
            if (currentValue < plusPetiteValeur && currentValue > precedenteSelection) {
                plusPetiteValeur = currentValue;
            }
        }
        ecriture++;
        tabTrie[i] = plusPetiteValeur;
        precedenteSelection = plusPetiteValeur;
    }
    afficherLectureEcriture();
}

void partie1Exo3(double tab[], double tabTrie[]){
    double random = genererRandom();
    printf("Valeur cherchée : %f \n", random);
    printf("\n");

    bool flag = false;
    printf("   Tableau NON trié: \n");
    for (int i = 0; i < NBR_CASES_TABLEAU; ++i) {
        lecture++;
        if (random == tab[i]){
            flag = true;
            break;
        }
        
    }
    if (!flag){
        printf("Element non présent dans le tableau \n");
    }else{
        printf("Element présent dans le tableau !\n");
    }
    
    afficherLecture();

    printf("\n");

    flag = false;
    printf("Tableau trié: \n");
    for (int i = 0; i < NBR_CASES_TABLEAU; ++i) {
        lecture++;
        if (random == tabTrie[i]){
            flag = true;
            break;
        }
    }
    if (!flag){
        printf("Element non présent dans le tableau \n");
    }else{
        printf("Element présent dans le tableau !\n");
    }
    afficherLecture();
}

liste creerElement(double val){
    liste l = (liste)malloc(sizeof(struct liste_));
    ecriture++;//Ecriture: Création du maillon

    l->val = val;
    ecriture++;//Ecriture: Modification d'une donnée
    //l->next = NULL;
    return l;
}

void ajouterElement(liste l, double val){
    while (l->next != NULL){
        lecture++;//Lecture du maillon pour savoir si il est NULL
        l = l->next;
    }
    l->next = creerElement(val);
}

void afficherListe(liste l){
    int i = 0;
    while (l != NULL){
        printf("Val: %f\n", l->val);
        l = l->next;
        i++;
    }
    printf("Total: %d elements\n", i);
}

liste ajouterElementAUnEmplacement(liste l, double val, int spot){
    liste start = l;
    if (spot == 0){
        liste newStart = creerElement(val);
        newStart->next = start;
        return newStart;
    }
    for (int i = 0; i < spot - 1; i++){
        if (l == NULL){
            printf("Erreur, liste trop petite\n");
            return start;
        }
        l = l->next;
    }

    if (l->next != NULL){
        liste l2 = l->next;
        l->next = creerElement(val);
        l->next->next = l2;
    }else{
        l->next = creerElement(val);
    }
    return start;
}

double nbrAleatoireSansDoubonPourListeChainee(liste l){

    
    liste lTemp = l;
    double random = genererRandom();
    bool isPresent = false;

    while (lTemp != NULL){
        lecture++;//Lecture du maillon pour savoir si il est NULL
        lecture++;//Lecture de la variable "val" du maillon pour le if
        if (lTemp->val == random) {
            isPresent = true;
            break;
        }
        
        lTemp = lTemp->next;
    }
    if (isPresent) {
        return nbrAleatoireSansDoubonPourListeChainee(l);
    }else{
        return random;
    }
}

liste partie2Exo1(){
    liste l = creerElement(500000);
    ecriture++;//Ecriture du premier élément

    for (int i = 0; i < NBR_CASES_TABLEAU-1; ++i) {
        
        ajouterElement(l,nbrAleatoireSansDoubonPourListeChainee(l));
    }

    printf("fin");
    afficherLectureEcriture();
    return l;
}

liste trieElement(double value,liste listeTrie){
    liste listeTemp = listeTrie;
    int i = 0;
    while (listeTrie != NULL){
        lecture++;//Lecture du maillon pour savoir si il est NULL

        lecture++;//Lecture de la variable "val" du maillon, de la liste "l" pour le if
        lecture++;//Lecture de la variable "val" du maillon, de la liste "listeTemp"  pour le if

        if (listeTemp->val > value) {
            listeTrie = ajouterElementAUnEmplacement(listeTrie,value,i);
            ecriture++;//Mise à jour de la variable "listeTrie", qui contient maintenant le nouvel élément
            return listeTrie;

        }else if(listeTemp->next == NULL){
            listeTrie = ajouterElementAUnEmplacement(listeTrie,value,i+1);
            ecriture++;//Mise à jour de la variable "listeTrie", qui contient maintenant le nouvel élément
            return listeTrie;
        }
        i++;
        listeTemp = listeTemp->next;
    }
}

liste partie2Exo2(liste l){
    liste listeTrie = creerElement(l->val);
    ecriture++;//Ecriture du premier élément

    l=l->next;//On se positione au second élément de la liste non trié car le premier (500 000) 
              //sert pour initialiser la liste avec un premier élément
    while (l != NULL){
        lecture++;//Lecture du maillon pour savoir si il est NULL

        listeTrie = trieElement(l->val,listeTrie);
        l = l->next;
    }
    //afficherListe(l);
    afficherLectureEcriture();
    return listeTrie;
}

liste partie2Exo3(liste l, liste listeTrie){
    double random = genererRandom();
    printf("Valeur cherchée : %f \n", random);
    printf("\n");

    bool flag = false;
    printf("Liste NON trié: \n");
    while (l != NULL){
        lecture++;//Lecture du maillon pour savoir si il est NULL

        if (random == l->val){
            flag = true;
            break;
        }
        l = l->next;
    }
    if (!flag){
        printf("Element non présent dans le tableau \n");
    }else{
        printf("Element présent dans le tableau !\n");
    }
    afficherLecture();

    printf("\n");

    flag = false;
    printf("Liste trié: \n");
    while (listeTrie != NULL){
        lecture++;//Lecture du maillon pour savoir si il est NULL

        if (random == listeTrie->val){
            flag = true;
            break;
        }
        listeTrie = listeTrie->next;
    }   
    if (!flag){
        printf("Element non présent dans le tableau \n");
    }else{
        printf("Element présent dans le tableau !\n");
    }
    //printf("\n");
    afficherLecture();
}

void freeListe(liste l){
    liste nextEle;
    while (l != NULL) {
        nextEle = l->next;
        free(l);
        l = nextEle;
    }
}


tree creerElementTree(double val){
    tree t = (tree)malloc(sizeof(struct tree_));
    ecriture++;//Ecriture: Création du maillon

    t->val = val;
    ecriture++;//Ecriture: Modification d'une donnée
    t->gauche = NULL;
    ecriture++;//Ecriture: Modification d'une donnée
    t->droite = NULL;
    ecriture++;//Ecriture: Modification d'une donnée
    return t;
}

tree analyserTree(tree t,double n){
    tree tTemp = t;
    if (tTemp->val == n){
        //Doublon
        analyserTree(t,genererRandom());
    }

    if (tTemp->val > n){
        if (tTemp->gauche == NULL){
            //Pas de noeud à gauche
            tTemp->gauche = creerElementTree(n);
        }else{
            //Noeud présent à gauche
            tTemp = tTemp->gauche;
            analyserTree(tTemp,n);
        }
    }

    if (tTemp->val < n){
        if (tTemp->droite == NULL){
            //Pas de noeud à droite
            tTemp->droite = creerElementTree(n);
        }else{
            //Noeud présent à droite
            tTemp = tTemp->droite;
            analyserTree(tTemp,n);
        }
    }
}

tree partie3Exo1(){

    //Créaton du premier maillon
    double n = genererRandom();
    tree monArbre = (tree)malloc(sizeof(struct tree_));
    ecriture++;//Ecriture: Création du maillon
    monArbre->val = n;
    ecriture++;//Ecriture: Modification d'une donnée
    monArbre->gauche = NULL;
    ecriture++;//Ecriture: Modification d'une donnée
    monArbre->droite = NULL;
    ecriture++;//Ecriture: Modification d'une donnée
    
    for (int i = 0; i < NBR_CASES_TABLEAU; i++){
        n = genererRandom();
        //printf("Suivant - Random: %f \n",n);
        analyserTree(monArbre,n);    
    }

    return monArbre;
}

int main(){

    srand( time( NULL ) );  

    /*
    //Résultat de 10 exécutions :
    Nbr lecture : 888118864 / Nbr ecriture : 100000 
    Nbr lecture : 882823609 / Nbr ecriture : 100000 
    Nbr lecture : 878234576 / Nbr ecriture : 100000 
    Nbr lecture : 888839307 / Nbr ecriture : 100000 
    Nbr lecture : 886655872 / Nbr ecriture : 100000 
    Nbr lecture : 889437830 / Nbr ecriture : 100000 
    Nbr lecture : 887988803 / Nbr ecriture : 100000 
    Nbr lecture : 889409115 / Nbr ecriture : 100000 
    Nbr lecture : 884628038 / Nbr ecriture : 100000 
    Nbr lecture : 885249379 / Nbr ecriture : 100000

    Le nombre d'écriture est fixe : 100 000, car on ecrit dans le tableau que lorsque la valeur est valide (pas de doubons)

    Le nombre de lecture quand à lui varie, car quand on tombe sur un doubon, il faut regénérer un nombre à aléatoire et vérifier qu'il n'est pas lui meme en double.
    Moyenne du nombre de lecture : 885 249 379 
    */

    int taille = 0;
    double *tab = calloc(NBR_CASES_TABLEAU, sizeof(double));
   
    double *tabTrie = calloc(NBR_CASES_TABLEAU, sizeof(double));
    printf("\n===========================================================\n");

    printf("\n= PARTIE 1 - Exo 1 ========================================\n");
    debCalculTempsExe();
    partie1Exo1(tab);
    finCalculTempsExe();
    taille = sizeof(tab)*NBR_CASES_TABLEAU;
    printf("    Taille en mémoire : %d \n",taille);
    taille = 0;

    printf("\n= PARTIE 1 - Exo 2 ========================================\n");
    debCalculTempsExe();
    partie1Exo2(tab, tabTrie);
    finCalculTempsExe();

    printf("\n= PARTIE 1 - Exo 3 ========================================\n");
    debCalculTempsExe();
    partie1Exo3(tab, tabTrie);
    finCalculTempsExe();
    free(tab);free(tabTrie);

    printf("\n===========================================================\n");

    printf("\n= PARTIE 2 - Exo 1 ========================================\n");
    debCalculTempsExe();
    liste maListe = partie2Exo1();
    finCalculTempsExe();
    //Taille de chaque element de la liste chainée, fois, le nombre de maillons
    taille = (sizeof(maListe->next) + sizeof(maListe->val))*NBR_CASES_TABLEAU;
    printf("    Taille en mémoire : %d ",taille);
    taille = 0;

    printf("\n= PARTIE 2 - Exo 2 ========================================\n\n");
    debCalculTempsExe();
    liste maListeTrie = partie2Exo2(maListe);
    finCalculTempsExe();

    printf("\n= PARTIE 2 - Exo 3 ========================================\n\n");
    debCalculTempsExe();
    partie2Exo3(maListe,maListeTrie);
    finCalculTempsExe();
    freeListe(maListe);freeListe(maListeTrie);

    printf("\n===========================================================\n");
    printf("\n= PARTIE 3 - Exo 1 ========================================\n");
    tree t = partie3Exo1();

    return 0;
}
