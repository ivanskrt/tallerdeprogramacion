program tallerej4;
const dimf = 5;
type    

    vec = array [1..dimf] of integer;

procedure cargarvector (var v:vec; var diml:integer );
begin
    if (diml<=dimf) then begin
        v[diml] := random(100);
        diml:= diml+1;
        cargarvector(v,diml);
    end;
end;

function buscarmaximo(v:vec; i:integer; diml: integer):integer;
var
    max:integer;
begin
    if (i=diml) then begin 
            buscarmaximo:=v[i];
        end
    else  begin 
        max := buscarmaximo(v,i+1,diml);
        if (v[i]>max) then begin
            buscarmaximo:=v[i];
        end
        else begin
            buscarmaximo:=max;
        end;
    end;
end;

function sumarvector(v:vec; i:integer; diml:integer):integer;
begin
    if (i=diml) then 
    begin 
        sumarvector := v[i];
    end   
    else begin
        sumarvector := sumarvector(v,i+1,diml) + v[i];
    end;
end;

procedure escribirvector ( v:vec);
var
    i:integer;
begin
    for i:=1 to dimf do begin
        writeln(v[i]);
    end;
end;

var
    v:vec;
    diml,i: integer;
begin
    diml:=1;
    i:=1;
    cargarvector(v,diml);
    escribirvector(v);
    writeln('--------------------------');
    writeln(buscarmaximo(v,i,diml));
    writeln(sumarvector(v,i,diml));
end.
