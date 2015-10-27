function r = hmm()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

e = Enumerator;

  function transition(s, k)
    p = s*.7 + ~s*.3;
    sample(e, erp.Bernoulli, {p}, k);
  end

  function observe(s, k)
    p = s*.9 + ~s*.1;
    sample(e, erp.Bernoulli, {p}, k);
  end

  function hmm(states, obs, k)
    if isempty(obs)
      k(states);
    else
%       transition(states(end),...
%         @(s)sampleWithFactor(e, erp.Bernoulli, {s*.9 + ~s*.1}, @(v)log(double(obs(1)==v)),...
%         @(o)hmm(n - 1, [states s], obs(2:end), k)));
      transition(states(end),...
        @(s)sample(e, erp.Bernoulli, {s*.9 + ~s*.1},...
        @(o)factor(e, log(1*(obs(1)==o)), @()hmm([states s], obs(2:end), k))));
%       sampleWithFactor(e, erp.Bernoulli, {states(end)*.7 + ~states(end)*.3},...
%         @(s)log((obs(1)==s)*.9 + (obs(1)~=s)*.1),...
%         @(s)hmm(n - 1, [states s], obs(2:end), k));
    end
%     function update(prev)
%       transition(last(get(prev, 'states')),...
%         @(s)observe(s,...
%         @(o)k(struct('states', [get(prev, 'states'); s], 'obs', [get(prev, 'obs'); o]))));
%     end
%     if n == 1
%       update(struct('states', true, 'obs', []));
%     else
%       hmm(n - 1, @update);
%     end
  end

%   function s = struct(varargin)
%     s = java.util.HashMap();
%     cellfun(@(k,v) put(s, k, v), varargin(1:2:end), varargin(2:2:end), 'uni', false);
%   end

%   function elem = last(o)
%     elem = o(end);
%   end

tic
n = 4;
print(e, @(k)hmm(false, true(1, n), k));
toc

r = e.ValueProbs;
% vals = cell(toArray(keySet(r)));
% probs = cell(toArray(values(r)));
% valstrs = mapToCell(@(v)num2str(v'), vals);

  function toStr(m)
    
  end

end

