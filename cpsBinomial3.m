function [ output_args ] = cpsBinomial3(ret)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

cpsFlip(@(a)cpsFlip(@(b)cpsFlip(@(c)ret(a + b + c), 0.5), 0.5), 0.5);

flip(0.5) + flip(0.5) + flip(0.5)

end

