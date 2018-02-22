%% Inputs

ld=0; h=0.0005; df=5; %log10(closest distance, distance iteration step, farthest distance)
ht = 45; hr = 1.5; %transmit antenna height, receive antenna height
Ft = 1800 * 10.^6;  %transmit frequency
R = -1; %Ground reflection coefficient
G_los = 1; G_gr = 1; %Products of tx and rx antenna radiation field patterns (LOS and Reflected)
%% Running the graph function

[Distance,Pr,dc,dh] = receivedpower(df,h,G_los,G_gr,ht,hr,R,Ft);
%% Plotting the graph
plot(Distance,Pr,'color','b'); hold on;
plot(dh*ones(size(Pr)),Pr,'-.','color','g');
plot(dc*ones(size(Pr)),Pr,':','color','r');
text(dc,0,'\leftarrow   dc ')

%% Graph Labels
titlestr =  "Received Power(dB) vs Distance(log10) for Two-Ray Model " + newline ; 
title(titlestr ); 
xlabel('log(d)'); xticks(0:1:df)
ylabel('Received Power Pr(in dB)');
legend(" Two-Ray Model Power Falloff", "Transmit Antenna Height", ...
    ... 
    'Critical Distance dc', 'Location','southwest');



%% The Graph Function
%%
function [Distance,Pr,dc,dh] = receivedpower(df,h,G_los,G_gr,ht,hr,R,Ft) 
    
    ld=0:h:df;
    d=10.^ld;
    c = 3 * 10.^8; %Speed of light,
        lambda = c/Ft; %The Wavelength, lambda
	l_gr = sqrt(d.^2 + (ht + hr)^2); %Reflected signal distance x+x'
	l_los = sqrt( (ht - hr)^2 + d.^2 ); %LOS distance, l
	phase_shift = 2*pi*(l_gr-l_los)/lambda; %The phase difference between the two received signals
	los = sqrt(G_los)./l_los; %LOS Signal Component
	gr = R*sqrt(G_gr)*exp(-j.*phase_shift)./l_gr; %Ground Reflected Signal Component
	rs = (lambda.*abs(los+gr)/4*pi).^2; %Take note of absolute value of los+gr
	norm = rs(1); %Normalizing Received signal power 
	pr = rs./norm;
    Distance = ld;
    Pr = 10*log10(pr);
    dc = 4*ht*hr/lambda; %Critical Distance, dc
    dc = log10(dc);
    dh = log10(ht);
end


%% 
%