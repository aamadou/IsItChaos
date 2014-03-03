deff('[Xn]=f(Xn_1,c)','Xn=c*Xn_1*(1-Xn_1)');

x0=0.0001;

c=[3.5:.001:4] ;

orbits=[];

for i=c,

orbit=orb(20000,i,x0,f);

orbits=[orbits;orbit(1,$-999:$)];

end

Kest=[];

C=[];

save('Test_Logidt_Chaos01_orbits_c.dat',orbits,c);

for i=1:size(orbits,1),

[Kesti,Ci]=Chaos01(orbits(i,:)');

C=[C,Ci];

disp(i)

disp(string(round(i/size(orbits,1)*100))+'%')

Kest=[Kest, median(Kesti)];

save('Test_Logidt_Chaos01_Kest_C.dat',Kest,c,C)

end;

plot2d(c,Kest);


