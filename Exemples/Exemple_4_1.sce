deff('[Xn]=f(Xn_1,c)','Xn=c*Xn_1*(1-Xn_1)');

x0=0.0001;

c=[3.5:.001:4] ;

orbits=[];

for i=c,

   orbit=orb(20000,i,x0,f);

   orbits=[orbits;orbit(1,$-999:$)];

end

Lest=[];

err=[];

save('Test_Logidt_K_orbits_c.dat',orbits,c);

for i=1:size(orbits,1),

[Nbr,L,Lesti,erri]=Lyap_K(orbits(i,:),,,,,1000,30, %T, 4);

Lesti=mean(Lesti);

erri=mean(erri);

if modulo(i,100)==0 then save('Test_Logidt_K_Lest_err.dat',Lest,err), end;

Lest=[Lest, Lesti];

err=[err, erri];

end;

plot2d(c,Lest);


