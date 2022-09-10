program Practica5ej4;
const dimf = 7; valorgrande = 9999;
type

    dias = 1..dimf;

    entrada = record
        dia: dias;
        codigo: integer;
        asiento: integer;
        monto: integer;
    end;

    lista = ^nodo;

    nodo = record
        dato: entrada;
        sig: lista;
    end;

    vec = array[dias] of lista;

    acumulador = record
        cod: integer;
        vendidas: integer;
    end;

    listaAcumuladora = ^nodoAcumulador;

    nodoAcumulador = record
        dato: acumulador;
        sig: listaAcumuladora;
    end;

procedure cargarv (var v:vec);

    procedure leerentrada (var e:entrada);
    begin
        writeln('Ingrese el codigo de la obra');
        e.codigo:= random(15);
        writeln(e.codigo);
        if (e.codigo <> 0) then begin
            writeln('Ingrese el dia de la entrada');
            e.dia:=random(7)+1;
            writeln(e.dia);
            writeln('Ingrese el asiento de la entrada');
            e.asiento:= random(100);
            writeln(e.asiento);
            writeln('Ingrese el monto de la entrada');
            e.monto := random(1000);
            writeln(e.monto);
            writeln('----');
        end;
    end;

    procedure inicializarvec(var v:vec);
    var
        i:dias;
    begin
        for i:=1 to dimf do begin
            v[i]:= nil;
        end;
    end;

    procedure insertarordenado(var l:lista; dato: entrada);
    var
        act,ant,nue: lista;
    begin
        new(nue);
        nue^.dato := dato;
        act:=l; ant:=l;
        while (act <> nil) and (nue^.dato.codigo > act^.dato.codigo) do begin
            ant:=act; act:= act^.sig; 
        end;
        if (act = ant) then
            l:=nue
        else
            ant^.sig := nue;
        nue^.sig :=act;
    end;

var
    e:entrada;
begin
    inicializarvec(v);
    leerentrada(e);
    while (e.codigo <> 0) do begin
        insertarordenado(v[e.dia], e);
        leerentrada(e);
    end;
end;


procedure merge (var l:listaAcumuladora; v:vec);

    procedure agregarAtras (var l,ult:listaAcumuladora; cod,vendidas: integer);
    var
        nue:listaAcumuladora;
    begin
        new(nue);
        nue^.dato.cod:=cod;
        nue^.dato.vendidas:=vendidas;
        nue^.sig:=nil;
        if (l=nil) then
            l:=nue
        else 
            ult^.sig:=nue;
        ult:=nue;
    end;

    procedure minimo (var v: vec; var obramin: acumulador);
    var
        indicemin,i: dias;
    begin
        obramin.cod:=valorgrande;
        for i:=1 to dimf do begin
            if (v[i] <> nil) then
                if (v[i]^.dato.codigo <= obramin.cod) then begin
                    indicemin:=i;
                    obramin.cod := v[i]^.dato.codigo;
                end;                    
        end;
        if (obramin.cod <> valorgrande) then
            v[indicemin]:= v[indicemin]^.sig;
    end;

var
    obramin,obract: acumulador;
    ult: listaAcumuladora;

begin
    l:=nil;
    minimo(v, obramin);
    while (obramin.cod <> valorgrande) do begin
        obract.cod := obramin.cod;
        obract.vendidas:=0;
        while (obract.cod = obramin.cod) do begin
            obract.vendidas:=obract.vendidas + 1;
            minimo(v,obramin);
        end;
        agregarAtras(l,ult,obract.cod,obract.vendidas);
    end;
end;

procedure incisoc (l:listaAcumuladora);
begin
    if (l<>nil) then begin
        writeln('Codigo de obra: ', l^.dato.cod);
        writeln('Vendidas: ', l^.dato.vendidas);
        incisoc(l^.sig);
    end;
end;

var
    v:vec;
    l:listaAcumuladora;
begin
    cargarv(v);
    writeln('----------------------------------------------');
    merge(l,v);
    incisoc(l);
end.