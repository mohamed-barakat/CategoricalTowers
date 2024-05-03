LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

#ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets

embedding_of_relative_power_object_notcompiled := { sFinSets, f } -> EmbeddingOfRelativePowerObject( sFinSets, f );

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        variable_filters := [ IsBigInt ],
        src_template := "1 + (-1 + number)",
        dst_template := "number",
    )
);

StartTimer( "EmbeddingOfRelativePowerObject" );

embedding_of_relative_power_object_compiled_notoptimized := CapJitCompiledFunction( embedding_of_relative_power_object_notcompiled, sFinSets, [ "category", "morphism" ], "morphism" );

StopTimer( "EmbeddingOfRelativePowerObject" );

DisplayTimer( "EmbeddingOfRelativePowerObject" );

Display( embedding_of_relative_power_object_compiled_notoptimized );

embedding_of_relative_power_object_compiled :=
  function ( sFinSets_1, f_1 )
    local hoisted_3_1, deduped_5_1, hoisted_6_1, hoisted_7_1, hoisted_9_1, hoisted_10_1, deduped_12_1, hoisted_15_1, hoisted_16_1, hoisted_17_1, hoisted_18_1,
    deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1,
    deduped_30_1;
    deduped_30_1 := BigInt( 1 );
    deduped_29_1 := BigInt( 0 );
    deduped_28_1 := BigInt( 4 );
    deduped_27_1 := BigInt( 2 );
    deduped_26_1 := Length( Target( f_1 ) );
    deduped_25_1 := Length( Source( f_1 ) );
    deduped_24_1 := deduped_27_1 ^ deduped_25_1;
    deduped_23_1 := [ 0 .. deduped_26_1 - 1 ];
    deduped_22_1 := deduped_24_1 * deduped_26_1;
    deduped_21_1 := [ 0 .. deduped_28_1 ^ deduped_25_1 - 1 ];
    deduped_20_1 := [ 0 .. deduped_22_1 - 1 ];
    deduped_5_1 := [ 0 .. deduped_25_1 - 1 ];
    hoisted_3_1 := [ deduped_29_1, deduped_29_1, deduped_29_1, deduped_30_1 ];
    hoisted_10_1 := List( deduped_21_1, function ( i_2 )
            return Sum( List( deduped_5_1, function ( k_3 )
                      return ( hoisted_3_1[(1 + DigitInPositionalNotation( i_2, ( k_3 ), deduped_25_1, deduped_28_1 ))] )
                        * deduped_27_1 ^ k_3;
                  end ) );
        end );
    hoisted_7_1 := [ deduped_29_1, deduped_29_1, deduped_30_1, deduped_30_1 ];
    hoisted_6_1 := [ deduped_29_1, deduped_30_1, deduped_29_1, deduped_30_1 ];
    hoisted_9_1 := List( deduped_21_1, function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := ( i_2 );
            return ( Sum( List( deduped_5_1, function ( k_3 )
                          return
                           ( hoisted_6_1[(1 + DigitInPositionalNotation( deduped_1_2, ( k_3 ), deduped_25_1,
                                    deduped_28_1 ))] ) * deduped_27_1 ^ k_3;
                      end ) ) ) + ( Sum( List( deduped_5_1, function ( k_3 )
                            return
                             ( hoisted_7_1[(1 + DigitInPositionalNotation( deduped_1_2, ( k_3 ), deduped_25_1,
                                      deduped_28_1 ))] ) * deduped_27_1 ^ k_3;
                        end ) ) ) * deduped_24_1;
        end );
    hoisted_18_1 := List( [ 0 .. deduped_24_1 * deduped_24_1 - 1 ], function ( x_2 )
            return hoisted_10_1[BigInt( SafePosition( hoisted_9_1, x_2 ) )];
        end );
    hoisted_15_1 := AsList( f_1 );
    hoisted_16_1 := List( [ 0 .. deduped_27_1 ^ deduped_26_1 - 1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := List( deduped_23_1, function ( i_3 )
                    return DigitInPositionalNotation( i_2, i_3, deduped_26_1, deduped_27_1 );
                end );
            return Sum( List( deduped_5_1, function ( k_3 )
                      return ( hoisted_1_2[(1 + hoisted_15_1[(1 + ( k_3 ))])] ) * deduped_27_1 ^ k_3;
                  end ) );
        end );
    hoisted_17_1 := List( deduped_23_1, function ( i_2 )
            return hoisted_16_1[1 + deduped_27_1 ^ i_2];
        end );
    deduped_12_1 := List( deduped_20_1, function ( i_2 )
            return RemIntWithDomain( i_2, deduped_24_1, deduped_22_1 );
        end );
    deduped_19_1 := Filtered( deduped_20_1, function ( x_2 )
            local deduped_1_2;
            deduped_1_2 := ( x_2 );
            return
             (
                 hoisted_18_1[1 + (deduped_12_1[1 + deduped_1_2]
                     + ( hoisted_17_1[(1 + QuoIntWithDomain( deduped_1_2, deduped_24_1, deduped_22_1 ))] ) * deduped_24_1)] )
              = deduped_12_1[1 + x_2];
        end );
    return CreateCapCategoryMorphismWithAttributes( sFinSets_1, CreateCapCategoryObjectWithAttributes( sFinSets_1, Length, Length( deduped_19_1 ) ),
       CreateCapCategoryObjectWithAttributes( sFinSets_1, Length, deduped_22_1 ), AsList, deduped_19_1 );
end;

A := ObjectConstructor( sFinSets, 3 );
B := ObjectConstructor( sFinSets, 4 );

map := MapOfFinSets( A, [ 0, 2, 0 ], B );

PA := PowerObject( A );
PAxB := DirectProduct( PA, B );

emb_notcompiled := embedding_of_relative_power_object_notcompiled( sFinSets, map );
Assert( 0, IsWellDefined( emb_notcompiled ) );
Display( emb_notcompiled );

emb_compiled_notoptimized := embedding_of_relative_power_object_compiled_notoptimized( sFinSets, map );
Assert( 0, emb_notcompiled = emb_compiled_notoptimized );
Display( emb_compiled_notoptimized );

emb_compiled := embedding_of_relative_power_object_compiled( sFinSets, map );
Assert( 0, emb_notcompiled = emb_compiled );
Display( emb_compiled );
