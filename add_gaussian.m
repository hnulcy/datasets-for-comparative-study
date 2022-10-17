clear all
clc
img = importdata('I:\Image degradation to classification\code\degradation_data\hhk\hhk.mat');
I = NormalizeData(img); %归一化
%%%%%%%%%%%%%%%%mean_rate%%%%%%%%%%%%%%%%%%%%

DATA_NAME = 'hhk';
[m,n,p]= size(I);
S = zeros(m,n,p);
LEVEL = [0,0.001,0.005,0.01,0.02,0.03,0.04];
LEVEL_NAME = {'0_001' '0_005' '0_01' '0_02' '0_03' '0_04'};
for i = 2:7
    level1 = LEVEL(i-1);
    level2 = LEVEL(i);
    for k = 1:10
        for w = 1:p
            V = (level2-level1)*rand(m,n)+level1;
            S(:,:,w) = imnoise(I(:,:,w),'localvar',V);%对图像逐波段加入高斯噪声
        end
        filename_mat = strcat(DATA_NAME,'_gs',char(LEVEL_NAME(i-1)),'_',num2str(k),'.mat');
        filename_pic = strcat(DATA_NAME,'_gs',char(LEVEL_NAME(i-1)),'_',num2str(k),'.png');
        save(filename_mat, 'S');
    %     figure,imshow(S(:,:,[79 38 19])) %显示加高斯后的图像
        % % Fsrc=imadjust(F(:,:,[29 19 12]),stretchlim(F(:,:,[29 19 12]),[0.01 0.99]),[]);
        % % figure,imshow(Fsrc) %
        imwrite(S(:,:,[29 19 12]),filename_pic); 
    end
end