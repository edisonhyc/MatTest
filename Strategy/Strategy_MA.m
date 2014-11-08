function [Returncode,Ordertarget]=Strategy_MA(i)
Ordertarget=0;

if Index_MA(i,10)>Index_MA(i,50)
    Ordertarget=1;
elseif Index_MA(i,10)<Index_MA(i,50)
    Ordertarget=-1;
end

Returncode=0;

end