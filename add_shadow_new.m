%% 生成模拟阴影图像
img = importdata('I:\Image degradation to classification\code\degradation_data\PaviaU\PaviaU.mat');


t = importdata('I:\Image degradation to classification\dataset\in_shadow\t144.mat');
alpha = importdata('I:\Image degradation to classification\dataset\in_shadow\shadow_alpha1126.mat');
[no_lines no_rows]=size(alpha);
[~, ~, no_bands]=size(img);
I = NormalizeData(img); %归一化
[m n p] = size(I);



alpha_mask = double(imresize(imrotate(alpha,90),[m n]));
alpha_mask(abs(alpha_mask-1)<1e-5) = 1;%经过imresize后的图像有插值，将1.0000都转换为1
% alpha_mask = double(alpha_mask);
t_mask = zeros(1,p);
for i = 1:p
    t_mask(:,i) = t(:,ceil(i/p*144));
end
t_mask = reshape(t_mask,1,1,no_bands);
DATA_NAME = 'salina';

S = zeros(m,n,p);
alpha_mask_temp = zeros(m,n);
LEVEL = [0,0.1,0.2,0.4,0.5,0.6,0.8];
LEVEL_NAME = {'0_1' '0_2' '0_4' '0_5' '0_6' '0_8'};

for i = 2:7
    level1 = LEVEL(i-1);
    level2 = LEVEL(i);

    for k = 1:10
        r_rate = (level2-level1)*rand+level1;
        r_rate = 1-r_rate;

        alpha_mask_temp = double(alpha_mask)*r_rate;
        alpha_mask_temp(alpha_mask_temp>=r_rate) = 1;

        S = (alpha_mask_temp.*t_mask+ones(m,n))./(t_mask+ones(m,n)).*I;%对图像加入阴影
        filename_mat = strcat(DATA_NAME,'_shadow',char(LEVEL_NAME(i-1)),'_',num2str(k),'.mat');
        filename_pic = strcat(DATA_NAME,'_shadow',char(LEVEL_NAME(i-1)),'_',num2str(k),'.png');
        save(filename_mat, 'S');
%         figure,imshow(S(:,:,[29 19 12])) %显示降质后的图像
        % % Fsrc=imadjust(F(:,:,[29 19 12]),stretchlim(F(:,:,[29 19 12]),[0.01 0.99]),[]);
        % % figure,imshow(Fsrc) %
        imwrite(S(:,:,[29 19 12]),filename_pic); 
    end
end