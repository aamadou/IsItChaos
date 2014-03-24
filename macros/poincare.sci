function   [x]=poincare(orbit,NbrIti,Dim,Delai, CrossDirect, CrossAxe, Crosspos)

// Initialisation
Commandline='';
NbrComp=size(orbit,2);
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -l'+string(NbrIti),
 end;
if isdef('Dim','local')...
   then Commandline=Commandline+' -m'+string(Dim),
 end;
if isdef('CrossDirect','local')...
   then Commandline=Commandline+' -C'+string(CrossDirect),
 end;
if isdef('Delai','local')...
   then Commandline=Commandline+' -d'+string(Delai),
 end;
if isdef('CrossAxe','local')...
   then Commandline=Commandline+' -q'+string(CrossAxe),
 end;
if isdef('Crosspos','local')...
   then Commandline=Commandline+' -a'+string(Crosspos),
 end;
//  Utilisation de Lyap_K from TiSeAn
if isdef('orbit','local')...
   then
       mdelete('tmp') 
       write('tmp',string(orbit)),
       Commandline=' tmp'+Commandline+' -c'+string(NbrComp)+' -otmpout.dat',
 end;
mdelete('tmpout.dat') 
Commandline='poincare'+Commandline, 

//  Reading the output
x=host(Commandline);
if x~=0...
  then 
     disp('Erreur!!! Fichier ou Tisean manquant');
     return;
end;     

x=read('tmpout.dat',-1,1,'(a)');
x=evstr(x);

endfunction

