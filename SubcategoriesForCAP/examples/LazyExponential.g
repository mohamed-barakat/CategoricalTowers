#! @Chunk LazyExponential

#! @Example
#! #@if ValueOption( "no_precompiled_code" ) <> true
LoadPackage( "SubcategoriesForCAP" );
#! true
LoadPackage( "Toposes", ">= 2024.02-04" );
#! true
LoadPackage( "FinSetsForCAP", ">= 2024.02-02" );
#! true
LoadPackage( "LazyCategories", false );
#! true
L := LazyCategory( SkeletalFinSets : primitive_operations := true );
#! LazyCategory( SkeletalFinSets )
B := SubobjectClassifier( SkeletalFinSets );
#! |2|
S := SliceCategory( B / L );
#! A slice category of SkeletalFinSets
Display( S );
#! A CAP category with name A slice category of SkeletalFinSets:
#! 
#! 52 primitive operations were used to derive 284 operations for this category which algorithmically
#! * IsCategoryWithDecidableColifts
#! * IsCategoryWithDecidableLifts
#! * IsEquippedWithHomomorphismStructure
#! * IsDistributiveCategory
#! * IsFiniteBicompleteCategory
#! and not yet algorithmically
#! * IsElementaryTopos
o0 := MapOfFinSets( B, [ 1, 1 ], B ) / L / S;
#! An object in the slice category given by: |2| → |2|
o1 := MapOfFinSets( FinSet( 3 ), [ 0, 1, 0 ], B ) / L / S;
#! An object in the slice category given by: |3| → |2|
o2 := MapOfFinSets( FinSet( 4 ), [ 1, 0, 1, 0 ], B ) / L / S;
#! An object in the slice category given by: |4| → |2|
expo1o1 := Exponential( o1, o1 );
IsWellDefined( expo1o1 );
#! true
evo1o1 := CartesianLeftEvaluationMorphism( o1, o1 );
IsWellDefined( evo1o1 );
#! true
#! #@fi
#! @EndExample
