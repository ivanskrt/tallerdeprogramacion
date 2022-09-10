{
 A)Genere un vector de a lo sumo 300 oficinas que administra. De cada una se ingresa codigo de identificacion, dni del propietario y valor de la expensa
 la lectura finaliza cuando lee el codigo -1
 * }

program Practica5ej1;
const dimf = 10;
type
	rango = 1..dimf;
	
	oficina = record
		codid: integer;
		dniprop: integer;
		valorexp: integer;
	end;
	
	vec = array[rango] of oficina;
	
procedure cargarvec (var v:vec; var diml:integer );
	
	procedure leerofi(var ofi: oficina);
	begin
		writeln('Inserte el codigo de identificacion de la oficina');
		readln(ofi.codid);
		{ofi.codid:= Random (21)-1;
        write(ofi.codid);}
		if (ofi.codid <> -1) then begin
			writeln('Inserte el dni del propietario de la oficina');
			readln(ofi.dniprop);
			{ofi.dniprop:= random(300);
			write(ofi.dniprop);
			writeln;}
			writeln('Inserte el valor de la expensa');
			readln(ofi.valorexp);
			{ofi.codid:= Random (10);
			write(ofi.codid);	
			writeln;}
		end;
	end;
	
var 
	o: oficina; 
begin
	Randomize;
	diml:=0;
	leerofi(o);
	writeln;
	while (o.codid <> -1) and (diml<dimf) do begin
		diml:= diml+1;
		v[diml]:= o;
		leerofi(o);
		writeln;
	end;
end;
	
procedure ordernarporsel  ( var v: vec; dimL: rango);
var 
	i, j , p : rango; item: oficina;
begin
	for i:= 1 to dimL - 1 do begin
		p:= i;
		for j:= i+1 to dimL do begin
			if v[j].codid < v[p].codid then p:=j;
		end;
		item := v[p];
		v[p] := v[i];
		v[i] := item;
	end;
end;

procedure buscarelemento (v:vec; diml: rango);
	procedure busquedadicotomica(v:vec; codbuscado:integer; inicio,fin: rango);
	var
		medio: rango;
	begin
		if (fin<inicio) then begin	
			writeln('El codigo buscado no existe');
		end
		else begin
				medio:=(inicio+fin) div 2;
				if (v[medio].codid = codbuscado) then
					writeln(v[medio].dniprop)
				else
					if (v[medio].codid > codbuscado) then
						busquedadicotomica(v,codbuscado,inicio,medio-1)
					else
						busquedadicotomica(v,codbuscado,medio+1,fin);
			 end;
	end;
var
	inicio: rango;
	cod: integer;
begin
	inicio:=1;
	writeln('Ingrese el codigo de oficina a buscar : ');
	readln(cod);
	busquedadicotomica(v,cod,inicio,diml);
end;

procedure totalexp(v:vec; diml:rango);
	
	function sumarvector (v:vec; i,diml: rango): integer;
	begin
		if (i=diml) then 
		begin 
			sumarvector := v[i].valorexp;
		end   
		else begin
			sumarvector := sumarvector(v,i+1,diml) + v[i].valorexp;
		end;
	end;
	
var
	i: integer;
begin
	i:=1;
	writeln ('El monto total de expensas es: ', sumarvector(v,i,diml));
end;

var
	v: vec;
	diml: integer;
begin
	cargarvec(v,diml);
	buscarelemento(v,diml);
	totalexp(v,diml);
end.











