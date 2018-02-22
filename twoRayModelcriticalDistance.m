%% INITIAL CODE
%% Check the scripts directory for the updates

ld=0:0.0005:5; %define lowest distance, farthest distance and the iteration step
%%Declaring Variables
    d=10.^ld; 
    ht = 45;  
    hr = 1.5; 
     f = 1800 * 10.^6;
     c = 3 * 10.^8;  
     R = -1; 
 G_los = 1; 
  G_gr = 1; 
  l_gr = sqrt(d.^2 + (ht + hr)^2); 
 l_los = sqrt( (ht - hr)^2 + d.^2 ); 

lambda = c/f;      
   phi = 2*pi*(l_gr-l_los)/lambda; 

   los = sqrt(G_los)./l_los; 
    gr = R*sqrt(G_gr)*exp(-j.*phi)./l_gr; 
    rs = (lambda.*abs(los+gr)/4*pi).^2; 
  norm = rs(1); 
    pr = rs./norm; 

x = ld ;
y =10*log10(pr); 
plot(ld,y,'color','b'); hold on;


title('Power vs distance plot for 2-ray ground reflected model '); 

xlabel('log(d)'); 
ylabel('Normalized Power(in dB)');


dc = 4*ht*hr/lambda;
dc = log10(dc);
dh = log10(ht);
%dc = 3.209515
plot(dc*ones(size(y)),y,'color','r'); 
plot(dh*ones(size(y)),y,'color','g'); 

