#include <stdlib.h>
#include <stdio.h>

struct customer_{
    char * name;
    char * rank;
    int age;
};
typedef struct customer_ *customer;

struct emprunt_{
    livre livre;
    customer customer;
    int date;
    int is;
};
typedef struct emprunt_ *emprunt;

struct listeEmprunts_{
    emprunt emprunt;
    customer customer;
    int date;
};
typedef struct emprunt_ *emprunt;

