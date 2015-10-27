classdef PriorityQueue < handle
  %PriorityQueue A (probably rather inefficient) priority queue
  
  properties (SetAccess = private)
    NumElem = 0
  end
  
  properties (Dependent)
    Items
    Values
  end
  
  properties (Access = private)
    pItems = {}
    pValues = []
  end
  
  methods
    function v = get.Items(q)
      v = q.pItems(1:q.NumElem);
    end
    
    function v = get.Values(q)
      v = q.pValues(1:q.NumElem);
    end
    
    function enqueue(q, item, value)
      if nargin < 3
        value = item;
      end
      assert(isscalar(value));
      if q.NumElem == 0
        q.pItems = {item};
        q.pValues = value;
      else
        splitAt = firstLarger(q.pValues(1:q.NumElem), value);
        right = q.pItems(splitAt:q.NumElem);
        q.pItems = [q.pItems(1:splitAt-1) {item} right];
        q.pValues = [q.pValues(1:splitAt-1) value q.pValues(splitAt:q.NumElem)];
      end
      q.NumElem = q.NumElem + 1;
    end
    
    function [item, value] = pop(q)
      item = q.pItems{q.NumElem};
      value = q.pValues(q.NumElem);
      q.NumElem = q.NumElem - 1;
    end
  end
  
end
%% Helper functions
function idx = firstLarger(sortedValues, v)
% fast O(log2(N)) computation using binary search

if v >= sortedValues(end)
  idx = length(sortedValues) + 1; % index at end
elseif v < sortedValues(1)
  idx = 1; % beginning
else
  idx_a = 1;
  % sortedValues(lowerIdx_b) will always satisfy lowerbound
  idx_b = length(sortedValues);
  
  %
  % Two indices, a and b, progessively narrow the search range
  while idx_a <= idx_b
    
    idx_mid = floor((idx_a + idx_b)/2); % split the upper index
    
    if sortedValues(idx_mid) <= v
      idx_a = idx_mid + 1;
    else
      idx_b = idx_mid - 1;
    end
  end
  idx = idx_a;
end
end