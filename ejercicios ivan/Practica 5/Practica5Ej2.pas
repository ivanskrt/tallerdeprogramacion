program Practica5Ej2;
const dimf = 2018;
type
	anios = 2010..2018;
	
	auto = record
		patente: string;
		fabricacion: anios;
		marca: string;
		modelo: string;
	end;
	
	Arbol = ^nodoarbol;
	
	nodoarbol = record
		dato: auto;
		HI: arbol;
		HD: arbol;
	end;
	
	lista = ^nodo;
	
	nodo = record
		dato: auto;
		sig: lista;
	end;
	
	vec = array[anios] of lista;

 procedure GenerarArbol ( var a:arbol);
	
		procedure leerauto ( var a:auto);
		begin
			writeln('Insertar patente del auto');
			readln(a.patente);
			writeln;
			if (a.patente <> 'Fin') then begin
				writeln('Ingrese el anio de fabricacion del auto');
				readln(a.fabricacion);
				writeln('Ingrese la marca del auto');
				readln(a.marca);
				writeln('Ingrese el modelo del auto');
				readln(a.modelo);
				writeln;
			end;
		end;
		
		procedure insertarnodo ( var a:arbol; elem: auto);
		begin
			if (a=nil) then
			begin
				new(a);
				a^.dato:=elem;
				a^.HI := NIL;
				a^.HD := nil;
			end
			else 
				if (elem.patente > a^.dato.patente) then
					insertarnodo(a^.HD,elem)
				else
					insertarnodo(a^.HI,elem);
		end;
var
	aut: auto;
begin
	a:=nil;
	leerauto(aut);
	while (aut.patente <> 'Fin') do begin
		insertarnodo(a,aut);
		leerauto(aut);
	end;
end;

procedure incisob (a:arbol);
	function cantmarca(a:arbol; m: string): integer;
	begin
		if (a = nil) then
			cantmarca :=0
		else
			if (a^.dato.marca = m) then
				cantmarca := cantmarca(a^.HI,m) + cantmarca(a^.HD,m) +1
			else
				cantmarca := cantmarca(a^.HI,m) + cantmarca(a^.HD,m);
	end;
var
	m: string;
begin
	writeln('Ingrese la marca de la  que quiere saber cuantos autos vendio: ');
	readln(m);
	writeln('La cantidad de autos que vendio dicha marca fue de: ', cantmarca(a,m));
end;

procedure generarvector ( var v:vec; a:arbol);

	procedure inicializarvec ( var v:vec);
	var 
		i: integer;
	begin
		for i:=2010 to dimf do begin
			v[i]:=nil;
		end;
	end;
	
	procedure agregaratras( var l,ult:lista; dato: auto);
	var
		nue: lista;
	begin
		new(nue);
		nue^.dato:=dato;
		nue^.sig:=nil;
		if (l=Nil) then
			l:=nue
		else 
			ult^.sig:=nue;
		ult:=nue;
	end;
	
	procedure cargarv( a:arbol; var v:vec);
	var
		ult:lista;
	begin
		if (a<>nil) then begin
			cargarv(a^.HI,v);
			agregarAtras(v[a^.dato.fabricacion],ult,a^.dato);
			cargarv(a^.HD,v);
		end;
	end;
	

begin
	inicializarvec(v);
	cargarv(a,v);
end;
			

procedure incisod (a:arbol);
				
		function devolverfabricacion(a:arbol; pat:string): integer;
		begin
			if (a = nil) then 
				devolverfabricacion:=-1
			else
				if (a^.dato.patente = pat) then
					devolverfabricacion := a^.dato.fabricacion
				else
					if (pat>a^.dato.patente) then
						devolverfabricacion:= devolverfabricacion(a^.HD,pat)
					else
						devolverfabricacion:= devolverfabricacion(a^.HI,pat);
		end;

var
	pat: string;
begin
	writeln('Ingrese la patente del auto que precisa el anio de fabricacion');
	readln(pat);
	writeln('El anio de fabricacion del auto cuya patente ingreso es: ', devolverfabricacion(a,pat));
end;

procedure imprimirLista(l: lista);
  begin
     if (l <> nil) then 
     begin
        writeln('      Patente: ', l^.dato.patente, '  cantidad: ', l^.dato.fabricacion);
        imprimirLista (l^.sig);
     end;
  end;

procedure ImprimirVectorListas (v: vec);
var i: integer;
begin
  writeln;
  writeln ('----- Vector de listas ----->');
  writeln;
  for i:= 2010 to dimF do
  begin
     writeln;
     writeln ('Anio ', i);
     if (v[i] = nil ) 
     then writeln ('      Sin elementos')
     else imprimirLista (v[i]);
  end;
end;


procedure imprimirarbol(a:arbol);
begin
	if (a<>nil) then begin
		imprimirarbol(a^.HI);
		writeln(a^.dato.patente);
		imprimirarbol(a^.HD);
	END;
END;

var
	a: arbol;
	v: vec;
begin
	GenerarArbol(a);
	writeln;
	imprimirarbol(a);
	writeln;
	incisob(a);
	writeln;
	generarvector(v,a);
	ImprimirVectorListas(v);
end.					
						
						
	
	
	
	
	
				
				
