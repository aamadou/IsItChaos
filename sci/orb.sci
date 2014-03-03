function [orbit]=orb(NbrItir,c,x0,f,RatCalc,DoPlot)
 if ~isdef('DoPlot','local')...  
  then DoPlot=%F,
  end;
 if ~isdef('NbrItir','local')...  
  then NbrItir=1000,
  end;
 if ~isdef('c','local')...
  then c=0,
  end;
 orbit=[]
 x=[]
 if ~isdef('RatCalc','local')...
  then
    if ~isdef('f','local')...
      then  deff('[Xn]=f(Xn_1,c)','Xn=Xn_1^2+c')
      end;
    if ~isdef('x0','local')...  
      then x0=[0]
      end;
    for i=1:size(x0,2)
      x=[x0(1,i)]
      for j=1:NbrItir        
        x=[x f(x(1,j),c)]
      end
      orbit=[orbit;x]
    end
    if DoPlot...
      then
        clf
        plot2d(x0,orbit(:,$-100:$),-1*ones(1:size(orbit(:,$-100:$),2)))
        xtitle('Paramaère='+string(c))
      end 
  else
    if ~isdef('f','local')...
      then  deff('[xn]=f(xn_1,c)'...
                 ,'z=xn_1;...
                   if (horner(z(1,1).num,1)>=0)&(horner(z(1,1).num,1)*2<horner(z(1,1).den,1))...
                      xn(1,1)=z(1,1)*2;...
                   end;...
                   if (horner(z(1,1).num,1)*2>=horner(z(1,1).den,1))&(horner(z(1,1).num,1)<horner(z(1,1).den,1))...
                      xn(1,1)=z(1,1)*2-1;...
                   end;')
      end,
    if ~isdef('x0','local')...  
      then
         xnum=poly(1,'s',['coeff'])
         xnum=(0:9)*xnum
         xden=poly(1,'s',['coeff'])
         xden=ones(0:9)*10*xden
         x0=xnum./xden
      end,
    for i=1:size(x0,2)
      x=[x0(1,i)]
      for j=1:NbrItir
        x=[x f(x(1,j),c)]
      end
      orbit=[orbit;x]
    end
    if DoPlot...
      then
       clf
       plot2d(horner(x0,1),horner(orbit(:,$-100:$),1),-1*ones(1:size(horner(orbit(:,$-100:$),1),2)))
       xtitle('Paramaère='+string(c))
      end 
  end,  
 
endfunction;
