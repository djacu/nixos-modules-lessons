{...}: {
  config = {
    exampleNested1 = [
      "I can use strings, integers, or booleans."
      42
      true
    ];
    exampleNested2 = {
      foo = "bar";
      baz = "qux";
      dontuse = null;
      fizz = null;
      buzz = null;
    };
    exampleNested3 = {
      singlePrimes = [2 3 5 7];
      fibonacci = [1 1 2 3 5 8 13];
      mixed = [(-1) 0 "one"];
    };
    exampleNested4 = {
      foo = [null 1 2 3];
      bar = {
        fizz = "buzz";
        baz = "qux";
      };
    };
  };
}
