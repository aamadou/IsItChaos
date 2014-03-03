function   [x]=surrogates(orbit,NbrIti,ExactSpect,Grain)

// Initialisation
Commandline='';
NbrComp=size(orbit,2);
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -i'+string(NbrIti),
 end;
if isdef('NbSurr','local')...
   then Commandline=Commandline+' -n'+string(NbSurr),
 end;
if isdef('CrossDirect','local')...
   then Commandline=Commandline+' -C'+string(CrossDirect),
 end;
if isdef('ExactSpect','local')...
   then Commandline=Commandline+' -s',
 end;
if isdef('Grain','local')...
   then Commandline=Commandline+' -I'+string(Grain),
 end;
//  Utilisation de Lyap_K from TiSeAn
if isdef('orbit','local')...
   then
       mdelete('tmp') 
       write('tmp',string(orbit)),
       Commandline=' tmp'+Commandline+' -c'+string(NbrComp)+' -otmpout.dat',
 end;
mdelete('tmpout.dat') 
Commandline='surrogates'+Commandline, 

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

