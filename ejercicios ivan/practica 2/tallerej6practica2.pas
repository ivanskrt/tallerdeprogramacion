program practicaej6;

procedure leeryconvertir();
    procedure convertirabinario(var dato:integer);
    var
        aux1,aux2: integer;
    begin
        if (dato<>0) then begin
    
            aux1:= dato mod 2;
            aux2:= dato div 2;
            
    
            convertirabinario(aux2);
            writeln(aux1);
        end;
    end;
var
    dato:integer;
begin
    writeln('Ingrese un numero entero');
    readln(dato);
        while (dato <>0) do begin
             writeln('-------------------');
             convertirabinario(dato);
             writeln('Ingrese un numero entero');
             readln(dato);
        end;
end;


begin
    leeryconvertir;
end.
