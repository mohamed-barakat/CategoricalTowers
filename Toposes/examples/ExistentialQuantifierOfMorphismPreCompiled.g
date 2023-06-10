eq :=
function ( cat_1, f_1 )
    local hoisted_1_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := BigInt( 2 );
    deduped_10_1 := Length( Source( f_1 ) );
    deduped_9_1 := Length( Range( f_1 ) );
    deduped_8_1 := deduped_11_1 ^ deduped_9_1;
    hoisted_6_1 := deduped_11_1 ^ deduped_10_1;
    hoisted_5_1 := deduped_11_1 ^ GeometricSum( deduped_11_1, deduped_10_1 );
    hoisted_4_1 := [ 0 .. deduped_10_1 - 1 ];
    hoisted_1_1 := AsFunc( f_1 );
    hoisted_7_1 := Sum( List( [ 0 .. deduped_8_1 - 1 ], function ( k_2 )
              return DigitInPositionalNotation( hoisted_5_1, Sum( List( hoisted_4_1, function ( k_3 )
                            return DigitInPositionalNotation( k_2, hoisted_1_1( k_3 ), deduped_9_1, deduped_11_1 ) * deduped_11_1 ^ k_3;
                        end ) ), hoisted_6_1, deduped_11_1 ) * deduped_11_1 ^ k_2;
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Length, BigInt( 1 ) ), CreateCapCategoryObjectWithAttributes(
         cat_1, Length, deduped_11_1 ^ deduped_8_1 ), AsFunc, function ( i_2 )
            return hoisted_7_1;
        end );
end;
