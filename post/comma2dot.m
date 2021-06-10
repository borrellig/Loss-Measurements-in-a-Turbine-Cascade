clear all
clc

data = fileread('measurement result 2020-11-27 16.30.28.txt');
data = strrep(data, ',', '.');
FID = fopen('30_neg_deg_rough.txt', 'w');
fwrite(FID, data,'char');
fclose(FID);
