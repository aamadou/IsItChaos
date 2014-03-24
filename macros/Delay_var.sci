function   DV=Delay_var(orbit,NbrIti,Dim,Delai)
Commandline='';
if isdef('NbrIti','local')...
   then Commandline=Commandline+' -l'+string(NbrIti),
 end;
if isdef('Dim','local')...
   then Commandline=Commandline+' -m'+string(Dim),
 end;
if isdef('Delai','local')...
   then Commandline=Commandline+' -d'+string(Delai),
 end;
 
if isdef('orbit','local')...
   then
       mdelete('tmp')
       mdelete('tmp.del') 
       write('tmp',string(orbit)),
       Commandline=' tmp'+Commandline,
 end;
Commandline='delay'+Commandline+' -otmp.del',
test=host(Commandline);
if test~=0...
   then 
      disp('l''utilitaire Delay non trouvé');
   else   
      orbit=read('tmp.del',-1,1,'(a)'),   
      //orbit=strsubst(orbit,'1.#INF','10e308');
      DV=evstr(orbit);
end;    
endfunction

