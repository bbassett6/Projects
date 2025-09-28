close all; clear all;
C = [0];
varpercent = 0.1;

variation = rand(1,16);
variation = variation-0.5;
variation = variation.*varpercent;
cdac_variation = variation+1;

Vin = -1.2:0.01:1.2;
for vin = -1.2:0.01:1.2
    Dout = flash_qtz(vin,4,2.4,0,0);
    Vq = Cdac(Dout,4,2.4,cdac_variation);
    C = cat(2,C,Vq);
end    
plot(Vin,C(2:242));
