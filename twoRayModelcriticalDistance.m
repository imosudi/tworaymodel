ld=0:0.001:5; 
%%Declaring Variables
    d=10.^ld; 
    ht=45; %50; 
    hr=1.5; %2;
    %R=-1; 
    %G_los=1; 
    %G_gr=1; 
    %lambda=1/3; 
l_gr=sqrt( (ht+hr)^2+d.^2); %% 
D = sqr(d.^2 + (ht -h2).^2);
l_los=sqrt( (ht-hr)^2+d.^2); 
R=-1; 
G_los=1; 
G_gr=1; 
lambda=1/3; 
phi=2*pi*(D-l_los)/lambda; 
los=sqrt(G_los)./l_los; 
gr=R*sqrt(G_gr)*exp(-j.*phi)./D; 
rs=lambda.*(los+gr)/4*pi; 
ps=abs(rs).^2; 
norm=ps(1); 
pn=ps./norm; 
x = ld ;
y =10*log10(pn); 
plot(ld,y); 
title('Power vs distance plot for 2-ray ground reflected model '); 
xlabel('log(d)'); 
ylabel('Normalized Power(in dB)');
%print -deps graph.eps