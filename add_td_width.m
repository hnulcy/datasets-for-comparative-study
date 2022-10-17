clear all
clc
img = importdata('I:\Image degradation to classification\code\degradation_data\Salina\salina188.mat');
I = NormalizeData(img); %归一化
%%%%%%%%%%%%%%%%mean_rate%%%%%%%%%%%%%%%%%%%%

DATA_NAME = 'salina';
[m,n,p]= size(I);
S = zeros(m,n,p);
LEVEL = [0,0.1,0.2,0.4,0.5,0.6,0.8];
LEVEL_NAME = {'0_1' '0_2' '0_4' '0_5' '0_6' '0_8'};
for i = 2:7
    level1 = LEVEL(i-1);
    level2 = LEVEL(i);

    for k = 1:10
        width_rate = (level2-level1)*rand+level1;
        S = NonPeriodical_Simulated_lcy(I,width_rate,0.3);%对图像逐波段加入条带噪声
        filename_mat = strcat(DATA_NAME,'_td_wid',char(LEVEL_NAME(i-1)),'_',num2str(k),'.mat');
        filename_pic = strcat(DATA_NAME,'_td_wid',char(LEVEL_NAME(i-1)),'_',num2str(k),'.png');
        save(filename_mat, 'S');
    %     figure,imshow(S(:,:,[79 38 19])) %显示加高斯后的图像
        % % Fsrc=imadjust(F(:,:,[29 19 12]),stretchlim(F(:,:,[29 19 12]),[0.01 0.99]),[]);
        % % figure,imshow(Fsrc) %
        imwrite(S(:,:,[29 19 12]),filename_pic); 
    end
end