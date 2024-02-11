{...}: {
  config = {
    exampleListOf = [
      1
      10
      100
      1000
    ];
    exampleAttrsOf = {
      foo = "bar";
      baz = "quz";
      fizz = "buzz";
    };
    exampleNullOr = true;
    exampleEither = "I could have been an integer.";
    exampleOneOf = "I could have been an integer or boolean.";
  };
}
