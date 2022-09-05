{Escribir un programa que:
a. Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro y: 
    i. Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor. 
    ii. Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. 
    iii. Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor. 
    iv. Aumente en 1 la edad de todos los socios.
    v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
       retorne verdadero o falso.
    vi. Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el nombre lei­do y 
        retorne verdadero o falso.
    vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.
    viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.
    ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
        los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores leÃ­dos y retorne dicha cantidad. 
    x. Informe los numeros de socio en orden creciente. 
    xi. Informe los numeros de socio pares en orden decreciente.
}

Program ImperativoClase3;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record 
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. }

  Procedure LeerSocio (var s: socio);
  begin
    write ('Ingrese numero del socio: ');
    readln (s.numero);
    If (s.numero <> 0)
    then begin
           write ('Ingrese nombre del socio: ');
           readln (s.nombre);
           write ('Ingrese edad del socio: ');
           readln (s.edad);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 a:= nil;
 LeerSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   writeln;
   LeerSocio (unSocio);
  end;
end;

procedure InformarNumeroSocioMasGrande (a: arbol);
{Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor.}

  function NumeroMasGrande (a: arbol): integer;
  begin
    if (a = nil) then NumeroMasGrande:= -1
    else if (a^.HD = nil) then NumeroMasGrande:= a^.dato.numero
                          else NumeroMasGrande:= NumeroMasGrande (a^.HD);
  end;
   
var max: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Mas Grande ----->');
  writeln;
  max:= NumeroMasGrande (a);
  if (max = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio mas grande: ', max);
         writeln;
       end;
end;

procedure InformarDatosSocioNumeroMasChico (a: arbol);
{ Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. }
  
  function SocioMasChico (a: arbol): arbol;
  begin
    if ((a = nil) or (a^.HI = nil))
    then SocioMasChico:= a
    else SocioMasChico:= SocioMasChico (a^.HI);
  end;
   
var minSocio: arbol;
begin
  writeln;
  writeln ('----- Informar Datos Socio Numero Mas Chico ----->');
  writeln;
  minSocio:= SocioMasChico (a);
  if (minSocio = nil) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Socio con numero mas chico: ', minSocio^.dato.numero, ' Nombre: ', minSocio^.dato.nombre, ' Edad: ', minSocio^.dato.edad); 
         writeln;
       end;
end;

procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;
var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
end;

procedure AumentarEdad (a: arbol);
begin
 if (a <> nil)
 then begin
        a^.dato.edad:= a^.dato.edad + 1;
        AumentarEdad (a^.HI);
        AumentarEdad (a^.HD);
      end;
end;

procedure InformarExistenciaNumeroSocio (a: arbol);
{ Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
       retorne verdadero o falso. }
       
  function Buscar (a: arbol; num: integer): boolean;
  begin
    if (a = nil) 
    then Buscar:= false
    else If (a^.dato.numero = num) 
         then Buscar:= true
         else if (num < a^.dato.numero)
              then Buscar:= Buscar (a^.HI, num)
              else Buscar:= Buscar (a^.HD, num)
  end;
  
var numABuscar: integer;
begin
  writeln;
  writeln ('----- Informar Existencia Numero Socio ----->');
  writeln;
  write ('Ingrese numero de socio a buscar: ');
  Readln (numABuscar);
  writeln;
  if (Buscar (a, numABuscar)) 
  then writeln ('El numero ', numABuscar, ' existe')
  else writeln ('El numero ', numABuscar, ' no existe');
  writeln;
end;

procedure InformarExistenciaNombreSocio (a: arbol);
{  Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el nombre lei­do y 
        retorne verdadero o falso.}
       
  function Buscarnombre (a: arbol; nombre: cadena15): boolean;
  begin
    if (a = nil) 
    then Buscarnombre:= false
    else If (a^.dato.nombre = nombre) 
         then Buscarnombre:= true
         else  begin
            Buscarnombre:= Buscarnombre (a^.HI, nombre) or Buscarnombre (a^.HD, nombre);
         end;
  end;
  
var nombreABuscar: cadena15;
begin
  writeln;
  writeln ('----- Informar Existencia Nombre Socio ----->');
  writeln;
  write ('Ingrese nombre de socio a buscar: ');
  Readln (nombreABuscar);
  writeln;
  if (Buscarnombre (a, nombreABuscar)) 
  then writeln ('El nombre ', nombreABuscar, ' existe')
  else writeln ('El nombre ', nombreABuscar, ' no existe');
  writeln;
end;
  
function canttotal(a: arbol): integer;
begin
    if (a = nil) 
    then canttotal:= 0
    else  
        begin
            canttotal:= canttotal (a^.HI) + canttotal (a^.HD) + 1;
         end;
end;  

procedure InformarCantidadSocios(a: arbol);
{vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.}
Begin
    writeln('Cantidad total de socios: ');
    writeln('---------------------------');
    writeln(canttotal(a));
end;

procedure InformarPromedioDeEdad(a:arbol);
{viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.}
     function edadtotal(a:arbol): integer;
     Begin
        if(a = nil) then
            edadtotal:=0
        else
            Begin
                edadtotal := edadtotal (a^.HI) + edadtotal (a^.HD) + a^.dato.edad;
            end;
     end;
Begin
    writeln('La edad promedio de los socios es: ');
    writeln('----------------------------------------');
    writeln(edadtotal(a) div canttotal(a));
end;

{ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
        los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores leidos y retorne dicha cantidad. }
procedure InformarCantidadSociosEnRango (a: arbol);

     function cantentremedio (a:arbol; max,min: integer): integer;
     Begin
        if(a = nil) then
            cantentremedio:= 0
        else begin
            if (a^.dato.numero > min) and (a^.dato.numero < max) then begin
                 cantentremedio := cantentremedio(a^.HI, max,min)  + cantentremedio(a^.HD,max,min) + 1 
            end
            else begin
                if (a^.dato.numero < min) then
                     cantentremedio := cantentremedio (a^.HD,max,min)
                else if (a^.dato.numero > max) then
                     cantentremedio:= cantentremedio(a^.HI,max,min);
            end;
        end;
     end;

    
var
     max,min: integer;
Begin
    writeln('Ingrese el numero mas grande del rango:');
    readln(max);
    writeln('Ingrese el numero mas pequeno del rango');
    readln(min);
    writeln('La cantidad de socios cuyo numero se encuentra entre los valores ingresados es: ');
    writeln(cantentremedio(a,max,min));
end;

{x. Informe los numeros de socio en orden creciente. }
    
procedure recorrerascendente (a:arbol);
Begin
    if (a <> nil) then begin
        recorrerascendente(a^.HI);
        writeln(a^.dato.numero);
        recorrerascendente(a^.HD);
    end;
end;

//xi. Informe los numeros de socio pares en orden decreciente.

procedure recorrerdescendientepar(a:arbol);
Begin
    if (a <> nil) then begin
        recorrerdescendientepar(a^.HD);
        if (a^.dato.numero mod 2 = 0) then
            writeln(a^.dato.numero);
        recorrerdescendientepar(a^.HI);
    end;
end;
      
var a: arbol; 
Begin
  GenerarArbol (a);
  InformarNumeroSocioMasGrande (a);
  InformarDatosSocioNumeroMasChico (a);
  InformarNumeroSocioConMasEdad (a);
  AumentarEdad (a);
  InformarExistenciaNumeroSocio (a);
  InformarExistenciaNombreSocio(a);
  InformarCantidadSocios (a);
  InformarPromedioDeEdad(a);
  InformarCantidadSociosEnRango (a);
  recorrerascendente(a);
  recorrerdescendientepar(a);
  readln;
End.