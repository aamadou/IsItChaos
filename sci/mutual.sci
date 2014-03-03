function   [Del,MutulaInf,OccupBox,ShanEnt]=mutual(orbit,NbrIti,Delai, NbrBox)

// Initialisation
Commandline='';
NbrComp=size(orbit,2);
if ~isdef('DoEstim','local')...
   then DoEstim=%F,
 end;
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -l'+string(NbrIti),
 end;
if isdef('NbrBox','local')...
   then Commandline=Commandline+' -b'+string(NbrBox),
 end;
if isdef('Delai','local')...
   then Commandline=Commandline+' -D'+string(Delai),
 end;

//  Utilisation de Lyap_K from TiSeAn
if isdef('orbit','local')...
   then
       mdelete('tmp') 
       write('tmp',string(orbit)),
       Commandline=' tmp'+Commandline+' -c'+string(NbrComp)+' -otmpout.dat',
 end;
mdelete('tmpout.dat') 
Commandline='mutual'+Commandline, 

//  Reading the output
x=host(Commandline);
if x~=0...
  then 
     disp('Erreur!!! Fichier ou Tisean manquant');
     return;
end;     

x=read('tmpout.dat',-1,1,'(a)');
y=x(3:$);
y=evstr(y);
Del=y(:,1);
MutulaInf=y(:,2);
OccupBox=(x(1,1));
ShanEnt=(x(2,1));

endfunction

