classdef Inference < handle
  %UNTITLED10 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods (Abstract)
    sample(obj, erp, pars, k)
    factor(obj, score)
  end
  
end

