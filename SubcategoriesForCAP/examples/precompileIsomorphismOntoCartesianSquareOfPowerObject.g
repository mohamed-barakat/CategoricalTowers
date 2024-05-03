LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

#ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets

func := { sFinSets, A } -> IsomorphismOntoCartesianSquareOfPowerObject( sFinSets, A );

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "i", "n", "m", "b", "t", "range", "list1", "list2" ],
        #variable_filters := [ IsBigInt, IsBigInt, IsBigInt, IsBigInt, IsBigInt, IsList, IsList, IsList ],
        src_template := "Sum( List( range, x -> list1[( 1 + DigitInPositionalNotation( i, x, n, b ) )] * t^x ) ) + Sum( List( range, x -> list2[( 1 + DigitInPositionalNotation( i, x, n, b ) )] * t^x ) ) * m",
        dst_template := "Sum( List( range, k -> ( list1 + list2 * m )[( 1 + DigitInPositionalNotation( i, k, n, b ) )] * t^k ) )",
        new_funcs := [ [ "k" ] ],
    )
);

StartTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

iso := CapJitCompiledFunction( func, sFinSets, [ "category", "object" ], "morphism" );

StopTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

DisplayTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

Display( iso );

Display( iso( sFinSets, FinSet( 3 ) ) );
