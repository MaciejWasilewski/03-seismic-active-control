h11=importHarmResp('harmonic_01_01.txt');
h12=importHarmResp('harmonic_01_10.txt');
h13=importHarmResp('harmonic_01_20.txt');
h21=importHarmResp('harmonic_02_01.txt');
h22=importHarmResp('harmonic_02_10.txt');
h23=importHarmResp('harmonic_02_20.txt');
ha1=importHarmResp('harmonic_a_01.txt');
ha2=importHarmResp('harmonic_a_10.txt');
ha3=importHarmResp('harmonic_a_20.txt');

ref=[h11(:,2),h12(:,2),h13(:,2),h21(:,2),h22(:,2),h23(:,2),ha1(:,2),ha2(:,2),ha3(:,2)];

re=[h11(:,4),h12(:,4),h13(:,4),h21(:,4),h22(:,4),h23(:,4),ha1(:,4),ha2(:,4),ha3(:,4)];
im=[h11(:,5),h12(:,5),h13(:,5),h21(:,5),h22(:,5),h23(:,5),ha1(:,5),ha2(:,5),ha3(:,5)];