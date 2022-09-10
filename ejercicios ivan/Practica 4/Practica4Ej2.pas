
{2.	Un cine posee la lista de películas que proyectará durante el mes de octubre. De cada película se conoce: código de película, 
código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) 
y puntaje promedio otorgado por las críticas. Implementar un programa que contenga:
a.	Un módulo que lea los datos de películas y los almacene ordenados por código de película y agrupados por código de género, 
en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de película -1. 
b.	Un módulo que reciba la estructura generada en el punto a y retorne una estructura de datos donde estén todas las películas almacenadas ordenadas por código de película.
}

program practica4ej2;
const dimf= 8; valorgrande=999;
type    
    generos = 1..dimf;

    pelicula = record
        cod: integer;
        genero: generos;
        puntajeprom: integer;
    end;
    
    lista= ^nodo;

    nodo = record
        dato: pelicula;
        sig: lista;
    end;

    vec = array[generos] of lista;

    listaAcumuladora = ^nodoAcumulador;

    nodoAcumulador = record
        dato: pelicula;
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

    procedure leerpelicula (var p:pelicula);
    begin   
        writeln;
        writeln('Inserte codigo de pelicula: ');
        p.cod:= Random (21)-1;
        write(p.cod);
        writeln;
        if (p.cod <> -1) then begin
            writeln('Inserte el genero de la pelicula');
            p.genero:= Random(8)+1;
            write(p.genero);
            writeln;
            writeln('Inserte el puntaje promedio de la pelicula');
            p.puntajeprom:= Random(10)+1;
            writeln(p.puntajeprom);
            writeln;
        end;
    end;

    procedure insertarordenado (var l: lista; p:pelicula);
    var ant, nuevo, act: lista;
    begin
        new (nuevo);
        nuevo^.dato := p;
        act := l;
        {Recorro mientras no se termine la lista y no encuentro la posición correcta}
        while (act <> NIL) and (act^.dato.cod < p.cod) do begin
        ant := act;
        act := act^.sig ;
        end;
        if (act = l)  then l:= nuevo   {el dato va al principio}
                    else ant^.sig  := nuevo; {va entre otros dos o al final}
        nuevo^.sig := act ;
    end;

var 
    p: pelicula;
begin
    inicializarvec(v);
    leerpelicula(p);
    while (p.cod<>-1) do begin
        insertarordenado(v[p.genero],p);
        writeln;
        leerpelicula(p);
    end;
end;


procedure AgregarAtras (var l, ult: listaAcumuladora; p: pelicula); 
var  nuevo: listaAcumuladora;
begin 
 new (nuevo); nuevo^.dato:= p; nuevo^.sig := nil;
 if (l = nil) then l:= nuevo
              else ult^.sig := nuevo;
 ult := nuevo;
end;

procedure minimo (v: vec; var peliculamin: pelicula);
var 
    indiceMin,i: generos;
begin
  peliculamin.cod:= valorGrande;
  for i:= 1 to dimF do
  begin
    if (v[i] <> nil) 
    then if (v [i]^.dato.cod <= peliculamin.cod) 
        then begin
                indiceMin:= i;
                peliculamin:= v [i]^.dato;  
              end; 
  end;
  if (peliculamin.cod <> valorGrande) 
  then v[indiceMin]:= v[indiceMin]^.sig;
end;

procedure merge(v:vec; var l: listaAcumuladora);
var
    ult: listaAcumuladora;
    peliculamin: pelicula;
begin
    l:=nil;
    minimo(v,peliculamin);
    while (peliculamin.cod <> valorgrande) do begin
        agregarAtras(l,ult,peliculamin);
        minimo(v,peliculamin);
    end;
end;

procedure ImprimirEstructuraMergeAcumulador (l: listaAcumuladora);

  procedure imprimirListaAcumulador (l: listaAcumuladora);
  begin
     if (l <> nil) then 
     begin
        writeln('      Codigo: ', l^.dato.cod, '  Genero: ', l^.dato.genero);
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
        writeln('      Codigo: ', l^.dato.cod, '  Genero: ', l^.dato.genero);
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
