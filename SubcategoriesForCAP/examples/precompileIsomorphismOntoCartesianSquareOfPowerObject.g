LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

#ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets

func := { sFinSets, A } -> IsomorphismOntoCartesianSquareOfPowerObject( sFinSets, A );

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "i", "n", "m", "b", "t", "range", "list1", "list2" ],
        #variable_filters := [ IsBigInt, IsBigInt, IsBigInt, IsBigInt, IsBigInt, IsList, IsList, IsList ],
        src_template := "Sum( List( range, x -> list1[( 1 + DigitInPositionalNotation( i, x, n, b ) )] * t^x ) ) + Sum( List( range, x -> list2[( 1 + DigitInPositionalNotation( i, x, n, b ) )] * t^x ) ) * m",
        dst_template := "Sum( List( range, k -> ( list1 + list2 * m )[( 1 + DigitInPositionalNotation( i, k, n, b ) )] * t^k ) )",
        new_funcs := [ [ "k" ] ],
    )
);

StartTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

iso := CapJitCompiledFunction( func, sFinSets, [ "category", "object" ], "morphism" );

StopTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

DisplayTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

Display( iso );

Display( iso( sFinSets, FinSet( 3 ) ) );

iso :=
  function( n )
    ## i in [ 0 .. 4^n - 1 ]
    return i -> Sum( [ 0 .. n - 1 ], k ->
                   [ 0, 1, 2^n, 1 + 2^n ][1 + DigitInPositionalNotation( i, k, n, 4 )] * 2 ^ k );
end;

inv :=
  function( n )
    
    return i ->
           Sum( [ 0 .. Minimum( n, 2 ) - 1 ], p ->
                ( DigitInPositionalNotation( RemInt( i, 4 ), p, n, 2 ) +
                  2 * DigitInPositionalNotation( RemInt( QuoInt( i, 2^n ), 4 ), p, n, 2 ) ) * 4^p ) +
           2^4 * Sum( [ 0 .. n - 3 ], p ->
                   ( DigitInPositionalNotation( QuoInt( RemInt( i, 2^n ), 4 ), p, n, 2 ) +
                     2 * DigitInPositionalNotation( QuoInt( i, 2^(n + 2) ), p, n, 2 ) ) * 4^p );
    
end;

## Set( Concatenation( List( [ 0 .. 9 ], n -> [ List( [ 0 .. 4 ^ n - 1 ], i -> iso( n )( inv( n )( i ) ) ) = [ 0 .. 4 ^ n - 1 ], List( [ 0 .. 4 ^ n - 1 ], i -> inv( n )( iso( n )( i ) ) ) = [ 0 .. 4 ^ n - 1 ] ] ) ) );


binary_expansion_for_unshuffle :=
  function( n, i )
    return List( [ 0 .. n - 1 ], j -> [ DigitInPositionalNotation( i, 2 * j, 2 * n, 2 ), DigitInPositionalNotation( i, 2 * j + 1, 2 * n, 2 ) ] );
end;

unshuffle_binary_expansion :=
  function( n, i )
    local binary_expanded;
    
    binary_expanded := binary_expansion_for_unshuffle( n, i );
    
    return Concatenation( List( binary_expanded, a -> a[1] ), List( binary_expanded, a -> a[2] ) );
    
end;

unshuffle :=
  function( n )
    
    return i -> Sum( [ 0 .. 2 * n - 1 ], j -> unshuffle_binary_expansion( n, i )[1 + j] * 2^j );
    
end;

binary_expansion_for_shuffle :=
  function( n, i )
    return [ List( [ 0 .. n - 1 ], j -> DigitInPositionalNotation( i, j, 2 * n, 2 ) ), List( [ n .. 2 * n - 1 ], j -> DigitInPositionalNotation( i, j, 2 * n, 2 ) ) ];
end;

shuffle_binary_expansion :=
  function( n, i )
    local binary_expanded;
    
    binary_expanded := binary_expansion_for_shuffle( n, i );
    
    return ListN( binary_expanded[1], binary_expanded[2], { a, b } -> [ a, b ] );
    
end;

shuffle :=
  function( n )
    
    return i -> Sum( [ 0 .. 2 * n - 1 ], j -> Concatenation( shuffle_binary_expansion( n, i ) )[1 + j] * 2^j );
    
end;

shuffle_understood :=
  function( n )
    
    return i -> Sum( [ 0 .. n - 1 ], j -> ( DigitInPositionalNotation( i, j, 2 * n, 2 ) + 2 * DigitInPositionalNotation( i, j + n, 2 * n, 2 ) ) * 2^(2 * j) );
    
end;

n := 3;
Display( "" );
Display( List( [ 0 .. 4 ^ n - 1 ], iso( n ) ) );
Display( List( [ 0 .. 4 ^ n - 1 ], unshuffle( n ) ) );
Display( "" );
Display( List( [ 0 .. 4 ^ n - 1 ], inv( n ) ) );
Display( List( [ 0 .. 4 ^ n - 1 ], shuffle( n ) ) );
Display( List( [ 0 .. 4 ^ n - 1 ], shuffle_understood( n ) ) );
