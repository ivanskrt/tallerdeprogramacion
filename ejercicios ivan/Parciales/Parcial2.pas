{Una cadena de gimnasios que tiene 5 sucursales necesita procesar las asistencias de los clientes.
Implementar un programa en Pascal con:
a) Un módulo que lea la información de las asistencias realizadas en cada sucursal y que genere
un árbol ordenado por dni de cliente, donde cada nodo contenga dni de cliente, còdigo y la
cantidad total de minutos asistidos en todas las sucursales. De cada asistencia se lee: código
de sucursal (1..5), dni del cliente, código del cliente, fecha y cantidad de minutos que asistió. La
lectura finaliza con el dni de cliente -1, el cual no se procesa.
b) Un módulo que reciba el árbol generado en a) y un dni de cliente y devuelva una lista con los
dni de los clientes cuyo dni es mayor al dni ingresado y el total de minutos es impar.}

program Parcial2;
const
    dimf = 5;
type
    rango = 1..5;

    asistencia = record
        sucursal: rango;
        dni: integer;
        codigo: integer;
        fecha: integer;
        minutos: integer;
    end;

    lista = ^nodo;

    nodo = record
        dato: asistencia;
        sig: lista;
    end;

    vec = array[rango] of lista;

    cliente = record
        dni,cod,minutostotal: integer;
    end;

    arbol = ^nodoarbol;

    nodoarbol = record
        dato: cliente;
        HI: arbol;
        HD: arbol;
    end;

    nuevo = record
        dni,minutos: integer;
    end;

    listanueva = ^nodonuevo;

    nodonuevo = record
        dato: nuevo;
        sig:listanueva;
    end;


procedure cargarvyarbol(var v:vec; var a:arbol);

    procedure leerasistencia (var a: asistencia);
    begin
        writeln('Ingrese el dni del asistidor');
        a.dni:= random(20)-1;
        writeln(a.dni);
        if (a.dni <> -1) then begin
            writeln('Ingrese la sucursal a la que asistio');
            a.sucursal:=random(5)+1;
            writeln(a.sucursal);
            writeln('Ingrese el codigo de cliente');
            a.codigo := random(100)+1;
            writeln(a.codigo);
            writeln('Ingrese la fecha en la que asistio');
            a.fecha := random(100)+1;
            writeln(a.fecha);
            writeln('Ingrese los minutos que duro la asistencia');
            a.minutos := random(60)+1;
            writeln(a.minutos);
            writeln('--');
        end;
    end;

    procedure inicializarvec (var v:vec);
    var
        i:integer;
    begin
        for i:=1 to dimf do begin
            v[i]:= nil;
        end;
    end;

    procedure insertarordenado (var l:lista; dato:asistencia);
    var
        nue,ant,act: lista;
    begin
        new(nue);
        nue^.dato:=dato;
        ant:=l; act:=l;
        while (act <> nil) and (dato.dni > act^.dato.dni) do begin
            ant:=act; act:=act^.sig;
        end;
        if (ant = act) then
            l:=nue
        else
            ant^.sig:= nue;
        nue^.sig:= act;
    end;

    procedure insertarenarbol (var a:arbol; dni,cod,minutos:integer);
    begin
        if (a=nil) then begin
            new(a);
            a^.dato.dni:=dni;
            a^.dato.cod:=cod;
            a^.dato.minutostotal:=minutos;
            a^.HI:=NIL;
            a^.HD:=nil;
        end
        else begin
            if (dni > a^.dato.dni) then
                insertarenarbol(a^.HD,dni,cod,minutos)
            else 
                if (dni < a^.dato.dni) then
                    insertarenarbol(a^.HI,dni,cod,minutos)
                else
                    a^.dato.minutostotal := a^.dato.minutostotal + minutos;
        end;
    end;


var
    asis: asistencia;
begin
    inicializarvec(v);
    leerasistencia(asis);
    while (asis.dni<> -1) do begin
        insertarordenado(v[asis.sucursal],asis);
        insertarenarbol(a,asis.dni,asis.codigo,asis.minutos);
        leerasistencia(asis);
    end;
end;

{var
    asis: asistencia;
    dniact: integer;
    i:integer;
begin
    for i:=1 to dimf do begin
		while (v[i] <>nil) do begin
			insertarenarbol(a,v[i]^.dato.dni,v[i]^.dato.codigo,v[i]^.dato.minutos);
			v[i]:= v[i]^.sig;
		end;
	end;
end;
}

procedure incisob (a:arbol; var ln:listanueva);

    procedure agregarAtras( var l,ult: listanueva; dni,minutos: integer);
    var
        nue: listanueva;
    begin
        new(nue);
        nue^.dato.dni:= dni;
        nue^.dato.minutos:= minutos;
        nue^.sig:= nil;
        if (l=nil) then
            l:=nue
        else
            ult^.sig:=nue;
        ult:=nue;
    end;

    procedure recorrerarbol (a:arbol; var ln,ult: listanueva; dni: integer);
    begin
        if (a<>nil) then begin
            if (a^.dato.dni > dni) then begin
                recorrerarbol(a^.HI,ln,ult,dni);
                if (a^.dato.minutostotal mod 2 <> 0) then
                    agregarAtras(ln,ult,a^.dato.dni,a^.dato.minutostotal);
            end;
            recorrerarbol(a^.HD,ln,ult,dni);
        end;
    end;

var
    ult: listanueva;
    dni:integer;
begin
    writeln('Inserte a que dni deben ser mayores los dnis insertados en la lista');
    readln(dni);
    recorrerarbol(a,ln,ult,dni);
end;

procedure imprimirarbol(a:arbol);
begin
    if(a<>nil) then begin
        imprimirarbol(a^.HI);
        writeln('DNI: ',a^.dato.dni);
        writeln('Minutos totales: ',a^.dato.minutostotal);
        imprimirarbol(a^.HD);
    end;
end;

procedure imprimirlista (l: listanueva);
begin
    while (l<>nil) do begin
        writeln('DNI: ',l^.dato.dni);
        writeln('Minutos totales: ',l^.dato.minutos);
        l:=l^.sig;
    end;
end;

var
    a:arbol;
    v:vec;
    ln: listanueva;
begin
    cargarvyarbol(v,a);
    writeln('------------------------------------');
    imprimirarbol(a);
    writeln('------------------------------------');
    incisob(a,ln);
    writeln('-----------------------------------');
    imprimirlista(ln);
end.
