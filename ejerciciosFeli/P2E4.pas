{
a. Implemente un módulo recursivo que genere un vector de 20 números enteros “random” mayores a 0 y menores a 100. 
b. Implemente un módulo recursivo que devuelva el máximo valor del vector. 
c. Implementar un módulo recursivo que devuelva la suma de los valores contenidos en el vector.  
}

program untitled;
const 
dimF = 20;

type 
vector = array [1..dimF] of integer;


  procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
  var numero: integer;
  begin
    randomize;
    numero:= random(100); 
    if (dimL < dimF) 
    then begin
          dimL:= dimL + 1;
          v[dimL]:= numero;
          CargarVectorRecursivo (v, dimL);
         end;
  end;
  
  procedure MaxValor (v: vector; var max: integer; dimL: integer);
  begin
	if (dimL <> 0) then begin
		MaxValor(v, max, dimL-1);
		if (max < v[dimL]) then begin
			max:= v[dimL];
		end;	
	end;	
  end;
  
  procedure SumaValor (v: vector; var suma: integer; dimL: integer);
  begin
	if (dimL <> 0) then begin
		SumaValor(v, suma, dimL-1);
		suma:= suma + v[dimL];	
	end;	
  end;


var 
dimL, max, suma: integer;
v: vector;
begin
  dimL:= 0;
  max:= -1;
  suma:= 0;
  CargarVectorRecursivo (v, dimL);
  MaxValor(v, max, dimL);
  SumaValor(v,suma,dimL);
  writeln(max);
  writeln(suma);
end.


