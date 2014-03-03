function   [x]=stp(orbit,NbrIti,Dim,Delai, ResTemps, EtapTemp, EtapFarc)

// Initialisation
Commandline='';
NbrComp=size(orbit,2);
if ~isdef('DoEstim','local')...
   then DoEstim=%F,
 end;
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -l'+string(NbrIti),
 end;
if isdef('EtapTemp','local')...
   then Commandline=Commandline+' -t'+string(EtapTemp),
 end;
if isdef('Dim','local')...
   then Commandline=Commandline+' -m'+string(Dim),
 end;
if isdef('MinEps','local')...
   then Commandline=Commandline+' -r'+string(MinEps),
 end;
if isdef('ResTemps','local')...
   then Commandline=Commandline+' -#'+string(ResTemps),
 end;
if isdef('EtapFarc','local')...
   then Commandline=Commandline+' -%'+string(EtapFarc),
 end;
if isdef('Delai','local')...
   then Commandline=Commandline+' -d'+string(Delai),
 end;

//  Utilisation de Lyap_K from TiSeAn
if isdef('orbit','local')...
   then
       mdelete('tmp') 
       write('tmp',string(orbit)),
       Commandline=' tmp'+Commandline+' -c'+string(NbrComp)+' -otmpout.dat',
 end;
mdelete('tmpout.dat') 
Commandline='stp'+Commandline, 

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

