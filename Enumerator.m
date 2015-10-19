classdef Enumerator < Inference
  %UNTITLED12 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Futures
    CurrentScore
    Level
    ValueProbs
  end
  
  methods
    function [vals, probs] = run(env, comp)
      tic
      env.CurrentScore = 0;
      env.Level = 0;
      env.Futures = PriorityQueue;
      env.ValueProbs = java.util.HashMap();
      comp(@env.finish);
      vals = cell(toArray(keySet(env.ValueProbs)));
      probs = cell2mat(cell(toArray(values(env.ValueProbs))));
      probs = probs/sum(probs);
      toc
    end
    
    function print(env, comp, ax)
      [vals, probs] = run(env, comp);
      if nargin < 3
        ax = axes('Parent', figure);
      end
      scalarVals = all(cellfun(@(v)isnumeric(v) && isscalar(v), vals));
      if scalarVals
        bar(ax, cell2mat(vals), probs);
      else
        bar(ax, probs);
        labels = mapToCell(@num2str, vals);
        set(ax, 'XTickLabel', labels);
      end
      ylabel(ax, 'Probability');
      xlabel(ax, 'Value');
    end
    
    function sample(env, erp, pars, k)
      sup = support(erp, pars{:});
      scores = score(erp, pars{:}, sup) +  env.CurrentScore;
      newlevel = env.Level + 1;
      mapToCell(...
        @(v,s) enqueue(env.Futures, @()resume(env, k, v, s, newlevel), s),...
        sup, scores);
      runNextFuture(env);
    end
    
    function factor(env, score, k)
      env.CurrentScore = env.CurrentScore + score;
      k([]);
    end
    
    function finish(env, res)
      currProb = get(env.ValueProbs, res);
      if isempty(currProb)
        currProb = 0;
      end
      env.ValueProbs.put(res, currProb + exp(env.CurrentScore));
      runNextFuture(env);
    end
    
    function resume(env, k, v, score, level)
      env.CurrentScore = score;
      env.Level = level;
%       fprintf('applying ''%s'' with ''%g''\n', func2str(k), v);
      fprintf('resuming at level %i with %g\n', level, v);
      k(v);
    end
    
    function runNextFuture(env)
      if env.Futures.NumElem > 0
        nextFuture = pop(env.Futures);
        nextFuture();
      end
    end
  end
  
end

