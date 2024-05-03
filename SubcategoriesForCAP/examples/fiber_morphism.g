#LoadPackage( "FinSets" );

DigitInPositionalNotation :=
  # [ IsBigInt, IsBigInt, IsBigInt, IsBigInt ],
  function ( i, k, l, b )
    Assert( 0, k < l );
    # return the digit of index k in the b-adic expansion of length l of the natural number i.
    return RemInt( QuoInt( i, b ^ k ), b );
end;

## f: m → n or, in data structures f := [ f0, ..., f_{m-1} ], f_i ∈ {0, ..., n - 1}
fiber_morphism :=
  function ( m, f, n )
    local hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_10_1;
    
    deduped_10_1 := 2;
    deduped_7_1 := [ 0 .. n - 1 ];
    hoisted_5_1 := [ 0 .. m - 1 ];
    hoisted_6_1 :=
      List( [ 0 .. deduped_10_1 ^ n - 1 ], function ( i_2 )
        local hoisted_1_2;
        hoisted_1_2 := List( deduped_7_1, function ( i_3 )
            return DigitInPositionalNotation( i_2, i_3, n, deduped_10_1 );
        end );
        return Sum( hoisted_5_1, function ( k_3 )
            return ( hoisted_1_2[(1 + f[(1 + ( k_3 ))])] ) * deduped_10_1 ^ k_3;
        end );
    end );
    
    ## n → 2^m, i -> f⁻¹(i)
    return List( deduped_7_1, function ( i_2 ) return hoisted_6_1[1 + deduped_10_1 ^ i_2]; end );
    
end;

MyPositions :=
  function( f, i, n )
    local m, two, two_i, i_th_basis_vector;
    
    m := Length( f );
    two := 2;
    two_i := two ^ i;
    
    i_th_basis_vector := List( [ 0 .. n - 1 ], j -> DigitInPositionalNotation( two_i, j, n, two ) );
    
    return Sum( [ 0 .. m - 1 ], k -> i_th_basis_vector[1 + f[1 + k]] * two^k );
    
end;

fiber_morphism_compiled :=
  function ( m, f, n )
    
    ## n → 2^m, i -> f⁻¹(i)
    return List( [ 0 .. n - 1 ], i -> MyPositions( f, i, n ) );
    
end;

fiber_morphism_optimized :=
  function( m, f, n )
    
    return List( [ 0 .. n - 1 ], i -> Sum( -1 + Positions( f, i ), k -> 2 ^ k ) );
    
end;


m := 3;
n := 4;
f := [ 0, 2, 0 ];

Assert( 0, fiber_morphism( m, f, n ) = [ 5, 0, 2, 0 ] );
Assert( 0, fiber_morphism_compiled( m, f, n ) = [ 5, 0, 2, 0 ] );
Assert( 0, fiber_morphism_optimized( m, f, n ) = [ 5, 0, 2, 0 ] );

t := 7;
l := 3;
s := t ^ l;
f := Concatenation( ListWithIdenticalEntries( t^(l-1), [ 0 .. t - 1 ] ) );

Assert( 0, fiber_morphism( s, f, t ) = fiber_morphism_compiled( s, f, t ) );
Assert( 0, fiber_morphism_compiled( s, f, t ) = fiber_morphism_optimized( s, f, t ) );
