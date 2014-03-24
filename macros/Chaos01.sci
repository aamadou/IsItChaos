function [K,C]=Chaos01(orbit)
 if ~isdef('N','local')...
   then N=2000,
  end; 
 K=[];
 C=[];
 for i=1:100
   CC=[0];
   while CC==[0],
     CC=rand(1,1)*2*%pi;
   end;  
   C=[C CC];
 end;  
 i=0;
 for j=C
       mdelete('tmp') 
       write('tmp',[j;orbit]);
       test=host('Chaos01.exe tmp tmp1');
       if test~=0...
         then 
           disp('l''utilitaire Chaos01 non trouvz');
           break;
         else;
           x=read('tmp1',1,1);  
           K=[K,x(1,1)];
           i=i+1;
//           disp(string(i)+'%');
       end;    
 end;    
// plot2d(C,K)
endfunction; 
 
