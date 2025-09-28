function thermo_out = flash_qtz(vin, B, FSR, Vt_offset_en, varpercent)

LSB = FSR/2^B;

variation = rand(1,2^B-1);
variation = variation-0.5;
variation = variation.*varpercent;
vt_variation = variation+1;

Vtrans = -FSR/2+LSB:LSB:FSR/2-LSB;

if Vt_offset_en
    Vtrans = Vtrans + 0.01*Vtrans.^2 + 0.01*Vtrans.^3;
end

Vtrans = Vtrans.*vt_variation;

thermo_out = sum(vin>Vtrans);

end
