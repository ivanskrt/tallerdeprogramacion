
{Se lee información acerca de las ventas de productos realizadas en las 5 sucursales de una empresa.
Cada sucursal realizó a lo sumo 180 ventas. De cada venta se conoce el código de producto, cantidad
vendida y monto total de la venta. Las ventas de cada sucursal se leen de manera consecutiva y
ordenadas por código de producto. La lectura por cada sucursal finaliza al completar las 180 ventas o
cuando se lee el código de producto -1, el cual no se procesa. Implementar un programa para que a
partir de la información leida, resuelva los siguientes ítems: 

a) Utilizando la técnica de merge o merge acumulador según corresponda, generar una lista que
contenga el monto total vendido para cada código de producto, ordenada por código de producto.
b) Realizar un módulo recursivo que reciba la lista generada en el punto a y retorne la cantidad de
productos para los cuales el monto total vendido es inferior a 300.000 pesos. }

program Parcial1;
const
    dimf = 5;
    valorgrande = 9999;
type
    sucursales= 1..dimf;

    venta = record
        cod, cant, monto: integer;
    end;

    lista = ^nodo;

    nodo = record
        dato: venta;
        sig: lista;
    end;

    vec = array[sucursales] of lista;

    total = record
        cod: integer;
        montotal: integer;
    end;


    listaAcumuladora = ^nodoAcumulador;

    nodoAcumulador = record
        dato: total;
        sig: listaAcumuladora;
    end;

procedure cargarv (var v:vec);

    procedure inicializarvec(var v:vec);
    var
        i:integer;
    begin
        for i:=1 to dimf do begin
            v[i]:=nil;
        end;
    end;

    procedure leerventa (var v:venta);
    begin
        writeln('Ingrese el codigo del producto');
        v.cod:=random(10)-1;
        writeln(v.cod);
        if (v.cod <> -1) then begin
            writeln('Ingrese la cantidad vendida');
            v.cant := random(50)+1;
            writeln(v.cant);
            writeln('Ingrese el monto de la venta');
            v.monto:= random(1000)+1;
            writeln(v.monto);
            writeln('----');
        end;
    end;

    procedure agregarAtras (var l,ult: lista; dato:venta);
    var
        nue: lista;
    begin
        new(nue);
        nue^.dato:=dato;
        nue^.sig:=nil;
        if (l=nil) then
            l:=nue
        else
            ult^.sig:=nue;
        ult:=nue;
    end;

var
    ve: venta;
    ult:lista;
    cont,i: integer;
begin
    inicializarvec(v);
    for i:=1 to dimf do begin
        cont:=0;
        leerventa(ve);
        while (ve.cod <> -1) and (cont<180) do begin
            cont:=cont+1;
            agregaratras(v[i],ult,ve);
            leerventa(ve);
        end;
    end;
end;


procedure merge (v:vec; var li:listaAcumuladora);

    procedure agregarAtras (var l,ult: listaAcumuladora; dato: total);
    var
        nue: listaAcumuladora;
    begin
        new(nue);
        nue^.dato:=dato;
        nue^.sig:=nil;
        if (l=nil) then
            l:=nue
        else
            ult^.sig:=nue;
        ult:=nue;
    end;

    procedure minimo (var v:vec; var totalmin: total);
    var
        indicemin, i: sucursales;
    begin
        totalmin.cod:=valorgrande;
        for i:=1 to dimf do begin
            if (v[i] <> nil) then begin
                if (v[i]^.dato.cod <= totalmin.cod) then begin
                    indicemin:=i;
                    totalmin.cod:=v[i]^.dato.cod;
                    totalmin.montotal:=v[i]^.dato.monto;
                end;
            end;
        end;
        if (totalmin.cod <> valorgrande) then
            v[indicemin]:=v[indicemin]^.sig;
    end;

var
    totalmin,totalact: total;
    cant,elemslista: integer;
    ult: listaAcumuladora;
begin
    li:=nil;
    elemslista:=0;
    minimo(v,totalmin);
    while (totalmin.cod <> valorgrande) do begin
        totalact.cod := totalmin.cod;
        cant:=0;
        while (totalmin.cod <> valorgrande) and (totalact.cod = totalmin.cod) do begin
            cant:= cant + totalmin.montotal;
            minimo(v,totalmin);
        end;
        totalact.montotal:=cant;
        agregarAtras(li,ult,totalact);
        elemslista := elemslista +1;
    end;
    writeln(elemslista);
end;

procedure menosde300 (l:listaAcumuladora; var cont: integer);
begin
    if (l<>nil) then begin
        if (l^.dato.montotal < 300000) then
            cont:=cont+1;
        menosde300(l^.sig);
    end;
end;

procedure imprimirlista (l:listaAcumuladora);
begin
    while (l<>nil) do begin
        writeln('Codigo: ',l^.dato.cod);
        writeln('Monto: ',l^.dato.montotal);
        writeln('--');
        l:=l^.sig;
    end;
end;

var
    v:vec;
    li:listaAcumuladora;
    cont:integer;
begin
    cargarv(v);
    merge(v,li);
    writeln('------------------------');
    imprimirlista(li);
    menosde300(li,cont);
    writeln('La cantidad de productos para los cuales el monto total vendido es inferior a 300.000 pesos es de : ',cont);
end.




