classdef Sampler < Inference
  %UNTITLED11 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function s = sample(~, erp, varargin)
      s = sample(erp, varargin{:});
    end
  end
  
end

