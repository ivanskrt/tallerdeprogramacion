program practicaej5;
const dimf = 6;
type
    indice = 1..dimf;

    vec = array[indice] of integer;

procedure cargarv(var v:vec);
var 
    i: integer;
begin   
    for i:=1 to dimf do begin   
        writeln('Escriba un numero entero');
        readln(v[i]);
    end;
end;

procedure buscardato(v:vec);

    procedure busquedadicotomica(v: vec; ini,fin: indice; dato:integer; var pos: integer); 
    var
        medio: indice;
    begin
        if (fin<ini) then begin 
            pos:= -1;
        end
        else begin
            medio := (ini + fin) div 2;
            if (v[medio] = dato) then begin
                pos := medio;
            end
            else begin
                if (v[medio] > dato) then begin
                    busquedadicotomica(v,ini,medio-1,dato,pos);
                end
                else begin
                    busquedadicotomica(v,medio+1,fin,dato,pos);
                end;
            end;
        end;
    end;
var
    ini,fin: indice;
    dato,pos: integer;
begin
    ini:=1; fin:=6;
    writeln('ingrese numero a buscar en el vector');
    readln(dato);
    busquedadicotomica(v,ini,fin,dato,pos);
    writeln ('-------------------------------');
    writeln(pos);
end;

var
    v:vec;
begin   
    cargarv(v);
    buscardato(v);
end.
