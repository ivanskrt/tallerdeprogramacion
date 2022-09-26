/*
4) Un edificio de oficinas está conformado por 8 pisos (1..8) y 4 oficinas por piso
(1..4). Realice un programa que permita informar la cantidad de personas que
concurrieron a cada oficina de cada piso. Para esto, simule la llegada de personas al
edificio de la siguiente manera: a cada persona se le pide el nro. de piso y nro. de
oficina a la cual quiere concurrir. La llegada de personas finaliza al indicar un nro.
de piso 9. Al finalizar la llegada de personas, informe lo pedido.
 */
package tema1;

import PaqueteLectura.Lector;

/**
 *
 * @author Ivan
 */
public class Ej04P1 {
    
     public static void main(String[] args) {
         //declaro edificio
         int[][] edificio = new int[8][4];
         int piso, ofi;
    
         
         //llegada de personas al edificio
         System.out.println("Ingrese numero de piso");
         piso = Lector.leerInt();
         System.out.println();
         while (piso != 9){
           
             System.out.println("Ingrese numero de oficina");
             ofi = Lector.leerInt();
             System.out.println();
             //Sumo +1 en la oficina
             edificio[piso][ofi]++;
             System.out.println("Ingrese numero de piso");
             piso = Lector.leerInt();
             System.out.println();
            
         }
         //Informamos personas por oficina
         for (int i=0; i<8; i++){
             for (int j=0; j<4; j++) 
                 System.out.println("Piso: " + i + " Oficina: " + j + " Cantidad: " + edificio[i][j]);
         }
         
         
     }
    
    
    
    
    
    
    
    
    
}
