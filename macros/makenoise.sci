function   [x]=makenoise(orbit,NoisePerc,NoiseAbs,Gaussian,Creat,Grain)

// Initialisation
Commandline='';
NbrComp=size(orbit,2);
if isdef('NoisePerc','local')...
   then Commandline=Commandline+' -%'+string(NoisePerc),
 end;
if isdef('NoiseAbs','local')...
   then Commandline=Commandline+' -r'+string(NoiseAbs),
 end;
if isdef('Gaussian','local')...
   then Commandline=Commandline+' -g',
 end;
if isdef('Creat','local')...
   then Commandline=Commandline+' -O',
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
Commandline='makenoise'+Commandline, 

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

