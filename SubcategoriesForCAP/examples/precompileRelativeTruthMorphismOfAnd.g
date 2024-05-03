LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

#ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets

reland_notcompiled := { sFinSets, A } -> RelativeTruthMorphismOfAnd( sFinSets, A );

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        variable_filters := [ IsBigInt ],
        src_template := "1 + (-1 + number)",
        dst_template := "number",
    )
);

StartTimer( "RelativeTruthMorphismOfAnd" );

reland_compiled_notoptimized := CapJitCompiledFunction( reland_notcompiled, sFinSets, [ "category", "object" ], "morphism" );

StopTimer( "RelativeTruthMorphismOfAnd" );

DisplayTimer( "RelativeTruthMorphismOfAnd" );

Display( reland_compiled_notoptimized );

Display( reland_compiled_notoptimized( sFinSets, FinSet( 3 ) ) );

reland_precompiled :=
  function( n )
    local hoisted_3_1, hoisted_5_1, hoisted_7_1, Pn4, hoisted_9_1, hoisted_10_1,
          Pn, two, four, zero;
    
    zero := BigInt( 0 );
    four := BigInt( 4 );
    two := BigInt( 2 );
    Pn := two ^ n;
    Pn4 := four * Pn;
    
    hoisted_5_1 := [ 0 .. n - 1 ];
    hoisted_3_1 := [ zero, zero, zero, BigInt( 1 ) ];
    hoisted_10_1 := two ^ four;
    hoisted_9_1 := [ 0 .. n - 3 ];
    hoisted_7_1 := [ 0 .. Minimum( n, two ) - 1 ];
    
    return
      function ( i )
        local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, a;
        hoisted_4_2 := QUO_INT( i, Pn4 );
        hoisted_3_2 := QUO_INT( REM_INT( i, Pn ), four );
        hoisted_2_2 := REM_INT( QUO_INT( i, Pn ), four );
        hoisted_1_2 := REM_INT( i, four );
        a := Sum( hoisted_7_1, function ( p )
            return (DigitInPositionalNotation( hoisted_1_2, p, n, two )
                    + two * DigitInPositionalNotation( hoisted_2_2, p, n, two )) * four ^ p;
        end ) + hoisted_10_1 * Sum( hoisted_9_1, function ( p )
            return ((DigitInPositionalNotation( hoisted_3_2, p, n, two )
                     + two * DigitInPositionalNotation( hoisted_4_2, p, n, two )) * four ^ p);
        end );
        
        return Sum( List( hoisted_5_1, function ( k )
            return hoisted_3_1[(1 + DigitInPositionalNotation( a, k, n, four ))] * two ^ k;
        end ) );
    end;
    
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

reland :=
  function( n )
    
    return i -> Sum( [ 0 .. n - 1 ], j -> List( shuffle_binary_expansion( n, i ), a -> a[1] * a[2] )[1 + j] * 2^j );
    
end;

reland_understood :=
  function( n )
    
    return i -> Sum( [ 0 .. n - 1 ], j -> DigitInPositionalNotation( i, j, 2 * n, 2 ) * DigitInPositionalNotation( i, n + j, 2 * n, 2 ) * 2^j );
    
end;

n := 3;
Display( "" );
Display( AsList( reland_notcompiled( sFinSets, ObjectConstructor( sFinSets, n ) ) ) );
Display( AsList( reland_compiled_notoptimized( sFinSets, ObjectConstructor( sFinSets, n ) ) ) );
Display( List( [ 0 .. 4^n - 1 ], reland_precompiled( n ) ) );
Display( List( [ 0 .. 4^n - 1 ], reland( n ) ) );
Display( List( [ 0 .. 4^n - 1 ], reland_understood( n ) ) );
