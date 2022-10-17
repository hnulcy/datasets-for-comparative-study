clear all
clc
img = importdata('I:\Image degradation to classification\code\degradation_data\hhk\hhk.mat');
I = NormalizeData(img); %归一化
[m,n,p]= size(I);
haze = importdata('haze7.mat'); %导入雾光谱曲线
haze_map2 = importdata('hazemap.mat'); %导入真实雾浓度


haze_nd = imresize(haze_map2,[m n]); %真实雾浓度矩阵
% haze_nd = imrotate(haze_nd,180);
% haze_nd = flipud(haze_nd);

haze_zero = zeros(1,1,p);%真实雾光谱曲线
for i = 1:p
    haze_zero(:,i) = haze(:,ceil(i/p*size(haze,2)));
end
%%%%%%%%%%%%%%%%mean_rate%%%%%%%%%%%%%%%%%%%%

DATA_NAME = 'PaviaU';
S = zeros(m,n,p);
LEVEL = [0.4,0.6,0.8,1.0,1.2,1.4,1.6];
LEVEL_NAME = {'0_6' '0_8' '1_0' '1_2' '1_4' '1_6'};
for i = 2:7
    level1 = LEVEL(i-1);
    level2 = LEVEL(i);

    for k = 1:10 
        r = (level1-level2)*rand+level2;
        S = I + r*haze_zero.*haze_nd;
        filename_mat = strcat(DATA_NAME,'_haze',char(LEVEL_NAME(i-1)),'_',num2str(k),'.mat');
        filename_pic = strcat(DATA_NAME,'_haze',char(LEVEL_NAME(i-1)),'_',num2str(k),'.png');
        save(filename_mat, 'S');
    %     figure,imshow(S(:,:,[79 38 19])) %显示加高斯后的图像
        % % Fsrc=imadjust(F(:,:,[29 19 12]),stretchlim(F(:,:,[29 19 12]),[0.01 0.99]),[]);
        % % figure,imshow(Fsrc) %
        imwrite(S(:,:,[29 19 12]),filename_pic); 
    end
end