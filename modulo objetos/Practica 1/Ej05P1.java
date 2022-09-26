/*
5- El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen
(con puntaje de 1 a 10) los siguientes aspectos: (0) Atención al cliente (1) Calidad
de la comida (2) Precio (3) Ambiente.
Escriba un programa que lea desde teclado las calificaciones de los cinco clientes
para cada uno de los aspectos y almacene la información en una estructura. Luego
imprima la calificación promedio obtenida por cada aspecto.
 */
package tema1;

import PaqueteLectura.Lector;
/**
 *
 * @author Ivan
 */
public class Ej05P1 {
    
    public static void main(String[] args) {
    
        int [][] califiq = new int [5][4];
        String mnsjs[] = {"Califique de 1 a 10 la atencion al cliente del restaurant",
                          "Califique de 1 a 10 la calidad de la comida del restaurant",
                          "Califique de 1 a 10 lel precio del restaurant",
                          "Califique de 1 a 10 el ambiente del restaurant"};
        double[] proms = new double[4];
        int puntaje;
        double promedio;
        for (int i=0; i<5; i++) {
           for (int j=0; j<4; j++){
                System.out.println(mnsjs[j]);
                puntaje = Lector.leerInt();
                califiq[i][j] = puntaje;
                proms[j] = proms[j] + puntaje;
           }
           System.out.println("Siguiente cliente");
        }
        for (int g=0; g<4; g++){
            promedio = proms[g]/5.0;
            System.out.println("La calificacion promedio obtenida del aspecto " + g +   " fue de " + promedio);
        }
    }
  
}
