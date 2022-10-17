%% 加入高斯噪声
clear all
clc
img = importdata('I:\Image degradation to classification\code\degradation_data\PaviaU\PaviaU.mat');
I = NormalizeData(img); %归一化
%%%%%%%%%%%%%%%%mean_rate%%%%%%%%%%%%%%%%%%%%

DATA_NAME = 'PaviaU';
[m,n,p]= size(I);
S = zeros(m,n,p);
LEVEL = [1,0.81,0.64,0.49,0.36,0.25,0.16];
LEVEL_NAME = {'0_81' '0_64' '0_49' '0_36' '0_25' '0_16'};
for i = 2:7
    level1 = LEVEL(i-1);
    level2 = LEVEL(i);
   
    for k = 1:10
         V = (level2-level1)*rand+level1;%随机数
        img1 = imresize(I, V, 'bicubic');
        S = imresize(img1, [m n], 'bicubic');%对图像上下采样
%         S = NormalizeData(S);
        filename_mat = strcat(DATA_NAME,'_blur',char(LEVEL_NAME(i-1)),'_',num2str(k),'.mat');
        filename_pic = strcat(DATA_NAME,'_blur',char(LEVEL_NAME(i-1)),'_',num2str(k),'.png');
        save(filename_mat, 'S');
    %     figure,imshow(S(:,:,[79 38 19])) %显示加高斯后的图像
        % % Fsrc=imadjust(F(:,:,[29 19 12]),stretchlim(F(:,:,[29 19 12]),[0.01 0.99]),[]);
        % % figure,imshow(Fsrc) %
%         imwrite(S(:,:,[29 19 12]),filename_pic); 
        imwrite(S(:,:,[59 38 20]),filename_pic); 
    end
end