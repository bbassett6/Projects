function Vout = Cdac(Din, B, FSR, cdac_variation)

% LSB = FSR/2^B;

y = [1 1 2 4 8 16 32 64 128 256 512 1024 2048 4096];

Cdac_array = y(1:B+1).*cdac_variation(1:B+1);
Cdac_array = flip(Cdac_array);

Dout = dec2bin(Din*2,B+1);
Dout_num = ones(length(Dout),1);

for n=1:length(Dout)
    if abs(str2double(Dout(n)))==1
        Dout_num(n) = abs(str2double(Dout(n)));
    else
        Dout_num(n) = -1;
    end
end
Dout_num(B+1) = 0;
Dout_num;
VOUT = Cdac_array*Dout_num/(sum(Cdac_array));
Vout = sum(VOUT*FSR/2);
% VOUT = cast(Vout, "double");
% Cdac.outputs(1).DataType = 'double';

end
