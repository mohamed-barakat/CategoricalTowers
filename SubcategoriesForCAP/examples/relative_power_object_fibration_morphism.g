DigitInPositionalNotation :=
  # [ IsBigInt, IsBigInt, IsBigInt, IsBigInt ],
  function ( i, k, l, b )
    Assert( 0, k < l );
    # return the digit of index k in the b-adic expansion of length l of the natural number i.
    return RemInt( QuoInt( i, b ^ k ), b );
end;

BigInt := IdFunc;

## P_fA → B
relative_power_object_fibration_morphism_compiled :=
  function ( A, f_1, B )
    local hoisted_3_1, deduped_5_1, hoisted_6_1, hoisted_7_1, hoisted_9_1, hoisted_10_1, deduped_12_1, hoisted_15_1, hoisted_16_1, hoisted_17_1, hoisted_18_1,
    deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_29_1,
    deduped_31_1, deduped_32_1, deduped_33_1;
    deduped_33_1 := BigInt( 1 );
    deduped_32_1 := BigInt( 0 );
    deduped_31_1 := BigInt( 4 );
    deduped_29_1 := BigInt( 2 );
    deduped_26_1 := deduped_29_1 ^ A;
    deduped_25_1 := [ 0 .. B - 1 ];
    deduped_24_1 := deduped_26_1 * B;
    deduped_23_1 := [ 0 .. deduped_31_1 ^ A - 1 ];
    deduped_22_1 := [ 0 .. deduped_24_1 - 1 ];
    deduped_5_1 := [ 0 .. A - 1 ];
    hoisted_3_1 := [ deduped_32_1, deduped_32_1, deduped_32_1, deduped_33_1 ];
    hoisted_10_1 := List( deduped_23_1, function ( i_2 )
            return Sum( List( deduped_5_1, function ( k_3 )
                      return ( hoisted_3_1[(1 + DigitInPositionalNotation( i_2, ( k_3 ), A, deduped_31_1 ))] )
                        * deduped_29_1 ^ k_3;
                  end ) );
        end );
    hoisted_7_1 := [ deduped_32_1, deduped_32_1, deduped_33_1, deduped_33_1 ];
    hoisted_6_1 := [ deduped_32_1, deduped_33_1, deduped_32_1, deduped_33_1 ];
    hoisted_9_1 := List( deduped_23_1, function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := ( i_2 );
            return ( Sum( List( deduped_5_1, function ( k_3 )
                          return
                           ( hoisted_6_1[(1 + DigitInPositionalNotation( deduped_1_2, ( k_3 ), A,
                                    deduped_31_1 ))] ) * deduped_29_1 ^ k_3;
                      end ) ) ) + ( Sum( List( deduped_5_1, function ( k_3 )
                            return
                             ( hoisted_7_1[(1 + DigitInPositionalNotation( deduped_1_2, ( k_3 ), A,
                                      deduped_31_1 ))] ) * deduped_29_1 ^ k_3;
                        end ) ) ) * deduped_26_1;
        end );
    hoisted_18_1 := List( [ 0 .. deduped_26_1 * deduped_26_1 - 1 ], function ( x_2 )
            return hoisted_10_1[BigInt( Position( hoisted_9_1, x_2 ) )];
        end );
    hoisted_15_1 := AsList( f_1 );
    hoisted_16_1 := List( [ 0 .. deduped_29_1 ^ B - 1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := List( deduped_25_1, function ( i_3 )
                    return DigitInPositionalNotation( i_2, i_3, B, deduped_29_1 );
                end );
            return Sum( List( deduped_5_1, function ( k_3 )
                      return ( hoisted_1_2[(1 + hoisted_15_1[(1 + ( k_3 ))])] ) * deduped_29_1 ^ k_3;
                  end ) );
        end );
    hoisted_17_1 := List( deduped_25_1, function ( i_2 )
            return hoisted_16_1[1 + deduped_29_1 ^ i_2];
        end );
    deduped_12_1 := List( deduped_22_1, function ( i_2 )
            return RemInt( i_2, deduped_26_1 );
        end );
    deduped_21_1 := Filtered( deduped_22_1, function ( x_2 )
            local deduped_1_2;
            deduped_1_2 := ( x_2 );
            return
             (
                 hoisted_18_1[1 + (deduped_12_1[1 + deduped_1_2]
                     + ( hoisted_17_1[(1 + QuoInt( deduped_1_2, deduped_26_1 ))] ) * deduped_26_1)] )
              = deduped_12_1[1 + x_2];
        end );
    deduped_20_1 := Length( deduped_21_1 );
    return List( [ 0 .. deduped_20_1 - 1 ], function ( i_2 ) return ( QuoInt( ( deduped_21_1[1 + i_2] ), deduped_26_1 ) ); end );
end;

## P_fA → B
relative_power_object_fibration_morphism_optimized :=
  function( A, map, B )
    
    return Concatenation( List( [ 0 .. B - 1 ], b -> ListWithIdenticalEntries( 2^Length( Positions( map, b ) ), b ) ) );
    
end;

## P_fA → B
relative_power_object_fibration_morphism_understood :=
  function( A, map, B )
    
    return Concatenation( List( [ 0 .. B - 1 ], b -> ListWithIdenticalEntries( 2^Length( Positions( map, b ) ), b ) ) );
    
end;

A := 3;
B := 4;

map := [ 0, 2, 0 ];

int_compiled := relative_power_object_fibration_morphism_compiled( A, map, B );
Display( int_compiled );
int_optimized := relative_power_object_fibration_morphism_optimized( A, map, B );
Display( int_optimized );
int_understood := relative_power_object_fibration_morphism_understood( A, map, B );
Display( int_understood );

t := 3;
l := 2;
s := t ^ l;
f := Concatenation( ListWithIdenticalEntries( t^(l-1), [ 0 .. t - 1 ] ) );
