classdef Enumerator < Inference
  %UNTITLED12 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    UnexploredConts = {}
    UnexploredDScores = []
    CurrentScore = 0
    Results = struct('value', {}, 'score', {})
  end
  
  methods
    function sample(env, erp, pars, k)
      sup = support(erp, pars{:});
      scores = score(erp, pars{:}, sup);
      paths = mapToCell(@(x)@()k(x), sup);
      env.UnexploredConts = cat(1, env.UnexploredConts, paths(1:end-1));
      env.UnexploredDScores = cat(1, env.UnexploredDScores, scores(1:end-1));
      env.CurrentScore = env.CurrentScore + scores(end);
      paths{end}();
%       arrayfun(k, s);
    end
    
    function run(env, res)
      env.Results(end+1).value = res;
      env.Results(end).score = env.CurrentScore;
      
    end
  end
  
end

