include Macros.asm  ;Import file "macros.asm"
include Archivos.asm

.model small
.stack 100h
.data
    ;Text for header************************************************************
        header  db 13,10,"UNIVERSIDAD DE SAN CARLOS DE GUATEMALA"
                db 13,10,"FACULTAD DE INGENIERIA"
                db 13,10,"ESCUELA DE CIENCIAS Y SISTEMAS"
                db 13,10,"ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1"
                db 13,10,"SECCION A"
                db 13,10,"PRIMER SEMESTRE 2021"
                db 13,10,"Sergio Sebastian Chacon Herrera"
                db 13,10,"201709159","$"
    ;Text for main menu*********************************************************
        mainmenu    db 13,10,"------MENU PRINCIPAL------"
                    db 13,10,"Opciones:"
                    db 13,10,"1. Cargar Archivo"
                    db 13,10,"2. Modo Calculadora"
                    db 13,10,"3. Factorial"
                    db 13,10,"4. Crear Reporte"
                    db 13,10,"5. Salir"
                    db 13,10,"Elegir: ",'$'
    ;Texts for menu Modo Calculadora********************************************
        calcmenu  db 13,10,"-----MODO CALCULADORA-----","$"
        promptnum   db 13,10,"Ingresar Numero:","$"
        promptop    db 13,10,"Ingresar Operador:","$"
        promptcont  db 13,10,"Ingresar Operador o ; para finalizar:","$"
        mesres    db 13,10,"El resultado es: ","$"
        messave   db 13,10,"Desea guardar (S/N)","$"
        messaven  db 13,10,"No se guardo la operacion","$"
        messavey  db 13,10,"Se guardo la operacion","$"
        meserr db 13,10,"Error","$"
        mesadd db 13,10,"Suma: ","$"
        messub db 13,10,"Resta: ","$"
        mesmul db 13,10,"Multiplicacion: ","$"
        mesdiv db 13,10,"Division: ","$"
        number1 db 5 dup ("$")
        number2 db 5 dup ("$")
        number1n dw ?
        number2n dw ?
        resultado dw ?
    ;Texts for menu Modo Factorial**********************************************
        factmenu db 13,10,"---------FACTORIAL--------","$"
        promptfact db 13,10,"Ingrese un numero: ","$"
        opfact db 13,10,"Operaciones: ","$"
        resfact db 13,10,"Resultado: ","$"
        textfactorial db 5 dup ("$")    ;Input of number factorial in text
        numfactorial dw ?   ;textfacotial in decimal format
        numresfact dw ? ;Saves value from factorial in decimal
        txtresfact dw ? ;Saves value from factorial in text
        factsign db "!="
        factmul db "*"
        operationsfact dw 20 dup(0),"$"
    ;Texts for menu Cargar Archivo
    filemenu db 13,10,"---------CARGAR ARCHIVO--------","$"
    promptfile db 13,10,"Ingresar ruta del archivo: ","$"
    ;Texts for menu Reportes
        mesrep db 13,10,"Reporte creado","$"
        repname db "REPORTE.HTM","$"
        handleReporte dw ?
        reptitle db 13,10,"<title>Reporte Practica 3</title>","$" ;35
        repheader db 13,10,"<h1>Practica 3 Arqui 1 Seccion A</h1>","$" ;39
        repstudent db 13,10,"<h3>Estudiante: Sergio Sebastian Chacon Herrera</h3>","$";55
        repid db 13,10,"<h3>Carnet: 201709159</h3>","$";28
        repdate db 13,10,"<h3>Fecha: </h3>","$";18
        reptime db 13,10,"<h3>Hora: </h3>","$";17
        reprow1 db 13,10,"<tr><th>ID</th><th>Operacion</th><th>Resultado</th></tr>","$";58
        mainlbl db 13,10,"<!DOCTYPE html>","$";17
        ohtml db 13,10,"<html>","$";8
        chtml db 13,10,"</html>","$";9
        ohead db 13,10,"<head>","$";8
        chead db 13,10,"</head>","$";9
        obody db 13,10,"<body>","$";8
        cbody db 13,10,"</body>","$";9
        otable db 13,10,"<table border>","$";16
        ctable db 13,10,"</table>","$";10
        otr db 13,10,"<tr>","$"
        ctr db 13,10,"</tr>","$"
        oth db 13,10,"<th>","$"
        cth db 13,10,"</th>","$"

.code
main proc   ;Main procedure starts
    mov ax,@data
    mov ds,ax
    ;ClearScreen
    PrintText header
    start:
        PrintText mainmenu
        EnterOption
        mov bl,al   ;Move input to register "bl"
        case1:  ;Cargar Archivo
            cmp bl,"1" ;Compare if bl is 1
            jne case2 ;bl is not 1, go to case2
        case2:  ;Modo Calculadora
            cmp bl,"2" ;Compare if bl is 2
            jne case3 ;bl is not 2, go to case3
            ModoCalculadora ;bl is 2, start ModoCalculadora
            jmp start   ;Jump to start
        case3:  ;Factorial
            cmp bl,"3" ;Compare if bl is 3
            jne case4 ;bl is not 3, go to case4
            ModoFactorial
            jmp start
        case4:  ;Crear Reporte
            cmp bl,"4" ;Compare if bl is 4
            jne case5 ;bl is not 4, go to case5
            CrearReporte
            jmp start
        case5:  ;Salir
            cmp bl,"5" ;Compare if bl is 5
            jne case6 ;bl is not 5, go to case6
            mov ah,4ch  ;Exit program
            int 21h     ;Exit program
        case6:  ;Any other case
            ClearScreen
            jmp start   ;Jump to start
            
main endp   ;Main procedure ends
end main