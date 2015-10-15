classdef Enumerator < Inference
  %UNTITLED12 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Futures = {}
    CurrentScore = 0
    ValueProbs = containers.Map('KeyType', 'double', 'ValueType', 'double')
  end
  
  methods
    function sample(env, erp, pars, k)
      sup = support(erp, pars{:});
      scores = score(erp, pars{:}, sup) +  env.CurrentScore;
      futures = mapToCell(@(v,s) @()resume(env, k, v, s), sup, scores);
      env.Futures = cat(2, env.Futures, futures(1:end-1));
      futures{end}();
    end
    
    function finish(env, res)
      if isKey(env.ValueProbs, res)
        env.ValueProbs(res) = env.ValueProbs(res) + exp(env.CurrentScore);
      else
        env.ValueProbs(res) = exp(env.CurrentScore);
      end
      if ~isempty(env.Futures)
        nextFuture = env.Futures{end};
        env.Futures(end) = [];
        nextFuture();
      end
    end
    
    function resume(env, k, v, score)
      env.CurrentScore = score;
      k(v);
    end
    
    function run(env, comp)
      comp(@env.finish);
      probs = cell2mat(values(env.ValueProbs));
      probs = probs/sum(probs);
      env.ValueProbs = containers.Map(keys(env.ValueProbs), probs);
    end
  end
  
end

