global crearArbolBA
global crearArbolB
global mostrar_abb
global eliminarTodos
global minimo
extern printf
extern malloc
extern free

section .data

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
        
minimo:
    push ebp            ;apilo ebp
    mov ebp, esp        ;muevo a ebp el esp

    mov ebx, [ebp + 8]  ;puntero nodo

    cmp ebx, 0          ;comparo si el nodo es vacio
    je finalizarminimo  ;si es vacio salgo

    mov ecx,[ebx]       ;guardo el valor del puntero
    mov edx,[ebx+4]     ;guardo puntero izquierdo
    mov eax,[edx]       ;guardo el valor del nodo izquierdo
    cmp ecx,eax         ;comparo el valor del nodo con el del nodo izquierdo
    jl buscar_en_der    ;si el valor del nodo es menor se va a la derecha
    jmp buscar_en_izq   ;salta a la izquierda

buscar_en_der:
    mov eax,[ebx+8]         ;tomo el nodo derecho
    mov eax,[eax]           ;guardo el valor del nodo derecho
    cmp ecx,eax             ;compero el valor del nodo con el del derecho
    jl retornar_principal   ;si es menor retorno el principal   
    jmp retornar_der        ;retorno derecho

buscar_en_izq:
    mov eax,[ebx+4]     ;guardo el puntero izquierdo
    mov eax,[eax]       ;guardo el valor del nodo izquierdo
    mov edx,[ebx+8]     ;guardo el puntero derecho
    mov edx,[edx]       ;guardo el valor del nodo derecho
    cmp eax,edx         ;comparo nodo izq con nodo der
    jl retornar_izq     ;si es menor retorno izquierdo
    jmp retornar_der    ;retornar derecho
    
 
min:
    mov ecx,eax         ;guardo en ecx el nodo minimo
    mov eax,ecx         ;paso el minimo a eax
    jmp finalizar       ;finalizo programa


retornar_der:
    mov ecx,[ebp+8]     ;guardo en ecx el nodo minimo
    mov eax,[ecx+8]     ;muevo e eax el nodo minimo
    jmp finalizar       ;finalizo programa
    
retornar_principal:
    mov eax,[ebp+8]     ;guardo en acx el minimo
    jmp finalizar       ;finalizo

retornar_izq:
    mov ecx,[ebp+8]     ;guardo en ecx el minimo
    mov eax,[ecx+4]     ;muevo a eax el minimo
    jmp finalizar       ;finalizo programa

finalizarminimo: 
    mov eax,[ebp+8]
    jmp finalizar       ;retorno eax


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
    jmp borrarIzq
    
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
    push ebx                ;guardo nodo actual
    mov eax, [ebx + 4]      ;paso el nodo izq
    push eax
    call borrarNodo	        ;llamo a borrarNodo
    add esp, 4              ;recupero esp
    pop ebx                 ;recupero nodo actual
    push ebx                ;guardo el nodo actual
    mov eax, [ebx + 8]      ;paso el nodo derecho
    push eax
    call borrarNodo	        ;llamo a borrar nodo
    add esp, 4              ;recupero esp
    pop ebx                 ;recupero nodo actual
    push ebx                ;pusheo el nodo actual
    call free               ;libero el nodo actual
    add esp, 4              ;libero la memoria
    jmp finalizar           ;finalizo programa