LoadPackage( "FunctorCategories" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );

LoadPackage( "SubcategoriesForCAP" );
#! true
LoadPackage( "Toposes", ">= 2022.12-03" );
#! true
LoadPackage( "FinSetsForCAP", ">= 2022.05-01" );
#! true
sFinSets := CategoryOfSkeletalFinSets( : no_precompiled_code := true );
#! SkeletalFinSets
B := ObjectConstructor( sFinSets, 7 );
#! |7|
S := SliceCategory( B );
#! A slice category of SkeletalFinSets
Display( S );

func := { S, object } -> PowerObject( S, object );

StartTimer( "powerobject" );

powerobject := CapJitCompiledFunction( func, S, [ "category", "object" ], "object" );

StopTimer( "powerobject" );

DisplayTimer( "powerobject" );

Display( powerobject );
