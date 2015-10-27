function ifc(pred, trueFun, falseFun, k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if pred
  trueFun(k);
else
  falseFun(k);
end

end

