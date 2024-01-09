global crearArbolBA
global crearArbolB
global mostrar_abb
 
 
global eliminarTodos
global buscarMinimo
extern printf
extern malloc
extern free
 
section .data
var db "hola %d",10,13
minimo db 0
 
section .text
 
;Punto 1 ----------------------------------------------
 
crearArbolBA:
   push ebp            ;apilo ebp
   mov ebp, esp        ;muevo el esp al ebp
  
   mov ecx, [ebp + 8]  ;valor parametro
 
   push ecx            ;pusheo el valor para no perderlo
   push 12             ;pusheo 12 bytes para malloc  
   call malloc         ;recervo la memoria con malloc
   add esp, 4          ;restauro pila      
   pop ecx             ;pop de valor
  
   mov [eax], ecx      ;guardo valor
   mov edx,0          
   mov [eax + 4], edx  ;seteo nodo a puntero izq en 0
   mov [eax + 8], edx  ;seteo nodo a puntero der en 0
 
   jmp finalizar       ;termino programa
 
agregoNodo:
   push ecx            ;pusheo ecx de respaldo
   push edx            ;pusheo edx de respaldo
   push 12             ;pusheo 12 bytes para malloc
   call malloc         ;recervo memoria con malloc
   add esp, 4          ;vuelvo la pila a su lugar
   pop edx             ;desapilo edx
   pop ecx             ;desapilo ecx
  
   mov [eax], ecx      ;guardo valor
   mov [eax + 4], ebx  ;seteo nodo a puntero izq
   mov [eax + 8], edx  ;seteo nodo a puntero der
 
   jmp finalizar       ;termino programa
 
      
crearArbolB:
   push ebp            ;apilo ebp
   mov ebp, esp        ;muevo a ebp el esp
  
   mov ecx, [ebp + 8]  ;valor parametro
   mov ebx, [ebp + 12] ;valor puntero izq
   mov edx, [ebp + 16] ;valor puntero der
  
   call agregoNodo     ;llamo a agregar nodo
   jmp finalizar       ;fin del programa
 
finalizar:
   mov esp, ebp
   pop ebp             ;restaura a ebp
   ret                 ;retorno eax
 
;Punto 3 ----------------------------------------------
 
buscarMinimo:               ;guarda el primer valor como minimo
   push ebp
   mov ebp, esp
  
   mov ebx, [ebp + 8]      ;accedo al valor del primer nodo
   mov ebx,[ebx]      
   mov [minimo],ebx        ;guardo el valor del nodo en res
 
   mov esp, ebp
   pop ebp 
 
   jmp buscarMinimoAux
 
buscarMinimoAux:                  ;recorre para buscar el minimo
   push ebp
   mov ebp, esp
 
   mov ebx, [ebp + 8]      ;puntero nodo
   mov ecx,[minimo]        ;pongo el minimo en ecx para comparar
 
   cmp ebx, 0              ;si es cero finalizo
   je finalizar
 
   call compararMinimo       ;verifico si es minimo y lo guarda
 
   push ebx                ;apilo nodo actual para pasar por parametro
   mov eax, [ebx + 4]      ;paso el nodo izq
   push eax                ;apilo el nodo izq para pasar por parametro
   call buscarMinimoAux    ;llamo a buscarMin para la recursividad
   add esp, 4              ;recupero esp
   pop ebx                 ;recupero nodo actual
   push ebx                ;apilo nodo actual para pasar por parametro
   mov eax, [ebx + 8]      ;paso el nodo derecho
   push eax                ;apilo el nodo der para pasar por parametro
   call buscarMinimoAux 	       ;llamo a buscarMin para la recursividad
  
   add esp, 4              ;recupero esp
             
   mov eax,minimo          ;guardo el minimo para retornarlo
   jmp finalizar           ;finalizo programa
 
 
 
compararMinimo:
   cmp ecx,[ebx]           ;compara si el valor del nodo es menor al minimo
   jg guardarMinimo                  ;salta a min para guardar el valor
   ret
 
guardarMinimo:
   mov ecx,[ebx]           ;muevo el valor del nodo a ecx
   mov [minimo],ecx        ;guardo en minimo el nodo
   ret
 
;Punto 4 ----------------------------------------------
 eliminarTodos:
   push ebp
   mov ebp, esp
 
   mov edx, [ebp + 12]     ;valor parametro
   mov ebx, [ebp + 8]      ;puntero nodo
   cmp ebx, 0              ;si es cero no hay nodo
   je finalizar            ;finalizo programa
   cmp edx, [ebx]          ;comparo el parametro con valor nodo
   je nodoEncontrado     
   jmp borrarIzq           ;finalizo programa
  
  
nodoEncontrado:
   push ebx                ;guardo el valor
   call borrarNodo         ;salto a borrar nodo
   add esp, 4              ;recupero esp
   jmp finalizar           ;finalizo programa
  
  
borrarIzq:
   push edx                ;apilo el parametro
   mov eax, [ebx + 4]      ;guardo nodo izquierdo
   push eax                ;pusheo nodo izquierdo
   call eliminarTodos      ;llamo a borrar todos
   mov ebx, [ebp + 8]      ;puntero nodo actual
   mov [ebx + 4], eax      ;agrego nodo nuevo
   mov eax,ebx             ;muevo para no pidar datos
   add esp, 8              ;recupero esp
   jmp borrarDer           ;salto a borrar derecha
  
borrarDer:
   push edx                ;apilo el parametro
   mov eax, [ebx + 8]      ;guardo nodo derecho
   push eax                ;pusheo nodo derecho
   call eliminarTodos      ;salto a eliminar todos
   mov ebx, [ebp + 8]      ;puntero nodo actual
   mov [ebx + 8], eax      ;agrego nodo nuevo
   mov eax,ebx             ;muevo para no pisar datos
   add esp, 8              ;recupero esp
   jmp finalizar           ;finalizo programa
    
borrarNodo:
   push ebp
   mov ebp, esp
 
   mov ebx, [ebp + 8]      ;puntero nodo
   cmp ebx, 0              ;si es cero finalizo
   je finalizar
 
   call liberarNodo
  
   push ebx                ;guardo nodo actual
   mov eax, [ebx + 4]      ;paso el nodo izq
   push eax
   call borrarNodo         ;llamo a borrarNodo\
  
   add esp, 4              ;recupero esp
   pop ebx                 ;recupero nodo actual
   push ebx                ;guardo el nodo actual
   mov eax, [ebx + 8]      ;paso el nodo derecho
   push eax
   call borrarNodo         ;llamo a borrar nodo
 
   add esp, 4              ;recupero esp
   
   jmp finalizar           ;finalizo programa
  
liberarNodo:
   push ebx                ;pusheo el nodo actual
   call free               ;libero el nodo actual
   add esp, 4
   ret
 
 

