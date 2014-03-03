function   [x]=d2(orbit,NbrIti,Dim,Delai, NbrEps, TheWin, MaxLenSca, MinLenSca)

// Initialisation
Commandline='';
NbrComp=size(orbit,2);
if ~isdef('DoEstim','local')...
   then DoEstim=%F,
 end;
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -l'+string(NbrIti),
 end;
if isdef('Dim','local')...
   then Commandline=Commandline+' -M'+string(NbrComp)+','+string(Dim),
 end;
if isdef('NbrPair','local')...
   then Commandline=Commandline+' -N'+string(NbrPair),
 end;
if isdef('NbrEps','local')...
   then Commandline=Commandline+' -#'+string(NbrEps),
 end;
if isdef('MaxLenSca','local')...
   then Commandline=Commandline+' -R'+string(MaxLenSca),
 end;
if isdef('MinLenSca','local')...
   then Commandline=Commandline+' -r'+string(MinLenSca),
 end;
if isdef('TheWin','local')...
   then Commandline=Commandline+' -t'+string(TheWin),
 end;
if isdef('Delai','local')...
   then Commandline=Commandline+' -d'+string(Delai),
 end;

//  Utilisation de Lyap_K from TiSeAn
if isdef('orbit','local')...
   then
       mdelete('tmpin') ;
       mdelete('tmp.c2') ;
       mdelete('tmp.d2') ;
       mdelete('tmp.h2') ;
       mdelete('tmp.stat') ;
       write('tmpin',string(orbit)),
       Commandline=' tmpin'+Commandline+' -c'+string(NbrComp)+' -otmp',
 end;
Commandline='d2'+Commandline, 

//  Reading the output
x=host(Commandline);
if x~=0...
  then 
     disp('Erreur!!! Fichier ou Tisean manquant');
     return;
end;     

x=read('tmp.d2',-1,1,'(a)');
y=[];
for i=1:size(x,1) do
  if length(x(i))>3...
    then 
      y=[x(i);y]; 
   end;
end;
x=y;
carct=[];
for i=1:size(x,1) do
  carct=[carct  '#'];
 end; 
ix=grep(x',carct);
indexelem=ix;
x=strsubst(x,'#center= ','0 ');  
x=strsubst(x,'#dim= ','0 ');
x=evstr(x);
y=[];
col=2;
for i=1:size(x,1);
  if x(i,1)~=0 then y=[x(i,1) x(i,2); y], end;
end;
x=y;

endfunction

