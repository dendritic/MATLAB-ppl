classdef Sampler < Inference
  %UNTITLED11 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function sample(~, erp, pars, k)
      k(sample(erp, pars{:}));
    end
  end
  
end

