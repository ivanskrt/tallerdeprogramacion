{2.- Realizar un programa que lea números hasta leer el valor 0 e imprima,
*  para cada número leído, sus dígitos en el orden en que aparecen en el 
* número. Debe implementarse un módulo recursivo que reciba el número e i
* mprima lo pedido. Ejemplo si se lee el valor 256, se debe imprimir 2 5  6
}


program p2e2;

procedure ImprimirRecursivo (num: integer);
	begin
		if (num <> 0) then begin
		ImprimirRecursivo(num div 10);	
		writeln(num mod 10);
		end;
		
		
		
		

	end;	
var
	num: integer;

Begin
	write('Ingrese un numero: ');
	readln(num); 
	ImprimirRecursivo(num);
End.

