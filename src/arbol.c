#include <stdio.h>
 
struct arbol{
       int valor;
       struct arbol* izq;
       struct arbol* der;   
};
 
struct arbol* crearArbolBA(int valor);
struct arbol* crearArbolB( int valor,struct arbol* izq, struct arbol* der);
void mostrar_arbol(struct arbol* ar);
struct arbol*  buscarMinimo(struct arbol* abr);
struct arbol*  eliminarTodos(struct arbol* ar,int valor);
 
 
 
int main(int argc, char **argv)
{
   //Creo un arbol con funcion crearArbolBA y lo imprimo
   struct arbol* ab1;
   printf("Primer arbol: \n");
   ab1=crearArbolBA(3);
   mostrar_arbol(ab1);
   printf("---------------------\n");
 
   //Creo otro arbol con funcion crearArbolBA y lo imprimo
   struct arbol* ab2 ;
   printf("Segundo arbol: \n");
   ab2=crearArbolBA(4);
   mostrar_arbol(ab2);
   printf("---------------------\n");
 
   //Creo un arbol con mas nodos
   struct arbol* ar = crearArbolB(12,ab1,ab2);
   struct arbol* ar2 =crearArbolB(5,ar,crearArbolBA(7));
  
 
   printf("Arbol con dos punteros: \n");
   mostrar_arbol(ar2);  
   printf("---------------------\n");
 
   printf("Nodo Minimo: %d \n",buscarMinimo(ar2)->valor) ;
   printf("---------------------\n");
 
   printf("Prueba de elimar nodo: \n") ;
   mostrar_arbol(eliminarTodos(ar2,3));
   mostrar_arbol(eliminarTodos(ar2,4));
}
 
//Funcion para imprimir, usa preorder para recorrer el arbol
void mostrar_arbol(struct arbol* ar){
   if(ar!=0){
       printf("nodo :%d\n",ar->valor);
       if(ar->izq!=0){
           mostrar_arbol(ar->izq);
       }else{
           printf("nodo :%d ",0);
       }
       if(ar->der!=0){
           mostrar_arbol(ar->der);   
       }
       else{
           printf("nodo :%d\n",0);
       }
   }else{
       printf("nodo 0 (vacio)\n");
   }
}
 
int buscarminimo(struct arbol* ar,int min){
   if(ar !=0){
       if(min >= ar->valor){
           min = ar->valor;
           printf("%d %d",min,ar->valor);
       }
      
       if(ar->izq!=0){
           min =buscarminimo(ar->izq,min);
       }
       if(ar->der!=0){
           min =buscarminimo(ar->der,min);   
       }
   }
   return min;
}

