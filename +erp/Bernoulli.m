classdef Bernoulli < erp.ERP
  %UNTITLED9 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function x = support(~, pSuccess)
      if pSuccess == 0
        x = false;
      elseif pSuccess == 1
        x = true;
      else
        x = [false true];
      end
    end
    
    function x = sample(~, pSuccess)
      x = rand < pSuccess;
    end
    
    function lp = score(~, pSuccess, x)
      if x
        lp = log(pSuccess);
      else
        lp = log(1 - pSuccess);
      end
    end
  end
  
end

