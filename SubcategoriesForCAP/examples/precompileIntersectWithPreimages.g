LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

#ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets

intersection_notcompiled := { sFinSets, PAxB, f, PA } -> IntersectWithPreimagesWithGivenObjects( sFinSets, PAxB, f, PA );

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        variable_filters := [ IsBigInt ],
        src_template := "1 + (-1 + number)",
        dst_template := "number",
    )
);

StartTimer( "IntersectWithPreimages" );

intersection_compiled_notoptimized := CapJitCompiledFunction( intersection_notcompiled, sFinSets, [ "category", "object", "morphism", "object" ], "morphism" );

StopTimer( "IntersectWithPreimages" );

DisplayTimer( "IntersectWithPreimages" );

Display( intersection_compiled_notoptimized );

intersection_compiled :=
  function ( sFinSets_1, PAxB_1, f_1, PA_1 )
    local deduped_1_1, deduped_4_1, deduped_5_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, hoisted_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1,
          deduped_17_1;
    
    deduped_17_1 := BigInt( 2 );
    deduped_16_1 := Length( PAxB_1 );
    deduped_15_1 := Length( Range( f_1 ) );
    deduped_14_1 := Length( Source( f_1 ) );
    deduped_13_1 := [ 0 .. deduped_15_1 - 1 ];
    deduped_4_1 := [ 0 .. deduped_14_1 - 1 ];
    deduped_1_1 := deduped_17_1 * deduped_14_1;
    ## [ 0 .. 2^n * 2^n - 1 ] = PA x PA -> PA, (S1, S2) ↦ S1 ∩ S2
    hoisted_12_1 := List( [ 0 .. BigInt( 4 ) ^ deduped_14_1 - 1 ], function ( i_2 )
            return Sum( deduped_4_1, function ( j_3 )
                    return DigitInPositionalNotation( i_2, j_3, deduped_1_1, deduped_17_1 ) * DigitInPositionalNotation( i_2, (deduped_14_1 + j_3), deduped_1_1,
                           deduped_17_1 ) * deduped_17_1 ^ j_3;
                end );
        end );
    hoisted_9_1 := AsList( f_1 );
    hoisted_10_1 := List( [ 0 .. deduped_17_1 ^ deduped_15_1 - 1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := List( deduped_13_1, function ( i_3 )
                    return DigitInPositionalNotation( i_2, i_3, deduped_15_1, deduped_17_1 );
                end );
            return Sum( List( deduped_4_1, function ( k_3 )
                      return ( hoisted_1_2[(1 + hoisted_9_1[(1 + ( k_3 ))])] ) * deduped_17_1 ^ k_3;
                  end ) );
        end );
    hoisted_11_1 := List( deduped_13_1, function ( i_2 )
            return hoisted_10_1[1 + deduped_17_1 ^ i_2];
        end );
    deduped_5_1 := Length( PA_1 );
    return CreateCapCategoryMorphismWithAttributes( sFinSets_1, PAxB_1, PA_1, AsList, List( [ 0 .. deduped_16_1 - 1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := ( i_2 );
              return hoisted_12_1[1 + (( RemIntWithDomain( deduped_1_2, deduped_5_1, deduped_16_1 ) )
                   + ( hoisted_11_1[(1 + QuoIntWithDomain( deduped_1_2, deduped_5_1, deduped_16_1 ))] ) * deduped_5_1)];
          end ) );
end;

A := ObjectConstructor( sFinSets, 3 );
B := ObjectConstructor( sFinSets, 4 );

map := MapOfFinSets( A, [ 0, 2, 0 ], B );

PA := PowerObject( A );
PAxB := DirectProduct( PA, B );

int_notcompiled := intersection_notcompiled( sFinSets, PAxB, map, PA );
Assert( 0, IsWellDefined( int_notcompiled ) );
Display( int_notcompiled );

int_compiled_notoptimized := intersection_compiled_notoptimized( sFinSets, PAxB, map, PA );
Assert( 0, int_notcompiled = int_compiled_notoptimized );

int_compiled := intersection_compiled( sFinSets, PAxB, map, PA );
Assert( 0, int_notcompiled = int_compiled );
