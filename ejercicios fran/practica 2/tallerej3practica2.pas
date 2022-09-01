program tallerej3;
type    
    lista = ^nodo;

    nodo = record  
        dato: integer;
        sig: lista;
    end;

procedure cargarlista (var l:lista);
var 
 num: integer;
begin   
    num:=random(100);
    if (num<>0) then begin
        new(l);
        l^.dato := num;
        cargarlista(l^.sig);
    end
    else    
        l:=nil;
    
end;

function buscarminimo (l:lista): integer;
var 
    min: integer; 
begin

    if (l^.sig=nil) then begin 
        buscarminimo:=l^.dato;
    end
    else  begin
        min := buscarminimo(l^.sig);
        if (min < l^.dato) then buscarminimo := min
        else begin
            buscarminimo:=l^.dato;
        end;
        l:=l^.sig; 
    
    end;
    

end;

function buscarmaximo (l:lista): integer;
var 
    max: integer; 
begin

    if (l^.sig=nil) then begin 
        buscarmaximo:=l^.dato;
    end
    else  begin
        max := buscarmaximo(l^.sig);
        if (max > l^.dato) then buscarmaximo := max
        else begin
            buscarmaximo:=l^.dato;
        end;
        l:=l^.sig; 
    
    end;
    

end;

function buscarvalor (l:lista; valor: integer): boolean;
begin
    buscarvalor:=false;
    if (l<>nil) then
        if(l^.dato=valor) then begin
            buscarvalor := true;
        end
        else begin
            buscarvalor := buscarvalor(l^.sig, valor);
        end;
end;


procedure imprimirlista (l: lista);
begin
    while (l<>nil) do begin
        writeln(l^.dato);
        l:=l^.sig;
    end;
end;

var 
    l:lista;
    valor: integer;
begin   
    l:=nil;
    cargarlista(l);
    imprimirlista(l);
    writeln(buscarminimo(l));
    writeln(buscarmaximo(l));
    readln(valor);
    writeln(buscarvalor(l,valor));
end.
