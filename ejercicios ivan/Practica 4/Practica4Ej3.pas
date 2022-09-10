{3.	Implementar un programa que procese la información de las ventas de productos de una librería que tiene 4 sucursales. 
De cada venta se lee fecha de venta, código del producto vendido, código de sucursal y cantidad vendida. El ingreso de las ventas 
finaliza cuando se lee el código de sucursal 0. Implementar un programa que:
a.	Almacene las ventas ordenadas por código de producto y agrupados por sucursal, en una estructura de datos adecuada.
b.	Contenga un módulo que reciba la estructura generada en el punto a y retorne una estructura donde esté acumulada la cantidad total vendida para cada código de producto.
}

program Practica4ej3;
const valorgrande = 9999; dimf=4;
type
    rango= 1..dimf;

    venta = record
        fecha: integer;
        codproducto: integer;
        codsucursal: rango;
        cantvendida: integer;
    end;

    lista= ^nodo;

    nodo = record   
        dato: venta;
        sig: lista;
    end;

    vec = array[rango] of lista;

    totalvendidos = record
        cod: integer;
        cant: integer;
    end;

    listaAcumuladora = ^nodoAcumulador;

    nodoAcumulador = record
        dato: totalvendidos;
        sig: listaAcumuladora;
    end;


procedure cargarvector (var v:vec);

    procedure inicializarvec (var v:vec);
    var 
        i:integer;
    begin
        for i:=1 to dimf do begin
            v[i]:=nil;
        end;
    end;

    procedure leerventa (var ve: venta);
    begin   
        writeln;
        writeln('Inserte codigo de sucursal: ');
        readln(ve.codsucursal);
        writeln;
        if (ve.codsucursal <> 0) then begin
            writeln('Inserte la fecha de la venta');
            ve.fecha:= Random(30)+1;
            write(ve.fecha);
            writeln;
            writeln('Inserte el codigo de producto');
            ve.codproducto:= Random(20)+1;
            writeln(ve.codproducto);
            writeln;
            writeln('Inserte la cantidad vendida');
            ve.cantvendida:= Random(100)+1;
            writeln(ve.cantvendida);
        end;
    end;

    procedure insertarordenado (var l: lista; ve: venta);
    var ant, nuevo, act: lista;
    begin
        new (nuevo);
        nuevo^.dato := ve;
        act := l;
        {Recorro mientras no se termine la lista y no encuentro la posición correcta}
        while (act <> NIL) and (act^.dato.codproducto < ve.codproducto) do begin
        ant := act;
        act := act^.sig ;
        end;
        if (act = l)  then l:= nuevo   {el dato va al principio}
                    else ant^.sig  := nuevo; {va entre otros dos o al final}
        nuevo^.sig := act ;
    end;

var 
    ve: venta;
begin
    inicializarvec(v);
    leerventa(ve);
    while (ve.codsucursal <> 0) do begin
        insertarordenado(v[ve.codsucursal],ve);
        writeln;
        leerventa(ve);
    end;
end;

procedure AgregarAtras (var l, ult: listaAcumuladora; ve: totalvendidos); 
var  nuevo: listaAcumuladora;
begin 
 new (nuevo); nuevo^.dato:= ve; nuevo^.sig := nil;
 if (l = nil) then l:= nuevo
              else ult^.sig := nuevo;
 ult := nuevo;
end;

procedure minimo (v: vec; var vemin: totalvendidos);
var 
    indiceMin,i: rango;
begin
  vemin.cod:= valorGrande;
  for i:= 1 to dimF do
  begin
    if (v[i] <> nil) 
    then if (v[i]^.dato.codproducto <= vemin.cod) 
        then begin
                indiceMin:= i;
                vemin.cod:= v[i]^.dato.codproducto;
                vemin.cant:= v[i]^.dato.cantvendida;  
              end; 
  end;
  if (vemin.cod <> valorGrande) 
  then v[indiceMin]:= v[indiceMin]^.sig;
end;

procedure merge(v:vec; var l: listaAcumuladora);
var
    ult: listaAcumuladora;
    veact,vemin: totalvendidos;
    cantact: integer;
begin
    l:=nil;
    minimo(v,vemin);
    while (vemin.cod <> valorgrande) do begin
        veact.cod := vemin.cod; veact.cant:=vemin.cant;
        while (veact.cod = vemin.cod) do begin
            veact.cant := veact.cant + vemin.cant;
            minimo(v,vemin);
        end;
        agregarAtras(l,ult,veact);
    end;
end;


procedure ImprimirEstructuraMergeAcumulador (l: listaAcumuladora);

  procedure imprimirListaAcumulador (l: listaAcumuladora);
  begin
     if (l <> nil) then 
     begin
        writeln('      Codigo: ', l^.dato.cod, '  cantidad: ', l^.dato.cant);
        imprimirListaAcumulador (l^.sig);
     end;
  end;
  
begin
  writeln;
  writeln ('----- Estructura merge acumulador ----->');
  writeln;
  if (l = nil ) 
     then writeln ('      Sin elementos')
     else imprimirListaAcumulador (l);
end;

procedure imprimirLista(l: lista);
  begin
     if (l <> nil) then 
     begin
        writeln('      Codigo: ', l^.dato.codproducto, '  cantidad: ', l^.dato.cantvendida);
        imprimirLista (l^.sig);
     end;
  end;

procedure ImprimirVectorListas (v: vec);
var i: integer;
begin
  writeln;
  writeln ('----- Vector de listas ----->');
  writeln;
  for i:= 1 to dimF do
  begin
     writeln;
     writeln ('Mes ', i);
     if (v[i] = nil ) 
     then writeln ('      Sin elementos')
     else imprimirLista (v[i]);
  end;
end;

var
    v:vec;
    l: listaAcumuladora;
begin
    randomize;
    cargarvector(v);
    writeln('----------------------------------------------------------------');
    ImprimirVectorListas(v);
    merge(v,l);
    writeln('----------------------------------------------------------------');
    ImprimirEstructuraMergeAcumulador(l);
end.