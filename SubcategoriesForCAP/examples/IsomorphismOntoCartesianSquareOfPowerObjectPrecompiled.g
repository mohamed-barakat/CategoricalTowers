LoadPackage( "FinSetsForCAP" );

iso :=
  function ( sFinSets_1, A_1 )
    local a, aa;
    a := Length( A_1 );
    aa := [ BigInt( 0 ), BigInt( 1 ), BigInt( 2 ) ^ a, BigInt( 1 ) + BigInt( 2 ) ^ a ];
    return CreateCapCategoryMorphismWithAttributes( sFinSets_1, CreateCapCategoryObjectWithAttributes( sFinSets_1, Length, BigInt( 4 ) ^ a ),
                   CreateCapCategoryObjectWithAttributes( sFinSets_1, Length, BigInt( 4 ) ^ a ), AsList, List( [ 0 .. BigInt( 4 ) ^ a - 1 ], i_2 ->
                           Sum( [ 0 .. a - 1 ], k_3 -> aa[(1 + DigitInPositionalNotation( i_2, ( k_3 ), a, BigInt( 4 ) ))] * BigInt( 2 ) ^ k_3 ) ) );
end;
