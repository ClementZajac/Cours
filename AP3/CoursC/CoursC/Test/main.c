#include <stdio.h>
#include <stdlib.h>

#include "rbtree.h"

int main()
{
    unsigned int Key;
    node *Arbre = NULL;

    addNode(&Arbre, 30);
    addNode(&Arbre, 20);
    addNode(&Arbre, 50);
    addNode(&Arbre, 45);
    addNode(&Arbre, 25);
    addNode(&Arbre, 80);
    addNode(&Arbre, 40);
    addNode(&Arbre, 70);
    addNode(&Arbre, 25);
    addNode(&Arbre, 10);
    addNode(&Arbre, 60);

    puts("-------------------------------");

    printTree(Arbre);

    puts("-------------------------------");

    printReverseTree(Arbre);

    puts("-------------------------------");

    Key = 30;
    if(searchNode(Arbre, Key)) printf("La cle %d existe.\n", Key);
    else printf("La cle %d n'existe pas.\n", Key);

    Key = 32;
    if(searchNode(Arbre, Key)) printf("La cle %d existe.\n", Key);
    else printf("La cle %d n'existe pas.\n", Key);

    puts("-------------------------------");

    clearTree(&Arbre);

    return 0;
}
