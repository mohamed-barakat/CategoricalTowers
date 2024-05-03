## CartesianLambdaElimination (compiled code for SkeletalFinSets)
DigitInPositionalNotation := 
  # [ IsBigInt, IsBigInt, IsBigInt, IsBigInt ],
  function ( i, k, l, b )
    Assert( 0, k < l );
    # return the digit of index k in the b-adic expansion of length l of the natural number i.
    return RemInt( QuoInt( i, b ^ k ), b );
end;

## IsomorphismOntoCartesianSquareOfPowerObject (compiled code for SkeletalFinSets)
iso :=
  function( n )
    local L;
    L := [ 0, 1, 2^n, 1 + 2^n ];
    ## return a permutation on the set [ 0 .. 4^n - 1 ]
    return i -> Sum( [ 0 .. n - 1 ], k -> L[1 + DigitInPositionalNotation( i, k, n, 4 )] * 2^k );
end;
