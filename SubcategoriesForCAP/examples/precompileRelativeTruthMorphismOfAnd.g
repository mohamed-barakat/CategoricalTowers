LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

#ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets

func := { sFinSets, A } -> RelativeTruthMorphismOfAnd( sFinSets, A );

StartTimer( "RelativeTruthMorphismOfAnd" );

relative_and := CapJitCompiledFunction( func, sFinSets, [ "category", "object" ], "morphism" );

StopTimer( "RelativeTruthMorphismOfAnd" );

DisplayTimer( "RelativeTruthMorphismOfAnd" );

Display( relative_and );

Display( relative_and( sFinSets, FinSet( 3 ) ) );
