LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

#ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets

func := { sFinSets, A } -> IsomorphismOntoCartesianSquareOfPowerObject( sFinSets, A );

StartTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

iso := CapJitCompiledFunction( func, sFinSets, [ "category", "object" ], "morphism" );

StopTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

DisplayTimer( "IsomorphismOntoCartesianSquareOfPowerObject" );

Display( iso );

Display( iso( sFinSets, FinSet( 3 ) ) );
