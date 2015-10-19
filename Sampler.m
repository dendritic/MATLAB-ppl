classdef Sampler < Inference
  %UNTITLED11 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function sample(~, erp, pars, k)
      k(sample(erp, pars{:}));
    end
    
    function factor(~, ~)
    end
    
    function [vals, probs] = run(~, comp)
      comp(@disp);
    end
  end
  
end

