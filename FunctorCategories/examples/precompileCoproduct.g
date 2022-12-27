LoadPackage( "FunctorCategories", false );
#! true

LoadPackage( "CompilerForCAP", ">= 2022.09-02", false );
#! true

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );
#! true

ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );
#! true

ReadPackageOnce( "FunctorCategories", "gap/CompilerLogic.gi" );
#! true

#cat := PreSheaves( FreeCategory( QuiverOfCategoryOfBouquets : range_of_HomStructure := CategoryOfSkeletalFinSets( : FinalizeCategory := true, no_precompiled_code := true ), no_precompiled_code := true ) : no_precompiled_code := true );

cat := CategoryOfBouquetsEnrichedOver( CategoryOfSkeletalFinSets( : FinalizeCategory := true, no_precompiled_code := true ) : no_precompiled_code := true );

func := { cat, arg2 } -> Coproduct( cat, arg2 );

StartTimer( "Coproduct" );

compiled_func := CapJitCompiledFunction( func, cat, [ "category", "list_of_objects" ], "object" );

StopTimer( "Coproduct" );

DisplayTimer( "Coproduct" );

Display( compiled_func );
