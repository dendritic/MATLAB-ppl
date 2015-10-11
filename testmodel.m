function testmodel()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

e = Enumerator;

  function binomial3(k)
    sample(e, erp.Bernoulli, {0.5},...
      @(a)sample(e, erp.Bernoulli, {0.5},...
      @(b)sample(e, erp.Bernoulli, {0.5},...
      @(c)k(a + b + c))));
    
%     a = sample(env, erp.Bernoulli, 0.5, k);
%     b = sample(env, erp.Bernoulli, 0.5, k);
%     c = sample(env, erp.Bernoulli, 0.5, k);
%     nSuccess = a + b + c;
  end


binomial3(@e.run)
end

