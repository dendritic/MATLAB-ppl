classdef ERP
  %UNTITLED8 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function x = support(~, varargin)
      error('Not implemented');
    end
  end
  
  methods (Abstract)
    x = sample(obj, varargin);
    lp = score(obj, varargin);
  end
  
end

