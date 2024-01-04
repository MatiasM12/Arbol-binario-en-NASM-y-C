# Implementación de Arbol Binario en Ensamblador y C

Este repositorio contiene la implementación de funciones en ensamblador (ASM) que son llamadas desde un programa en C. Estas funciones están diseñadas para manipular árboles binarios, utilizando la función `malloc` para la gestión dinámica de la memoria.

## Contenido del Repositorio

### 1. Creación de Árboles Binarios

#### a) Función `crearArbolBA`

- **Descripción:** Crea un árbol binario asignando un valor al nodo raíz.
- **Implementación en ASM:** (Inserta aquí el código ASM para esta función)

#### b) Función `crearArbolB`

- **Descripción:** Crea un árbol binario enlazando nodos izquierdo y derecho al nodo raíz.
- **Implementación en ASM:** (Inserta aquí el código ASM para esta función)

### 2. Integración con C

- Se presenta un programa en C que utiliza las funciones creadas en ASM.
- **Funciones en C:**
  - `mostrar_arbol()`: Muestra por pantalla los nodos del árbol, visualizando los nodos vacíos con 0.
  - `main()`: Ejecuta todas las funciones y muestra los resultados.
- **Código en C:** (Inserta aquí el código C)

### 3. Función `minimo`

- **Descripción:** Encuentra el nodo con el valor mínimo en un árbol.
- **Implementación en ASM:** (Inserta aquí el código ASM para esta función)

### 4. Función `eliminarTodos`

- **Descripción:** Elimina todos los nodos de un árbol con un valor específico.
- **Implementación en ASM:** (Inserta aquí el código ASM para esta función)

## Ejecución del Programa

- Para compilar y ejecutar el programa en C, utiliza las siguientes líneas de código:
```
  nasm -f elf -o arbol.o arbol.asm
  gcc -m32 -o invocar arbol.c arbol.o
  ./invocar
```
## Resultados y Gráficos

- Se incluyen gráficos que representan los árboles creados y ejemplos de la ejecución del programa.

¡Gracias por explorar nuestra implementación de arboles binarios en ASM y su integración con C! 🌳✨
