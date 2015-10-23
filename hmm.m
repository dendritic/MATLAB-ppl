function hmm()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

e = Sampler;

  function transition(s, k)
    p = s*.7 + ~s*.3;
    sample(e, erp.Bernoulli, {p}, k);
  end

  function observe(s, k)
    p = s*.9 + ~s*.1;
    sample(e, erp.Bernoulli, {p}, k);
  end

  function hmm(n, k)
    function update(prev)
      transition(prev.states(end),...
        @(s)observe(s,...
        @(o)k(struct('states', [prev.states s], 'observations', [prev.observations o]))));
    end
    if n == 1
      update(struct('states', true, 'observations', []));
    else
      hmm(n - 1, @update)
    end
  end

run(e, @(k)hmm(4,k));

end

