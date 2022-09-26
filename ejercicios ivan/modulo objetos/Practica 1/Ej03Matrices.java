/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema1;

//Paso 1. importar la funcionalidad para generar datos aleatorios

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;


public class Ej03Matrices {

    public static void main(String[] args) {
	//Paso 2. iniciar el generador aleatorio 
        GeneradorAleatorio.iniciar();
        //Paso 3. definir la matriz de enteros de 5x5 e iniciarla con nros. aleatorios 
        int[][] tabla = new int[5][5];
        for (int i=0; i<5; i++) {
            for(int j=0; j<5; j++) 
                tabla[i][j]= GeneradorAleatorio.generarInt(10);
        } 
        //Paso 4. mostrar el contenido de la matriz en consola
        for (int k=0; k<5; k++) {
            for (int g=0; g<5; g++) 
                System.out.println("Fila: " + k + " Columna: " + g + " Contiene: " + tabla[k][g] );
        }
        //Paso 5. calcular e informar la suma de los elementos de la fila 1
        int suma = 0;
        for (int f=0; f<5; f++){
            suma = suma + tabla [1][f];
        }
        System.out.println("Suma de los elementos de la fila 1 dio: " + suma);
        //Paso 6. generar un vector de 5 posiciones donde cada posiciÃ³n j contiene la suma de los elementos de la columna j 
        //de la matriz. 
        int [] vec = new int[5];
        for (int p=0; p<5; p++) {
            for (int o=0; o<5; o++) 
                vec[p] = vec[p] + tabla [o][p];
        }
        //        Luego, imprima el vector.
        for (int t=0; t<5; t++)
            System.out.println("Columna: " + t + " Total:  " + vec[t] );
        //Paso 7. lea un valor entero e indique  si se encuentra o no en la matriz. En caso de encontrarse indique 
        //su ubicaciÃ³n (fila y columna)
        //   y en caso contrario imprima "No se encontrÃ³ el elemento".
        System.out.println("Ingrese un valor entero a buscar en la matriz");
        int buscar = Lector.leerInt();
        boolean cumple = false;
        while (cumple == false){
            for (int z=0; z<5; z++) {
                for (int q=0; q<5; q++) {
                    if (buscar == tabla[z][q]){
                        System.out.println("Fila: " + z + " Columna: " + q);
                        cumple = true;
                    }
                }       
            }
            if (cumple != true){
                System.out.println("No se encontro el elemento.");
                cumple = true;
            }
        }
    }
}
