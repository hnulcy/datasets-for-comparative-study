function NonP_Stripe   =  NonPeriodical_Simulated_lcy(Ori,width_rate,mean_rate)
%rate:竖着的条带比例；mean:加噪均值
% rand('seed',0);
Stripe_mean = mean(mean(mean(Ori)))*mean_rate;
% Stripe_mean = 0.27*mean_rate;
[line,Col,band] = size(Ori);
% Location = all_Location(1:round(width_rate/0.8*size(all_Location,2)));
Location = randperm(Col,round(width_rate*Col));
NonP_Stripe=Ori;
NonP_Stripe(:,Location(1:round(width_rate*Col/2)),:)=Ori(:,Location(1:round(width_rate*Col/2)),:) + normrnd(Stripe_mean,0.01*Stripe_mean,[line size(Location(1:round(width_rate*Col/2)),2) band]);
NonP_Stripe(:,Location(round(width_rate*Col/2)+1:round(width_rate*Col)),:)=Ori(:,Location(round(width_rate*Col/2)+1:round(width_rate*Col)),:) - normrnd(Stripe_mean,0.01*Stripe_mean,[line size(Location(round(width_rate*Col/2)+1:round(width_rate*Col)),2) band]);

 
 
 
 