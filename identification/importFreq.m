% temp=importFreqResp('h_f20_01.csv',3,inf,3);
% freq=temp(:,1);
% reals=zeros(size(freq(:,1),1),20);
% ims=zeros(size(freq(:,1),1),20);
% for i=1:1:9
%     temp=importFreqResp(['h_f20_0',num2str(i),'.csv'],3,inf,3);
%     reals(:,i)=temp(:,2);
%     ims(:,i)=temp(:,3);
% end
% 
% for i=10:1:20
%     temp=importFreqResp(['h_f20_',num2str(i),'.csv'],3,inf,3);
%     reals(:,i)=temp(:,2);
%     ims(:,i)=temp(:,3);
% end
% 
% amplitudes=reals.^2+ims.^2;
% % order: 20 - 1,10,20, a - 1,10,20
% % reals=[re2001,re2010,re2020,rea01,rea10,rea20];
% % ims=[im2001,im2010,im2020,ima01,ima10,ima20];
amps=[];
for i=1:1:20
%     disp(['h_',num2str(i,'%02d'),'_1.csv']);
    hf01temp = importFreqResp(['h_f',num2str(i,'%02d'),'_1.csv'], 1, inf,19);
    hf02temp = importFreqResp(['h_f',num2str(i,'%02d'),'_2.csv'], 1, inf,19);
    hf03temp = importFreqResp(['h_f',num2str(i,'%02d'),'_3.csv'], 1, inf,3);
    hf=[hf01temp,hf02temp,hf03temp];
    amps=[amps,hf(:,2:2:end).^2+hf(:,3:2:end).^2];
end
freq=hf01temp(:,1);