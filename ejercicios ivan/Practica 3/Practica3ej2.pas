program practica3ej2;
type 

     venta= record 
               codigo: integer;
               fecha: string;
               vendidas: integer;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: venta;
                    HI: arbol;
                    HD: arbol;
                 end;

	 producto = record
		codigo: integer;
		totalvendidos: integer;
	 end;
     arbol2 = ^nodoArbol2;
     nodoArbol2 = record
                    dato: producto;
                    HI: arbol2;
                    HD: arbol2;
                 end;
     
procedure GenerarArboles (var a: arbol; var a2:arbol2);
{ Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. }

  Procedure Leerventa (var v: venta);
  begin
    write ('Ingrese codigo del producto: ');
    readln (v.codigo);
    If (v.codigo <> 0)
    then begin
           write ('Ingrese la fecha de venta: ');
           readln (v.fecha);
           write ('Ingrese la cantidad de unidades vendidas:  ');
           readln (v.vendidas);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: venta);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.codigo < a^.dato.codigo) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;
  
  Procedure InsertarElemento2 (var a2: arbol2; cod:integer; vendidas: integer);
  Begin
		if (a2 = nil) 
		then begin
			   new(a2);
			   a2^.dato.codigo := cod;
			   a2^.dato.totalvendidos := vendidas; 
			   a2^.HI:= nil; 
			   a2^.HD:= nil;
			 end
		else if (cod< a2^.dato.codigo) then 
				InsertarElemento2(a2^.HI, cod, vendidas)
			 else if (cod< a^.dato.codigo) then
					 InsertarElemento2(a2^.HD, cod, vendidas)
				  else 
					 a2^.dato.totalvendidos := a2^.dato.totalvendidos + vendidas;
  End;

var v: venta;
  
Begin
 a:= nil;
 a2 := nil;
 Leerventa(v);
 while (v.codigo <> 0) do
  begin
   InsertarElemento (a, v);
   InsertarElemento2 (a2,v.codigo,v.vendidas);
   writeln;
   Leerventa (v);
  end;
end;


{inciso b: recibir arbol generado en i y un codigo de producto, y retornar cantidad total de unidades vendidas de ese producto}
procedure incisob (a:arbol);
	function devolverventastotales(a:arbol; cod:integer): integer;
	begin
		if (a=nil) then
			devolverventastotales:= 0
		else begin
			if (a^.dato.codigo=cod) then 
				devolverventastotales:= devolverventastotales(a^.HI,cod) + devolverventastotales(a^.HD,cod) + a^.dato.vendidas
			else 
				if (cod>a^.dato.codigo) then
					devolverventastotales:= devolverventastotales(a^.HD,cod)
				else
					devolverventastotales:= devolverventastotales(a^.HI,cod);
		end;
	end;
var
	codigo: integer;
begin
	writeln('Ingrese un codigo de producto para sumar sus ventas');
	readln(codigo);
	writeln('El total de ventas del codigo de producto insertado es: ');
	writeln('-------------------------------------------------------');
	writeln(devolverventastotales(a,codigo));
end;


{inciso c: recibir el arbol 2 y un codigo y buscar las ventas totales del producto}

procedure incisoc (a2: arbol2);

	function devolverventastotales2 (a2: arbol2; cod: integer): integer;
	begin
		if (a2=nil) then
			devolverventastotales2:= 0
		else
			if (a2^.dato.codigo=cod) then 
				devolverventastotales2:= a2^.dato.totalvendidos
			else begin
				if (cod>a2^.dato.codigo) then
					devolverventastotales2:= devolverventastotales2(a2^.HD,cod)
				else
					devolverventastotales2:= devolverventastotales2(a2^.HI,cod);
			end;
	end;
	
var
	codigo: integer;
begin
	writeln('Ingrese un codigo de producto para sumar sus ventas');
	readln(codigo);
	writeln('El total de ventas del codigo de producto insertado es: ');
	writeln('-------------------------------------------------------');
	writeln(devolverventastotales2(a2,codigo));
end;

var
	a: arbol;
	a2: arbol2;
begin
	generararboles(a,a2);
	writeln;
	incisob(a);
	writeln;
	incisoc(a2);
end.








