function fact(n, ret)

if n == 0
  ret(1);
else
  fact(n - 1, @inner);
end

  function inner(res)
    fprintf('n=%i res=%i ret(%i)\n', n, res, n*res);
    ret(n*res);
  end

end