function   [NmrIti,L,Lest,err]=Lyap_R(orbit,NbrIti,Dim,Delai,MinEps, WinOmi, NbrTimeIti,DoEstim);
Commandline='';
Lest=[];
err=[];
if ~isdef('DoEstim','local')...
   then DoEstim=%F,
 end;
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -l'+string(NbrIti),
 end;
if isdef('Dim','local')...
   then Commandline=Commandline+' -m'+string(Dim),
 end;
if isdef('WinOmi','local')...
   then Commandline=Commandline+' -t'+string(WinOmi),
 end;
if isdef('MinEps','local')...
   then Commandline=Commandline+' -r'+string(MinEps),
 end;
if isdef('NbrTimeIti','local')...
   then Commandline=Commandline+' -s'+string(NbrTimeIti),
 end;
if isdef('Delai','local')...
   then Commandline=Commandline+' -d'+string(Delai),
 end;
 
if isdef('orbit','local')...
   then
       mdelete('tmp') 
       write('tmp',string(orbit.')),
       Commandline=' tmp'+Commandline+' -otmpout.dat',
 end;
mdelete('tmpout.dat') 
Commandline='lyap_r'+Commandline, 
x=evstr(unix_g(Commandline));
x=read('tmpout.dat',-1,2);
if (x~=[])&(size(x,1)>8)...
  then
   NmrIti=x(:,1);
   L=x(:,2);
  else
   NmrIti=[0];
   L=[0];
   Lest=[0];
   err=[-1];
   return;
end;   

if DoEstim==%T...
   then
      x=[],
      y=[],
      aest=[],
      eest=[],
      for i=1:size(L,1) do
        x=NmrIti(1:size(L,1)-i+1)',
        y=L(1:size(L,1)-i+1)',
        deff('y=FF(x)','y=a*x+b'),
        deff('e=G(p,z)','a=p(1),b=p(2),y=z(1),x=z(2),e=y-FF(x)'),
        Z=[y;x]
        [p,e]=fit_dat(G,[0;0],Z),
        aest=[aest,p(1)],
        eest=[eest,e],
       end;
      z=min(aest(size(aest,2)/3+1:size(aest,2))),
      if z>0...
         then
            [err,k]=min(eest(size(eest,2)/3+1:size(eest,2))),
            x=aest(size(eest,2)/3+1:size(eest,2));
            Lest=x(k),
         else
            NmrIti=[0];
            L=[0];
            Lest=[0];
            err=[-1];
      end;      
end;    

endfunction;





