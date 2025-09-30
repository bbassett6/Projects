% hand calcs
% amplifier noise
for C_s = [300 600].*1e-15
noise_power = 4*k*T/C_s;
SNR_amp = 10*log10(VDD^2/(noise_power));

% sampler noise
SNR_samp = VDD^2*C_samp/(4*k*T);
SNR_samp = 10*log10(SNR_samp);
% enob = (SNRdiff-1.76)/6.02

% static settling
% t = ts/2;
% tau = R_sw*C_samp;
% Verr_percent = exp(-t/tau);

% quantization error from final fine 4b adc
B_effective = 13;
SNR_Q = B_effective*6.02+1.76;

% SNR total
C_s
SNR_total_calculated = -10*log10( 10^(-SNR_samp/10)+10^(-SNR_amp/10)+10^(-SNR_Q/10))
end