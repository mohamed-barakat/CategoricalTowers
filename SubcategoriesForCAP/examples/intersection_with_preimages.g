DigitInPositionalNotation :=
  # [ IsBigInt, IsBigInt, IsBigInt, IsBigInt ],
  function ( i, k, l, b )
    Assert( 0, k < l );
    # return the digit of index k in the b-adic expansion of length l of the natural number i.
    return RemInt( QuoInt( i, b ^ k ), b );
end;

## PA × B → PA, (T, b) ↦ T ∩ f⁻¹(b)
intersection_compiled :=
  function ( A, f, B )
    local PA, PAxB, deduped_1_1, deduped_4_1, hoisted_10_1, hoisted_11_1, hoisted_12_1, deduped_13_1, deduped_16_1, deduped_17_1;
    
    deduped_17_1 := 2;
    PA := deduped_17_1 ^ A;
    PAxB := PA * B;
    deduped_13_1 := [ 0 .. B - 1 ];
    deduped_4_1 := [ 0 .. A - 1 ];
    deduped_1_1 := deduped_17_1 * A;
    ## [ 0 .. 2^n * 2^n - 1 ] = PA x PA -> PA, (S1, S2) ↦ S1 ∩ S2
    hoisted_12_1 := List( [ 0 .. 4 ^ A - 1 ], function ( i_2 )
            return Sum( deduped_4_1, function ( j_3 )
                    return DigitInPositionalNotation( i_2, j_3, deduped_1_1, deduped_17_1 ) * DigitInPositionalNotation( i_2, (A + j_3), deduped_1_1,
                           deduped_17_1 ) * deduped_17_1 ^ j_3;
                end );
            end );
            
    hoisted_10_1 := List( [ 0 .. deduped_17_1 ^ B - 1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := List( deduped_13_1, function ( i_3 )
                    return DigitInPositionalNotation( i_2, i_3, B, deduped_17_1 );
                end );
            return Sum( List( deduped_4_1, function ( k_3 )
                      return ( hoisted_1_2[(1 + f[(1 + ( k_3 ))])] ) * deduped_17_1 ^ k_3;
                  end ) );
        end );
    hoisted_11_1 := List( deduped_13_1, function ( i_2 )
            return hoisted_10_1[1 + deduped_17_1 ^ i_2];
        end );
        
        return List( [ 0 .. PAxB - 1 ],
                     function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := ( i_2 );
            return hoisted_12_1[1 + (( RemInt( deduped_1_2, PA ) )
                           + ( hoisted_11_1[(1 + QuoInt( deduped_1_2, PA ))] ) * PA)];
        end );
end;

## PA × B → PA, (T, b) ↦ T ∩ f⁻¹(b)
intersection_optimized :=
  function( A, map, B )
    local PA, PAxB, func;
    
    PA := 2^A;
    
    PAxB := PA * B;
    
    func :=
      function( p ) ## p ∈ PAxB → PA
        local T, b, fiber_b, int;
        
        T := RemInt( p, PA );
        b := QuoInt( p, PA );
        
        T := Positions( List( [ 0 .. A - 1 ], i -> DigitInPositionalNotation( T, i, A, 2 ) ), 1 );
        fiber_b := Positions( map, b );
        
        int := -1 + Intersection( T, fiber_b );
        
        return Sum( int, k -> 2^k );
        
    end;
    
    return List( [ 0 .. PAxB - 1 ], func );
    
end;

## PA × B → PA, (T, b) ↦ T ∩ f⁻¹(b)
intersection_understood :=
  function( A, map, B )
    local PA, PAxB, func;
    
    PA := 2^A;
    
    PAxB := PA * B;
    
    func :=
      function( p ) ## p ∈ PAxB → PA
        local T, b, fiber_b;
        
        T := RemInt( p, PA );
        b := QuoInt( p, PA );
        
        fiber_b := Sum( -1 + Positions( map, b ), k -> 2^k );
        
        return Sum( [ 0 .. A - 1 ], j -> DigitInPositionalNotation( T, j, PA, 2 ) * DigitInPositionalNotation( fiber_b, j, PA, 2 ) * 2^j );
        
    end;
    
    return List( [ 0 .. PAxB - 1 ], func );
    
end;

A := 3;
B := 4;

map := [ 0, 2, 0 ];

int_compiled := intersection_compiled( A, map, B );
Display( int_compiled );
int_optimized := intersection_optimized( A, map, B );
Display( int_optimized );
int_understood := intersection_understood( A, map, B );
Display( int_understood );

t := 3;
l := 2;
s := t ^ l;
f := Concatenation( ListWithIdenticalEntries( t^(l-1), [ 0 .. t - 1 ] ) );
