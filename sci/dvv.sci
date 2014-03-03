function [DVV,rd]=dvv(orbit,NbrIter, Dim, Delai, nd, N0);

if isdef('NbrIti','local')...
   then NbrIter=size(orbit,2),
 end;
if isdef('Dim','local')...
   then Dim=2,
 end;
if isdef('Delai','local')...
   then Delai=1,
 end;
if isdef('nd','local')...
   then nd=3,
 end;
if isdef('N0','local')...
   then N0=30,
 end;

M=Dim
L=Delai;
x1_x2_x3=Delay_var(orbit,NbrIter+L*M,M,L);
dist=[]
for i=1:NbrIter-1;
  dist=[norm(x1_x2_x3(i,:)-x1_x2_x3(i+1,:),2) dist];
end;
mud=mean(dist)
segd=stdevf(dist,ones(dist))
vartot=variance(orbit)
nd=3
rd=[mud-nd*segd:2*nd*segd/30:mud+nd*segd];
DVV=[]
N0=3;
rdi=[];
for rdi=rd
  omega=[];
  for i=1:NbrIter;
    omegai=[]; 
    for j=1:NbrIter-1;
      if   norm(x1_x2_x3(i,:)-x1_x2_x3(j,:),2)<=rdi then  omegai=[omegai ; x1_x2_x3(j+1,:)]; end;
    end;
    if size(omegai,2) >=N0...
        then 
           v=variance(omegai);
           omega=[v omega];
    end
  end
  if omega ==[]...
    then DVV=[0 DVV]
    else DVV=[mean(omega)./vartot DVV]; 
  end  
end
endfunction
