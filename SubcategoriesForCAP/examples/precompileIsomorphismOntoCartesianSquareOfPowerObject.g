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

H :=
  function( n )
    return List( [ 0 .. 4^n -1 ], i_2 ->
                 Sum( [ 0 .. n - 1 ], k_3 ->
                      [ 0, 1, 2^n, 1 + 2^n ][1 + DigitInPositionalNotation( i_2, k_3, n, 4 )] * 2 ^ k_3 ) );
end;


J :=
  function( n, i ) ## i in [ 0 .. 4^n - 1 ]
    local j0, j1, j2, j3;
    
    j0 := RemInt( i, 4 );
    
    j1 := RemInt( QuoInt( i, 2^n ), 4 );
    
    j2 := QuoInt( RemInt( i, 2^n ), 4 );
    
    j3 := QuoInt( i, 2^(n + 2) );
    
    return [ j0, j1, j2, j3 ];
    
end;

D :=
  function( n, k )
    return Sum( [ 0 .. n - 1 ], j -> DigitInPositionalNotation( k, j, n, 2 ) * 4^j );
end;

C :=
  function( n, i, j )
    return D( n, J(n, i)[1 + j] );
end;

L :=
  function( n )
    return List( [ 0 .. 4 ^ n - 1 ], i ->
                 C(n, i, 0) + 2 * C(n, i, 1) + 2^4 * C(n, i, 2) + 2^5 * C(n, i, 3) );
end;

H_1 := L;
