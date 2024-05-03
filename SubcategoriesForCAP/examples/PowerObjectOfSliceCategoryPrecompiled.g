LoadPackage( "Subcat" );

b := FinSet( 3 );

S := SliceCategory( b );

m := FinSet( 5 );

f := MapOfFinSets( m, [ 2, 0, 0, 2, 0 ], b ) / S;

S_1 := S;
object_1 := f;

powerobject :=
function ( S_1, object_1 )
    local hoisted_3_1, deduped_5_1, hoisted_6_1, hoisted_7_1, hoisted_9_1, hoisted_10_1, deduped_12_1, hoisted_15_1, hoisted_16_1, hoisted_17_1, hoisted_18_1,
    deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1,
    deduped_31_1, deduped_32_1, deduped_33_1, deduped_34_1, deduped_35_1;
    deduped_35_1 := BigInt( 1 );
    deduped_34_1 := BigInt( 0 );
    deduped_33_1 := BigInt( 4 );
    deduped_32_1 := UnderlyingMorphism( object_1 );
    deduped_31_1 := BigInt( 2 );
    deduped_30_1 := AmbientCategory( S_1 );
    deduped_29_1 := Target( deduped_32_1 );
    deduped_28_1 := Length( deduped_29_1 );
    deduped_27_1 := Length( Source( deduped_32_1 ) );
    deduped_26_1 := deduped_31_1 ^ deduped_27_1;
    deduped_25_1 := [ 0 .. deduped_28_1 - 1 ];
    deduped_24_1 := deduped_26_1 * deduped_28_1;
    deduped_23_1 := [ 0 .. deduped_33_1 ^ deduped_27_1 - 1 ];
    deduped_22_1 := [ 0 .. deduped_24_1 - 1 ];
    deduped_5_1 := [ 0 .. deduped_27_1 - 1 ];
    hoisted_3_1 := [ deduped_34_1, deduped_34_1, deduped_34_1, deduped_35_1 ];
    hoisted_10_1 := List( deduped_23_1, function ( i_2 )
            return Sum( List( deduped_5_1, function ( k_3 )
                      return ( hoisted_3_1[(1 + DigitInPositionalNotation( i_2, ( k_3 ), deduped_27_1, deduped_33_1 ))] )
                        * deduped_31_1 ^ k_3;
                  end ) );
        end );
    hoisted_7_1 := [ deduped_34_1, deduped_34_1, deduped_35_1, deduped_35_1 ];
    hoisted_6_1 := [ deduped_34_1, deduped_35_1, deduped_34_1, deduped_35_1 ];
    hoisted_9_1 := List( deduped_23_1, function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := ( i_2 );
            return ( Sum( List( deduped_5_1, function ( k_3 )
                          return
                           ( hoisted_6_1[(1 + DigitInPositionalNotation( deduped_1_2, ( k_3 ), deduped_27_1,
                                    deduped_33_1 ))] ) * deduped_31_1 ^ k_3;
                      end ) ) ) + ( Sum( List( deduped_5_1, function ( k_3 )
                            return
                             ( hoisted_7_1[(1 + DigitInPositionalNotation( deduped_1_2, ( k_3 ), deduped_27_1,
                                      deduped_33_1 ))] ) * deduped_31_1 ^ k_3;
                        end ) ) ) * deduped_26_1;
        end );
    hoisted_18_1 := List( [ 0 .. deduped_26_1 * deduped_26_1 - 1 ], function ( x_2 )
            return hoisted_10_1[BigInt( SafePosition( hoisted_9_1, x_2 ) )];
        end );
    hoisted_15_1 := AsList( deduped_32_1 );
    hoisted_16_1 := List( [ 0 .. deduped_31_1 ^ deduped_28_1 - 1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := List( deduped_25_1, function ( i_3 )
                    return DigitInPositionalNotation( i_2, i_3, deduped_28_1, deduped_31_1 );
                end );
            return Sum( List( deduped_5_1, function ( k_3 )
                      return ( hoisted_1_2[(1 + hoisted_15_1[(1 + ( k_3 ))])] ) * deduped_31_1 ^ k_3;
                  end ) );
        end );
    hoisted_17_1 := List( deduped_25_1, function ( i_2 )
            return hoisted_16_1[1 + deduped_31_1 ^ i_2];
        end );
    deduped_12_1 := List( deduped_22_1, function ( i_2 )
            return RemIntWithDomain( i_2, deduped_26_1, deduped_24_1 );
        end );
    deduped_21_1 := Filtered( deduped_22_1, function ( x_2 )
            local deduped_1_2;
            deduped_1_2 := ( x_2 );
            return
             (
                 hoisted_18_1[1 + (deduped_12_1[1 + deduped_1_2]
                     + ( hoisted_17_1[(1 + QuoIntWithDomain( deduped_1_2, deduped_26_1, deduped_24_1 ))] ) * deduped_26_1)] )
              = deduped_12_1[1 + x_2];
        end );
    deduped_20_1 := Length( deduped_21_1 );
    return CreateCapCategoryObjectWithAttributes( S_1, UnderlyingMorphism, CreateCapCategoryMorphismWithAttributes( deduped_30_1, CreateCapCategoryObjectWithAttributes(
           deduped_30_1, Length, deduped_20_1 ), deduped_29_1, AsList, List( [ 0 .. deduped_20_1 - 1 ], function ( i_2 )
                return ( QuoIntWithDomain( ( deduped_21_1[1 + i_2] ), deduped_26_1, deduped_24_1 ) );
            end ) ) );
end;

Display( f );
Display( powerobject( S, f ) );

