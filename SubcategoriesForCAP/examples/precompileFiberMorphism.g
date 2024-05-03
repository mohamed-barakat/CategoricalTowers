LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

#ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets

fiber_morphism_notcompiled := { sFinSets, f, PA } -> FiberMorphismWithGivenPowerObject( sFinSets, f, PA );

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        variable_filters := [ IsBigInt ],
        src_template := "1 + (-1 + number)",
        dst_template := "number",
    )
);

StartTimer( "FiberMorphism" );

fiber_morphism_compiled_notoptimized := CapJitCompiledFunction( fiber_morphism_notcompiled, sFinSets, [ "category", "morphism", "object" ], "morphism" );

StopTimer( "FiberMorphism" );

DisplayTimer( "FiberMorphism" );

Display( fiber_morphism_compiled_notoptimized );

fiber_morphism_compiled :=
  function ( sFinSets_1, f_1, PA_1 )
    local hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    
    deduped_10_1 := BigInt( 2 );
    deduped_9_1 := Target( f_1 );
    deduped_8_1 := Length( deduped_9_1 );
    deduped_7_1 := [ 0 .. deduped_8_1 - 1 ];
    hoisted_5_1 := [ 0 .. Length( Source( f_1 ) ) - 1 ];
    hoisted_4_1 := AsList( f_1 );
    hoisted_6_1 := List( [ 0 .. deduped_10_1 ^ deduped_8_1 - 1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := List( deduped_7_1, function ( i_3 )
                    return DigitInPositionalNotation( i_2, i_3, deduped_8_1, deduped_10_1 );
                end );
            return Sum( List( hoisted_5_1, function ( k_3 )
                      return ( hoisted_1_2[(1 + hoisted_4_1[(1 + ( k_3 ))])] ) * deduped_10_1 ^ k_3;
                  end ) );
        end );
    return CreateCapCategoryMorphismWithAttributes( sFinSets_1, deduped_9_1, PA_1, AsList, List( deduped_7_1, function ( i_2 )
              return hoisted_6_1[1 + deduped_10_1 ^ i_2];
          end ) );
          
end;

A := ObjectConstructor( sFinSets, 3 );
B := ObjectConstructor( sFinSets, 4 );

map := MapOfFinSets( A, [ 0, 2, 0 ], B );

PA := PowerObject( A );

fiber := FiberMorphismWithGivenPowerObject( sFinSets, map, PA );
Assert( 0, IsWellDefined( fiber ) );
Display( fiber );

fiber_compiled_notoptimized := fiber_morphism_compiled_notoptimized( sFinSets, map, PA );
Assert( 0, fiber = fiber_compiled_notoptimized );

fiber_compiled := fiber_morphism_compiled( sFinSets, map, PA );
Assert( 0, fiber = fiber_compiled );
