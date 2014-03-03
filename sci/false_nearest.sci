function   [dim,FalseNberFrac,NberSize,NberSize2]=false_nearest(orbit,NbrIti,Dim,Delai, RatRef, MaxDim, TheWin)

// Initialisation
Commandline='';
NbrComp=size(orbit,2);
if ~isdef('DoEstim','local')...
   then DoEstim=%F,
 end;
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -l'+string(NbrIti),
 end;
if isdef('MaxDim','local')...
   then Commandline=Commandline+' -M'+string(NbrComp)+','+string(MaxDim),
   else Commandline=Commandline+' -M'+string(NbrComp)+','+string(Dim),
 end;
if isdef('Dim','local')...
   then Commandline=Commandline+' -m'+string(Dim),
 end;
if isdef('MinEps','local')...
   then Commandline=Commandline+' -r'+string(MinEps),
 end;
if isdef('RatRef','local')...
   then Commandline=Commandline+' -f'+string(RatRef),
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
       mdelete('tmp') 
       write('tmp',string(orbit)),
       Commandline=' tmp'+Commandline+' -c'+string(NbrComp)+' -otmpout.dat',
 end;
mdelete('tmpout.dat') 
Commandline='false_nearest'+Commandline, 

//  Reading the output
x=host(Commandline);
if x~=0...
  then 
     disp('Erreur!!! Fichier ou Tisean manquant');
     return;
end;     

x=read('tmpout.dat',-1,1,'(a)');
x=evstr(x);
dim=x(:,1);
FalseNberFrac=x(:,2);
NberSize=x(:,3);
NberSize2=x(:,4);

endfunction

