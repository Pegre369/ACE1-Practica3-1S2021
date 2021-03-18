include macros.asm ;Importar el archivo "macros.asm"
.model small
.stack 64h
.data
    ;Mensaje de encabezado
    encabezado  db 13,10,"UNIVERSIDAD DE SAN CARLOS DE GUATEMALA"
                db 13,10,"FACULTAD DE INGENIERIA"
                db 13,10,"ESCUELA DE CIENCIAS Y SISTEMAS"
                db 13,10,"ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1"
                db 13,10,"SECCION A"
                db 13,10,"PRIMER SEMESTRE 2021"
                db 13,10,"Sergio Sebastian Chacon Herrera"
                db 13,10,"201709159","$"
    ;Mensaje para el menu principal
    menu    db 13,10,"------MENU PRINCIPAL------"
            db 13,10,"Opciones:"
            db 13,10,"1. Cargar Archivo"
            db 13,10,"2. Modo Calculadora"
            db 13,10,"3. Factorial"
            db 13,10,"4. Crear Reporte"
            db 13,10,"5. Salir"
            db 13,10,"Elegir: ",'$'
    ;Mensaje para el menu modo calculadora
    menucalc  db 13,10,"-----MODO CALCULADORA-----","$"
    ;Mensaje ingresar numero
    ingnum    db 13,10,"Ingresar Numero:","$"
    ;Mensaje ingerar operador
    ingop     db 13,10,"Ingresar Operador:","$"
    ;Mensaje ingresar operador o finalizar
    ingopfin  db 13,10,"Ingresar Operador o ; para finalizar:","$"
    ;Mensaje resultado
    menres    db 13,10,"El resultado es:","$"
    ;Mensaje opcion guardar
    mensave   db 13,10,"Desea guardar (S/N)","$"
    mensaven  db 13,10,"No se guardo la operacion","$"
    mensaves  db 13,10,"Se guardo la operacion","$"
    ;Mensaje menu factorial
    menufact db 13,10,"---------FACTORIAL--------","$"
    ;Mensaje para menu abrir archivo
    menuarchivo db 13,10,"---------CARGAR ARCHIVO--------","$"
    ;Mensaje para seleccionar archivo
    menarchivo db 13,10,"Ingresar ruta del archivo: ","$"
    ;Mensaje de reporte
    menrep db 13,10,"Reporte creado","$"
    menerror db 13,10,"Error","$"

    mensum db 13,10,"Suma: ","$"
    menresta db 13,10,"Resta: ","$"
    menmul db 13,10,"Multiplicacion: ","$"
    mendiv db 13,10,"Division: ","$"
    numero1 db ?
    numero2 db ?

.code
main proc ;Inicio procedimiento principal
    ClearScreen
    Imprimir encabezado
    start:
        Imprimir menu
        EntradaTeclado ;Ingresar opcion
        mov bl,al
        case1:;Cargar Archivo
            cmp bl,"1" ;Comparar si registro bl es igual a 1
            jne case2 ;bl no es 1, ir a "case2"
            Imprimir menuarchivo
            Imprimir menarchivo

            ClearScreen
            jmp start ;Regresar a menu principal
        case2:;Modo Calculadora
            cmp bl,"2" ;Comparar si registro bl es igual a 2
            jne case3 ;bl no es 2, ir a "case3"
            ClearScreen
            ModoCalculadora ;Inicia el modo calculadora
            jmp start ;Regresar a menu principal
        case3:;Factorial
            cmp bl,"3" ;Comparar si registro bl es igual a 3
            jne case4 ;bl no es 3, ir a "case4"
            Imprimir menufact

            ClearScreen
            jmp start ;Regresar a menu principal
        case4:;Crear Reporte
            cmp bl,"4" ;Comparar si registro bl es igual a 4
            jne case5 ;bl no es 4, ir a "case4"
            ClearScreen
            Imprimir menrep
            jmp start ;Regresar a menu principal
        case5:;Salir del programa
            cmp bl,"5" ;Comparar si registro bl es igual a 5
            jne case6 ;bl no es 5, ir a "case6"
            ClearScreen
            mov ah,4ch 
            int 21h ;Salir del programa
        case6:
            ClearScreen
            jmp start;En cualquier otro caso regresar al menu principal

main endp ;Fin procedimiento principal

end main