function [FixedPoint]=RateOfConvergence(Maps,InitialSeed)

 
  for i=1:sizeof(Maps,1)
    orbit=orb(InitialSeed(1,1),Maps(i).c)
  end;  
endfunction;    

