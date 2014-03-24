function xn=FDouble(xn_1,c)
  z=xn_1
  if (z(1,1).num>=0)&(z(1,1).num*2<z(1,1).den)
     xn(1,1)=z(1,1)*2
  end;
  if (z(1,1).num*2>=z(1,1).den)&(z(1,1).num<z(1,1).den)
     xn(1,1)=z(1,1)*2-1
  end;
endfunction; 
    
