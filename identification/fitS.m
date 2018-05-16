xtemp=kk;

khandle=@(x)fitStiff(x,Def,F,false);
kplot=@(x)fitStiff(x,Def,F,true);

kk=fminsearch(@(x)khandle(x),xtemp,options);