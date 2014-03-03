function [dat,Anot]=ReadMITdata(FileName,Antr,StopTime);
dat=[];
Anot=[];
if isdef('FileName','local')...
   then
       mdelete('tmp.ahm') ,
   else 
       disp('Nom de fichier monquant!!!'),
       abort,
 end;
if ~isdef('Antr','local')...
   then
       Antr='atr' ,
 end;
if isdef('StopTime','local')...
   then
     StopTime=' -t '+StopTime,
   else
     StopTime='',
 end;
 
 Commandline='rdsamp -r '+FileName+StopTime+' -p > temp.ahm',
 test=host(Commandline);
 if test~=0...
     then
       disp('fichier de données ou executable non trouvé!!!'),
     else  
       dat=fscanfMat('temp.ahm');
 end;

 mdelete('tmp.ahm') ,
 Commandline='rdann -r '+FileName+' -a '+Antr+StopTime+' -x > temp.ahm',
 test=host(Commandline);
 if test~=0...
     then
       disp('fichier d''annotation ou executable non trouvé!!!'),
     else
       x=read('temp.ahm',-1,1,'(a)'),
       BeatsSec = evstr(part(x,1:10)),
       BeatsMin = evstr(part(x,11:19)),
       BeatsHrs = evstr(part(x,20:30)),
       BeatsType = part(x,35),
       Anot=tlist(['Annotaion';'BeatsSec';'BeatsMin';'BeatsHrs';'BeatsType'],BeatsSec,BeatsMin,BeatsHrs,BeatsType),
 end;
endfunction
