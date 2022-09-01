{
a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario. 
}

program untitled;

type
  lista = ^nodo;
  nodo = record
          dato: integer;
          sig: lista;
         end;
         
procedure CargarLista (var l: lista);
var numero: integer;
    nuevo: lista;
Begin
  randomize;
  numero:= random(100);
  if (numero <> 0 )  
  then begin
         CargarLista (l);
         new (nuevo);
         nuevo^.dato:= numero;
         nuevo^.sig:= l;
         l:= nuevo;
       end
  else 
  begin l:= nil
  end;
End;

procedure MinValor (l: lista; var min: integer);
begin
	if (l <> nil) then begin
		MinValor(l^.sig, min);
		if (min > l^.dato) then begin
			min:= l^.dato;
		end;	
	end;	
	
end;

procedure MaxValor (l: lista; var max: integer);
begin
	if (l <> nil) then begin
		MaxValor(l^.sig, max);
		if (max < l^.dato) then begin
			max:= l^.dato;
		end;	
	end;	
	
end;

procedure BuscarValor (l: lista; valor: integer; var correcto: boolean);
begin
	if (l <> nil) then begin
		BuscarValor(l^.sig, valor, correcto);
		if (valor = l^.dato) then begin
		correcto:= true;
	    end;
	end;
end;

var

l: lista;
min, max, valor: integer;
correcto: boolean;
BEGIN
		min:= 150;
		max:= -1;
		correcto:= false;
		readln(valor);
		CargarLista(l);
		MinValor(l, min);
		MaxValor(l, max);
		writeln(min);
		writeln(max);
		BuscarValor(l, valor, correcto);
		if (correcto = true) then begin
			writeln ('verdadero');
		end
		else begin
			writeln ('falso');
		end;	
END.

