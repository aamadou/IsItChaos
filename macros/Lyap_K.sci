function   [NmrIti,L,Lest,err,Nbrelem,Indexelem]=Lyap_K(orbit,NbrIti,Dim,Delai,MinEps, NbrRef, NbrTimeIti, DoEstim, MaxDim, TheWin)

// Initialisation
Commandline='';
Lest=[];
err=[];
NmrIti=[];
L=[];
if ~isdef('DoEstim','local')...
   then DoEstim=%F,
 end;
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -l'+string(NbrIti),
 end;
if isdef('MaxDim','local')...
   then Commandline=Commandline+' -M'+string(MaxDim),
   else Commandline=Commandline+' -M'+string(Dim),
 end;
if isdef('Dim','local')...
   then Commandline=Commandline+' -m'+string(Dim),
 end;
if isdef('MinEps','local')...
   then Commandline=Commandline+' -r'+string(MinEps),
 end;
if isdef('NbrRef','local')...
   then Commandline=Commandline+' -n'+string(NbrRef),
 end;
if isdef('NbrTimeIti','local')...
   then Commandline=Commandline+' -s'+string(NbrTimeIti),
   else NbrTimeIti=50;
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
       Commandline=' tmp'+Commandline+' -otmpout.dat',
 end;
mdelete('tmpout.dat') 
Commandline='lyap_k'+Commandline, 

//  Reading the output
x=host(Commandline);
if x~=0...
  then 
     disp('Erreur!!! Fichier ou Tisean manquant');
     return;
end;     

x=read('tmpout.dat',-1,1,'(a)');
y=[];
for i=1:size(x,1) do
  if length(x(i))>3...
    then 
      y=[y,x(i)]; 
   end;
end;
x=y;
carct=[];
for i=1:size(x,1) do
  carct=[carct  '#'];
 end; 
ix=grep(x',carct);
indexelem=ix;
x=strsubst(x,'#epsilon= ','');  
x=strsubst(x,'dim= ',' 0 ');
x=evstr(x');
NmrIti=x(:,1),
L=x(:,2),
Nbrelem=x(:,3),

//  Estimating the slopes
ix=[ix size(x,1)+1];
deff('y=FF(x)','y=a*x+b'),
deff('e=G(p,z)','a=p(1),b=p(2),y=z(1),x=z(2),e=y-FF(x)'),
if DoEstim==%T...
 then
  for i=1:size(ix,2)-1 do
    NmrItii=x(ix(1,i)+1:ix(1,i+1)-1,1),
    Li=x(ix(1,i)+1:ix(1,i+1)-1,2),
    aest=[],
    eest=[],
    if (NmrItii~=[])&(size(NmrItii,1)>8)...
     then 
      for j=4:size(Li,1)/2+1 do
        xx=NmrItii(1:j)',
        yy=Li(1:j)',
        Z=[yy;xx]
        [p,e]=fit_dat(G,[0;0],Z),
        if (e<.01)...
          then
            aest=[aest,p(1)],
            eest=[eest,e],
         end
       end;
      if aest~=[]...
         then
           z=min(aest),
         else
           z=-1
      end;     
      if z>0...
         then
            [err1,k]=min(eest),
            err=[err err1];
            Lest=[Lest aest(k)],
         else
            Lest=[Lest 0];
            err=[err -1];
       end;    
     else
      Lest=[Lest 0];
      err=[err -1];
    end;   
  end; 
 end; 
  
endfunction

