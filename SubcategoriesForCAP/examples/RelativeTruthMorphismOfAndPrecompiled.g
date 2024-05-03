LoadPackage( "FinSets" );

relative_truth_morphism_of_and :=
  function ( sFinSets_1, A_1 )
    local n, L, H, a;
    
    n := Length( A_1 );
    
    L := List( [ 0 .. 4 ^ n - 1 ], i_2 -> Sum( [ 0 .. n - 1 ], k_3 -> [ 0, 0, 0, 1 ][1 + DigitInPositionalNotation( i_2, k_3, n, 4 )] * 2 ^ k_3 ) );
    
    a := [ 0, 1, 0, 1 ] + [ 0, 0, 1, 1 ] * 2 ^ n;
              
    H := List( [ 0 .. 4 ^ n - 1 ], i_2 -> Sum( [ 0 .. n - 1 ], k_3 -> a[1 + DigitInPositionalNotation( i_2, k_3, n, 4 )] * 2 ^ k_3 ) );
    
    Error( );
    
    return CreateCapCategoryMorphismWithAttributes( sFinSets_1,
                   CreateCapCategoryObjectWithAttributes( sFinSets_1, Length, 4 ^ n ),
                   CreateCapCategoryObjectWithAttributes( sFinSets_1, Length, 2 ^ n ),
                   AsList,
                   List( [ 0 .. 4 ^ n - 1 ], x_2 -> L[BigInt( SafePosition( H, x_2 ) )] ) );
end;
