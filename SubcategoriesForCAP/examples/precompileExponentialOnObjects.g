LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

LoadPackage( "SubcategoriesForCAP" );
#! true
LoadPackage( "Toposes", ">= 2022.12-03" );
#! true
LoadPackage( "FinSetsForCAP", ">= 2022.05-01" );
#! true
B := SubobjectClassifier( CategoryOfSkeletalFinSets( : no_precompiled_code := true ) );
#! |2|
S := SliceCategory( B );
#! A slice category of SkeletalFinSets
Display( S );

func := { S, object1, object2 } -> ExponentialOnObjects( S, object1, object2 );

StartTimer( "exponential" );

exponential := CapJitCompiledFunction( func, S, [ "category", "object", "object" ], "morphism" );

StopTimer( "exponential" );

DisplayTimer( "exponential" );

Display( exponential );
