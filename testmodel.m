function testmodel()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

e = Enumerator;

p = {0.25};

  function binomial3(k)
    sample(e, erp.Bernoulli, p,...
      @(a)sample(e, erp.Bernoulli, p,...
      @(b)sample(e, erp.Bernoulli, p,...
      @(c)k(a + b + c))));
    
%     a = sample(env, erp.Bernoulli, 0.5, k);
%     b = sample(env, erp.Bernoulli, 0.5, k);
%     c = sample(env, erp.Bernoulli, 0.5, k);
%     nSuccess = a + b + c;
  end

print(e, @binomial3, gca);
end

