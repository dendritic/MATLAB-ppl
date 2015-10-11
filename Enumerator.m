classdef Enumerator < Inference
  %UNTITLED12 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function sample(obj, erp, pars, k)
      s = support(erp, pars{:});
      k(s(1));
      k(s(2));
    end
  end
  
end

