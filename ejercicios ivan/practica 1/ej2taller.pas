program ej2;
type
	
	const dimF = 1..100;
	
	dimL = 0..dimF;
	
	ofi = record
		codid : integer;
		dni: integer;
		valor: real;
	end;
	
	vec = array [dimF] of ofi;
	
procedure cargarvector(var v:vec; var dimL: dimL);
	
	procedure leerofi ( var o: ofi);
	begin
		readln(ofi.codid);
		if (ofi.codid <> -1) then
			readln(ofi.dni);
			readln(ofi.valor);
	end;
var
	o:ofi; i:integer;
begin
	dimL:=0;
	leerofi(o);
	while (o.codid <> -1) and (dimL < dimF) do begin
		dimL:= dimL+1;
		v[dimL] := o;
		leerofi(o);
	end;
end;

procedure ordenarporinc ( var v: vec; dimL: dimL);
var
	i,j: dimL; act: ofi;
begin
	for i:=2 to dimL do begin
		act:= v[i];
		j:= i-1;
		while (j > 0) and (v[j].codid > act.codid) do begin
			v[j+1]:= v[j];
			j:=j-1;
		end;
		v[j+1] := act;
end;

procedure ordernarporsel  ( var v: vec; dimL: dimL);
var 
	i, j , p : dimL; item: o;
begin
	for i:= 1 to dimL - 1 do begin
		p:= i;
		for j:= i+1 to dimL do begin
			if v[j].codid < v[p].codid then p:=j;
		end;
		item := v[p];
		v[p]:= v[i];
		v[i] := item;
	end;
end;
	
var
	v:vec;
	dimL: dimL;

BEGIN
	cargarvector(v,dimL);
	ordenarporinc(v,dimL);
	cargarvector(v,dimL);
	ordenarporsel(v,dimL);
	
END.


