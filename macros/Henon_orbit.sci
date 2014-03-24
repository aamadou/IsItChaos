function [x,y]=Henon_orbit(NbrIti,A,X0,B,Y0,NbrItTrans)
if ~isdef('NbrIti','local')...
   then NbrIti=1000,
 end;
Commandline='henon -l'+string(NbrIti),
if isdef('A','local')...
   then Commandline=Commandline+' -A'+string(A),
 end;
if isdef('B','local')...
   then Commandline=Commandline+' -B'+string(B),
 end;
if isdef('X0','local')...
   then Commandline=Commandline+' -X'+string(X0),
 end;
if isdef('Y0','local')...
   then Commandline=Commandline+' -Y'+string(Y0),
 end;
if isdef('NbrItTrans','local')...
   then Commandline=Commandline+' -x'+string(NbrItTrans),
 end;
mdelete('tmp.ahm') ,
Commandline=Commandline+' > temp.ahm'; 
test=host(Commandline);
if test~=0...
   then 
      disp('l''utilitaire Henon non trouvé');
   else   
      orbit=read('temp.ahm',-1,1,'(a)'),   
      orbit=strsubst(orbit,'1.#INF','10e308');
      orbit=evstr(orbit),
      x=orbit(:),
      y=orbit(:,2),
      x=x.',
      y=y.',
end;      
endfunction

