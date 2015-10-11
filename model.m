function model()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

  function nSuccess = binomial3()
    a = bflip(0.5);
    b = bflip(0.5);
    c = bflip(0.5);
    nSuccess = a + b + c;
  end

end

