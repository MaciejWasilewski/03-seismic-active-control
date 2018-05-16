function [ ] = waitForFile(dir)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen([dir,'fs.txt'],'r');
formatSpec = '%f';
tempArrray = fscanf(fileID,formatSpec);
fclose(fileID);
% [~,cmdout]=system(['wmic datafile where name="D:\\Program Files\\Ansys\\ANSYS Inc\\v180\\ansys\\bin\\winx64\\', filename,'" get LastModified | findstr /brc:[0-9]']);
% while(str2num(cmdout(10:end-8))==lastDate)
while tempArrray~=1
    %         disp(str2num(cmdout(10:end-8)));
    pause(0.01);
    %     [~,cmdout]=system(['wmic datafile where name="D:\\Program Files\\Ansys\\ANSYS Inc\\v180\\ansys\\bin\\winx64\\', filename,'" get LastModified | findstr /brc:[0-9]']);
    fileID = fopen([dir,'fs.txt'],'r');
    formatSpec = '%f';
    tempArrray = fscanf(fileID,formatSpec);
    fclose(fileID);
end

end

