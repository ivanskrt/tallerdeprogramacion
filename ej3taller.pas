program ej3taller;
type

gen = 1..8;

peli = record
	codpeli: integer;
	codgen: gen;
	puntajeprom: real;
end;

lista= ^nodo;

nodo = record
	dato: peli;
	sig: lista;
end;

vec = array[gen] of peli;

procedure cargarlista (var l:lista);
	procedure leerpeli (var p:peli);
	begin
		readln(p.codpeli);
		if (p.codpeli <> -1) then
			readln(p.codgen);
			readln(p.puntajeprom);
	end;
	
	procedure insertarord( var l:lista; p:peli);
	var
		nue,act,ant: lista;
	begin
		new(nue);
		nue^.dato:=p;
		act:=l;
		ant:=l;
		while (act<>nil) and (p.codgen>act^.dato.codgen) do begin
			ant:=act;
			act:=act^.sig;
		end;
		if (act=ant) then 
			l:=nue
		else
			ant^.sig:=nue;

		nue^.sig:=act;
	end;
	
var
	p:peli;
begin
	l:=nil;
	leerpeli(p);
	while (p.codpeli<>-1) do begin
		insertarord(l,p);
		leerpeli(p);
	end;	
end;

procedure armarv(var v: vec; l:lista);

	procedure cargarv( var v: vec; l:lista);
	var
		maxpuntaje: real;
		genact: gen;
		
	begin
		while (l<>nil) do begin
			maxpuntaje := -1;
			genact := l^.dato.codgen;
			while (l<>nil) and (genact = l^.dato.codgen) do 
			begin
				if (l^.dato.puntajeprom > maxpuntaje) then 
					maxpuntaje := l^.dato.puntajeprom;
					v[l^.dato.codgen]:=l^.dato;
				l:=l^.sig;
			end;
	end;		

	procedure ordenarv (var v:vec);
	var 
		i, j , p : gen; item: peli;
	begin
		for i:= 1 to dimL - 1 do begin
			p:= i;
			for j:= i+1 to dimL do begin
				if v[j].puntajeprom < v[p].puntajeprom then p:=j;
		end;
		item := v[p];
		v[p]:= v[i];
		v[i] := item;
	end;
var
	i: gen;
	max,min: real;
	codmax,codmin: integer;
begin
	max:= -1;
	min:=9999;
	cargarv(v,l);
	ordenarv(v,l);
	for i:=1 to gen do begin
		if v[i].puntajeprom > max then begin
			max := v[i].puntajeprom;
			codmax := v[i].codpeli;
		end;
		if v[i].puntajeprom < min then begin
			min := v[i].puntajeprom;
			codmin := v[i].codpeli;
		end;
	end; 
	writeln ('Codigo del maximo: ', codmax, 'Puntaje maximo: ', max);
	writeln ('Codigo del minimo: ', codmin, 'Puntaje minimo: ', min);
end;

var
	l:lista;
	v: vec;
BEGIN
	cargarlista(l);
	armarv(v,l);
	
END.

