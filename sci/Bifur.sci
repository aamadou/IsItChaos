function [orbits]=Bifur(Map,NbrItiCalc,XO,Aini,Afin,Etap,NbrItiGraph)
    orbits=[]
    if ~isdef('Map','local')...
     then
        Map=orb
     end;
    if ~isdef('Aini','local')...  
     then  Aini=0
     end;
    if ~isdef('Afin','local')...  
     then  Afin=-2
     end;
    if ~isdef('Etap','local')...  
     then  Etap=-0.01
     end;
    if ~isdef('NbrItiGraph','local')...  
     then  NbrItiGraph=100
     end;

    A=[Aini:Etap:Afin] 
    for i=A...
          if ~isdef('NbrItiCalc','local')... 
             then if ~isdef('X0','local')...
                      then orbits=[orbits;Map(,i)],
                      else orbits=[orbits;Map(,i,X0)],
                   end,
             else if ~isdef('X0','local')...
                      then orbits=[orbits;Map(NbrItiCalc,i)],
                      else orbits=[orbits;Map(NbrItiCalc,i,X0)],
                   end      
           end  
      end
    clf
    plot2d(A,orbits(:,$-NbrItiGraph:$),0*ones(1:size(orbits(:,$-NbrItiGraph:$),2))) 
endfunction

