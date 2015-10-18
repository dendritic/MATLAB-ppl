function hmm()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

e = Enumerator;

  function transition(s, k)
    p = s*.7 + ~s*.3;
    sample(e, erp.Bernoulli, {p}, @(a)k(a));
  end

  function observe(s, k)
    p = s*.9 + ~s*.1;
    sample(e, erp.Bernoulli, {p}, @(a)k(a));
  end

  function hmm(k)
    k(1);
%     a = sample(env, erp.Bernoulli, 0.5, k);
%     b = sample(env, erp.Bernoulli, 0.5, k);
%     c = sample(env, erp.Bernoulli, 0.5, k);
%     nSuccess = a + b + c;
  end

print(e, @hmm, gca);

end

