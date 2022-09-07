program practica3ej3;
type
	
	     alumno = record 
               legajo: integer;
               dni:  integer;
               ingreso: integer;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: alumno;
                    HI: arbol;
                    HD: arbol;
                 end;
	
procedure GenerarArbol (var a: arbol);
{ Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. }

  Procedure Leeralumno (var al: alumno);
  begin
	write ('Ingrese el legajo del alumno:  ');
	readln (al.legajo);
	if (al.legajo<>0) then begin
		write ('Ingrese anio de ingreso del alumno: ');
		readln (al.ingreso);
		write ('Ingrese el dni del alumno: ');
		readln (al.dni);
	end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: alumno);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.legajo < a^.dato.legajo) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;
  
var al: alumno;
  
Begin
	 a:= nil;
	 Leeralumno(al);
	 while (al.legajo <> 0) do
	  begin
	  if (al.ingreso<2010) then
			InsertarElemento (a, al);
	   writeln;
	   Leeralumno(al);
	  end;
end;  


procedure incisob (a:arbol);
		
		procedure informaralumnos (a:arbol; valor: integer);
		begin
			if (a <> nil) and (a^.dato.legajo<valor) then begin
				informaralumnos (a^.HI,valor);
				if (a^.dato.legajo<valor) then
					writeln(	'DNI: ',a^.dato.dni ,' Ingreso: ', a^.dato.ingreso);
				informaralumnos (a^.HD,valor);
			end
			else  if (a <> nil) and (a^.dato.legajo>=valor) then
				informaralumnos (a^.HI,valor);
		end;

var
	valor: integer;
begin
	
	writeln('Ingresar numero de legajo para buscar los menores al mismo');
	readln(valor);
	informaralumnos(a,valor);
end;

procedure incisoc (a:arbol);
	procedure informarentrevalores(a:arbol; val1,val2:integer);
	begin
			if (a <> nil) and (a^.dato.legajo>val1) and (a^.dato.legajo<val2) then begin
				informarentrevalores(a^.HI,val1,val2);
				if  (a^.dato.legajo<val2) then
					writeln(	'DNI: ',a^.dato.dni ,' Ingreso: ', a^.dato.ingreso);
				informarentrevalores (a^.HD,val1,val2);
			end
			else  begin
					if (a <> nil) and (a^.dato.legajo<=val1) then
						informarentrevalores (a^.HD,val1,val2)
					else if (a <> nil) and (a^.dato.legajo>=val2) then
						informarentrevalores(a^.HI,val1,val2);
			end;
	end;

var val1,val2: integer;
begin
	writeln('Inserte desde que numero se busca en el rango: ');
	readln(val1);
	writeln('Inserte hasta que numero se busca en el rango: ');
	readln(val2);
	informarentrevalores(a,val1,val2);
end;

procedure incisod (a:arbol);
		{procedure dnimasgrande (a:arbol; var max:integer);
		begin
			if (a<>nil) then begin
				dnimasgrande(a^.HI, max);
				if (a^.dato.dni>max) then 
					max:=a^.dato.dni;
				dnimasgrande(a^.HD,max);
			end;
		end;}
		
		
		function dniMaximo (a:arbol): integer;
		var maxI, maxD, max: integer;
		begin
			if (a = nil) then
			  dniMaximo := -1
			else begin
			  maxI := dniMaximo (a^.HI);
			  maxD := dniMaximo (a^.HD);
			  if (maxI > maxD) then
				max := maxI
			  else
				max := maxD;
			  if (a^.dato.dni > max) then
				max := a^.dato.dni;
			  dniMaximo := max;
			end;
		end;
begin
	writeln('El dni mas grande es: ', dnimaximo(a));
end;
			
			
function incisoe(a:arbol): integer;
begin
	if (a=nil) then
		incisoe:=0
	else
		if (a^.dato.legajo mod 2 <> 0 ) then
			incisoe := incisoe(a^.HI) + incisoe(a^.HD) + 1
		else
			incisoe:= incisoe(a^.HI) + incisoe(a^.HD);
end;
			

	
var
	a:arbol;
begin
	GenerarArbol(a);
	//incisob(a);
	//incisoc(a);
	incisod(a);
	writeln('Cantidad de legajos impares: ',incisoe(a));
end.
  
  
  
  
  
  
  
  
  
  
  
