classdef Enumerator < Inference
  %UNTITLED12 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Futures
    CurrentScore
    Level
    ValueProbs
    NumSamples
  end
  
  methods
    function sample(env, erp, pars, k)
      sampleWithFactor(env, erp, pars, @zero, k);
    end
    
    function sampleWithFactor(env, erp, pars, scorefun, k)
      sup = support(erp, pars{:});
      scores = score(erp, pars{:}, sup) + scorefun(sup) +  env.CurrentScore;
      impossible = ~isfinite(scores);
       % don't continue impossible futures
      sup(impossible) = [];
      scores(impossible) = [];
      newlevel = env.Level + 1;
      mapToCell(...
        @(v,s) enqueue(env.Futures, @()resume(env, k, v, s, newlevel), s),...
        sup, scores);
    end
    
    function factor(env, score, k)
      if isfinite(score) % don't continue impossible futures
        env.CurrentScore = env.CurrentScore + score;
        k();
      end
    end
    
    function [vals, probs] = run(env, comp)
      env.NumSamples = 0;
      env.CurrentScore = 0;
      env.Level = 0;
      env.Futures = PriorityQueue;
      env.ValueProbs = containers.Map('KeyType', 'char', 'ValueType', 'double');
      comp(@env.finish); % start the computation
      %       dt = nan(1000,1);
      %       i = 0;
      %       tic
      while env.Futures.NumElem > 0 % iterate continuations until depleted
        nextFuture = pop(env.Futures);
        nextFuture();
        %         i = i + 1;
        %         dt(i) = toc;
      end
      %       fprintf('%i took %.1fms\n', i, 1000*toc);
      %       figure, plot(diff(dt(1:i)));
      vals = keys(env.ValueProbs);
      probs = cell2mat(values(env.ValueProbs));
      probs = probs/sum(probs);
      fprintf('Enumerated %i possible states\n', env.NumSamples);
    end
    
    function print(env, comp, ax)
      [vals, probs] = run(env, comp);
      [probs, pOrder] = sort(probs);
      vals = vals(pOrder);
      if nargin < 3
        ax = axes('Parent', figure);
      end
      barh(ax, log(probs));
      set(ax, 'YTickLabel', vals, 'YTick', 1:numel(vals), 'FontSize', 8);
      xlabel(ax, 'Probability');
      ylabel(ax, 'Value');
    end
    
    function finish(env, res)
      if isfinite(env.CurrentScore)
        reskey = toStr(res);
        if isKey(env.ValueProbs, reskey)
          currProb = env.ValueProbs(reskey);
        else
          currProb = 0;
        end
        env.ValueProbs(reskey) = currProb + exp(env.CurrentScore);
        env.NumSamples = env.NumSamples + 1;
      else
        error('impossible future finished')
      end
    end
    
    function resume(env, k, v, score, level)
      env.CurrentScore = score;
      env.Level = level;
      %       fprintf('applying ''%s'' with ''%g''\n', func2str(k), v);
      %       fprintf('resuming at level %i with %g\n', level, v);
      k(v);
    end
  end
  
end

function str = toStr(v)
  function s = boolstr(v)
    if v, s = 't'; else s = 'f'; end
  end
if islogical(v)
  str = ['[' arrayfun(@boolstr, v) ']'];
elseif isstruct(v)
  fn = fieldnames(v)';
  valstrs = mapToCell(@toStr, struct2cell(v));
  fv = cell(1, numel(fn));
  for fi = 1:numel(fn)
    fv{fi} = sprintf('%s: %s', fn{fi}, valstrs{fi});
  end
  str = ['{' strjoin(fv, ', ') '}'];
else
  str = ['[' sprintf('%g,', v) ']'];
  str(end-1) = [];
end
end

function v = zero(v)
v = zeros(size(v));
end

