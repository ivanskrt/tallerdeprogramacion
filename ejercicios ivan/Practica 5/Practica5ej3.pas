program Practica5ej3;
const dimf = 10;
type    

    rango = 1..dimf;

    producto = record
        codigo: integer;
        rubro: rango;
        stock: integer;
        precio: integer;
    end;

    arbol = ^nodoArbol;

    nodoArbol = record  
        dato:producto;
        HI: arbol;
        HD: arbol;
    end;

    vec = array[rango] of arbol;

procedure cargarvector ( var v:vec);

    procedure leerproducto ( var p: producto);
    begin
        writeln('Inserte el codigo del producto');
        p.codigo := random(16)-1;
        writeln(p.codigo);
        if (p.codigo <> -1) then  begin
            writeln('Inserte el rubro del producto');
            p.rubro:= random(10)+1;
            writeln(p.rubro);
            writeln('Inserte el stock actual del producto');
            p.stock:= random(101);
            writeln(p.stock);
            writeln('Ingrese el precio del producto');
            p.precio:= random(1000)+1;
            writeln(p.precio);
        end;
    end;

    procedure inicializarvec (var v:vec);
    var
        i:integer;
    begin
        for i:=1 to dimf do begin
            v[i]:=nil;
        end;
    end;

    procedure insertarenarbol(var a:arbol; p:producto);
    begin
        if (a=nil) then begin
            new(a);
            a^.dato := p;
            a^.HI := nil;
            a^.HD := nil;
        end
        else begin
            if (p.codigo > a^.dato.codigo) then
                insertarenarbol(a^.HD,p)
            else
                insertarenarbol(a^.HI,p);
        end;
    end;

var
    p:producto;
begin
    inicializarvec(v);
    leerproducto(p);
    while (p.codigo <> -1) do begin
        insertarenarbol(v[p.rubro], p);
        leerproducto(p);
    end;
end;


procedure incisob (v:vec);

    function existe(a:arbol; cod:integer):boolean;
    begin
        if (a=nil) then
            existe:=false
        else 
            if (a^.dato.codigo = cod) then
                existe := true
            else 
                if (cod > a^.dato.codigo) then
                    existe := existe(a^.HD,cod)
                else
                    existe := existe(a^.HI,cod);
    end;
var
    cod: integer;
    rubro: rango;
begin
    writeln('Inserte el codigo de producto a buscar');
    readln(cod);
    writeln('Inserte el rubro donde buscarlo');
    readln(rubro);
    if (existe(v[rubro],cod)) then
        writeln('Dicho codigo existe para ese rubro')
    else
        writeln('Dicho codigo no existe para ese rubro');
end;


procedure incisoc( v:vec);

    procedure buscarcodmax (a:arbol);
    begin
        if (a<>nil) then begin
            buscarcodmax(a^.HD);
            if (a^.HD=nil) then begin
                writeln('   Codigo: ', a^.dato.codigo);
                writeln('   Stock: ', a^.dato.stock);
            end;
        end;

    end;

var
    i:rango;
begin
    for i:=1 to dimf do begin
        writeln('Rubro ', i);
        buscarcodmax(v[i]);
    end;
end;


procedure incisod (v:vec);

    procedure buscarentre (a:arbol; cod1,cod2:integer; var cant:integer);
    begin
        if (a<>nil) then begin
            if (a^.dato.codigo > cod1) and (a^.dato.codigo < cod2) then
                cant:= cant+1
            else begin
                if (a^.dato.codigo <= cod1) then
                    buscarentre(a^.HD, cod1,cod2,cant)
                else 
                    if (a^.dato.codigo >= cod2) then
                        buscarentre(a^.HI,cod1,cod2,cant);
            end;
        end;
    end;


var
    cod1,cod2,cant: integer;
    i: rango;
begin
    writeln('Ingrese desde que codigo se busca');
    readln(cod1);
    writeln('Ingrese hasta que codigo se busca');
    readln(cod2);
    for i:=1 to dimf do begin
        cant:=0;
        buscarentre(v[i],cod1,cod2,cant);
        writeln('Cantidad de productos con codigos entre los valores ingresados: ', cant);
    end;
end;

procedure imprimirarboles(v:vec);

        procedure imprimirarbol (a:arbol);
        begin
            if (a<>nil) then begin
                imprimirarbol(a^.HI);
                writeln('   Codigo de producto: ', a^.dato.codigo);
                writeln;
                writeln('   Rubro de producto: ', a^.dato.rubro);
                writeln('-');
                imprimirarbol(a^.HD);
            end;
        end;
var 
    i:integer;
begin
    for i:=1 to dimf do begin
        writeln('Arbol: ', i);
        imprimirarbol(v[i]);
        writeln('--');
    end;
end;          

var
    v:vec;
begin
    cargarvector(v);
    writeln('-------------------------------');
    imprimirarboles(v);
    writeln('-------------------------------');
    incisob(v);
    writeln('-------------------------------');
    incisoc(v);
    writeln('-------------------------------');
    incisod(v);
end.


