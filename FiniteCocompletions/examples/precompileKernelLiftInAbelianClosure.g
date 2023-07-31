LoadPackage( "Algebroids", false );
#! true
LoadPackage( "FiniteCocompletions", false );
#! true
LoadPackage( "LazyCategories", false );
#! true
q := FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" );
#! q(4)[a:1->2,b:2->3,c:3->4]
Fq := PathCategory( q );
#! PathCategory( Quiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) )
Q := HomalgFieldOfRationals( );
#! Q
Qmat := CategoryOfRows( Q );
#! Rows( Q )
Qq := LinearClosure( Q, Fq : range_of_HomStructure := Qmat );
#! Q-LinearClosure( PathCategory( Quiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) ) )
L := Qq / [ Qq.abc ];
#! Q-LinearClosure( PathCategory( Quiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) ) )
#! / [ 1*a•b•c ]
#! / relations
A := AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure( L );
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( RightQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / relations )

CKDL := ModelingCategory( A );;
KDL := UnderlyingCategory( CKDL );;
DL := UnderlyingCategory( KDL );;

func := { A, phi, T, tau } -> KernelLift( A, phi, T, tau );

StartTimer( "KernelLift" );

CapJitAddLogicTemplate(
    rec(
        variable_names := [  ],
        src_template := "1 - 1",
        dst_template := "0",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [  ],
        src_template := "[ 1 .. 0 ]",
        dst_template := "[ ]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list" ],
        src_template := "list{[ ]}",
        dst_template := "[ ]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [  ],
        src_template := "Sum( [ ] )",
        dst_template := "0",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "0 + n",
        dst_template := "n",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "distinguished_object", "a", "b", "Hab" ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat, distinguished_object, ZeroMorphism( cat, a, b ), Hab )",
        dst_template := "ZeroMorphism( RangeCategoryOfHomomorphismStructure( cat ), distinguished_object, Hab )",
    )
);

StopCompilationAtCategory( DL );
StopCompilationAtCategory( Qmat );

compiled_func := CapJitCompiledFunction( func, A );

StopTimer( "KernelLift" );

DisplayTimer( "KernelLift" );

Display( compiled_func );

## KernelLift in in AbelianClosure( ... ) calls
## LiftAlongMonomorphism in Freyd( Op( Freyd( Op( AdditiveClosure( ... ) ) ) ) ) which calls
## Lift in Op( Freyd( Op( AdditiveClosure( ... ) ) )
## Colift in Freyd( Op( AdditiveClosure( ... ) ) which calls
## SolveLinearSystemInAbCategory in Op( AdditiveClosure( ... )

# StopCompilationAtPrimitivelyInstalledOperationsOfCategory( KDL );

#! function ( A_1, phi_1, T_1, tau_1 )
#!     local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1,
#!     deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
#!     deduped_21_1 := UnderlyingCell( tau_1 );
#!     deduped_20_1 := UnderlyingCell( phi_1 );
#!     deduped_19_1 := ModelingCategory( A_1 );
#!     deduped_18_1 := UnderlyingMorphism( deduped_20_1 );
#!     deduped_17_1 := UnderlyingCategory( deduped_19_1 );
#!     deduped_16_1 := RelationMorphism( Source( deduped_20_1 ) );
#!     deduped_15_1 := RelationMorphism( Range( deduped_20_1 ) );
#!     deduped_14_1 := Range( deduped_16_1 );
#!     deduped_13_1 := Source( deduped_16_1 );
#!     deduped_12_1 := [ Source( deduped_18_1 ), Source( deduped_15_1 ) ];
#!     deduped_11_1 := DirectSum( deduped_17_1, deduped_12_1 );
#!     deduped_10_1 := ProjectionInFactorOfDirectSumWithGivenDirectSum( deduped_17_1, deduped_12_1, 1, deduped_11_1 );
#!     deduped_9_1 := PostCompose( deduped_17_1, deduped_10_1, KernelEmbedding( deduped_17_1, AdditionForMorphisms( deduped_17_1, PostCompose( deduped_17_1, deduped_18_1,
#!              deduped_10_1 ), AdditiveInverseForMorphisms( deduped_17_1, PostCompose( deduped_17_1, deduped_15_1, ProjectionInFactorOfDirectSumWithGivenDirectSum(
#!                  deduped_17_1, deduped_12_1, 2, deduped_11_1 ) ) ) ) ) );
#!     deduped_8_1 := Source( deduped_9_1 );
#!     deduped_7_1 := [ deduped_13_1, deduped_8_1 ];
#!     deduped_6_1 := [ deduped_8_1, deduped_13_1 ];
#!     deduped_5_1 := DirectSum( deduped_17_1, deduped_6_1 );
#!     deduped_4_1 := ProjectionInFactorOfDirectSumWithGivenDirectSum( deduped_17_1, deduped_6_1, 1, deduped_5_1 );
#!     deduped_3_1 := PostCompose( deduped_17_1, deduped_4_1, KernelEmbedding( deduped_17_1, AdditionForMorphisms( deduped_17_1, PostCompose( deduped_17_1, deduped_9_1,
#!              deduped_4_1 ), AdditiveInverseForMorphisms( deduped_17_1, PostCompose( deduped_17_1, deduped_16_1, ProjectionInFactorOfDirectSumWithGivenDirectSum(
#!                  deduped_17_1, deduped_6_1, 2, deduped_5_1 ) ) ) ) ) );
#!     deduped_2_1 := CreateCapCategoryObjectWithAttributes( deduped_19_1, RelationMorphism, deduped_3_1 );
#!     deduped_1_1 := [ deduped_13_1, Range( deduped_3_1 ) ];
#!     return CreateCapCategoryMorphismWithAttributes( A_1, Source( tau_1 ), CreateCapCategoryObjectWithAttributes( A_1, UnderlyingCell, deduped_2_1 ), UnderlyingCell,
#!        CreateCapCategoryMorphismWithAttributes( deduped_19_1, Source( deduped_21_1 ), deduped_2_1, UnderlyingMorphism,
#!          PostCompose( deduped_17_1, ProjectionInFactorOfDirectSumWithGivenDirectSum( deduped_17_1, deduped_1_1, 2, DirectSum( deduped_17_1, deduped_1_1 ) ),
#!            Lift( deduped_17_1, PostCompose( deduped_17_1, IdentityMorphism( deduped_17_1, deduped_14_1 ), UnderlyingMorphism( deduped_21_1 ) ),
#!              UniversalMorphismFromDirectSumWithGivenDirectSum( deduped_17_1, deduped_7_1, deduped_14_1, [ deduped_16_1, deduped_9_1 ],
#!                DirectSum( deduped_17_1, deduped_7_1 ) ) ) ) ) );
#! end



# StopCompilationAtCategory( DL );

#! function ( A_1, phi_1, T_1, tau_1 )
#!     local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1,
#!     deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1,
#!     deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1, deduped_31_1, deduped_32_1, deduped_33_1, deduped_34_1,
#!     deduped_35_1, deduped_36_1, deduped_37_1, deduped_38_1, deduped_39_1, deduped_40_1, deduped_41_1, deduped_42_1, deduped_43_1, deduped_44_1, deduped_45_1,
#!     deduped_46_1, deduped_47_1, deduped_48_1, deduped_49_1, deduped_50_1, deduped_51_1;
#!     deduped_51_1 := RangeCategoryOfHomomorphismStructure( A_1 );
#!     deduped_50_1 := UnderlyingCell( tau_1 );
#!     deduped_49_1 := UnderlyingCell( phi_1 );
#!     deduped_48_1 := ModelingCategory( A_1 );
#!     deduped_47_1 := UnderlyingRing( deduped_51_1 );
#!     deduped_46_1 := UnderlyingMorphism( deduped_50_1 );
#!     deduped_45_1 := UnderlyingMorphism( deduped_49_1 );
#!     deduped_44_1 := UnderlyingCategory( deduped_48_1 );
#!     deduped_43_1 := Source( deduped_46_1 );
#!     deduped_42_1 := RelationMorphism( Source( deduped_49_1 ) );
#!     deduped_41_1 := RelationMorphism( Range( deduped_49_1 ) );
#!     deduped_40_1 := UnderlyingCategory( deduped_44_1 );
#!     deduped_39_1 := DistinguishedObjectOfHomomorphismStructure( deduped_40_1 );
#!     deduped_38_1 := CoRelationMorphism( deduped_43_1 );
#!     deduped_37_1 := UnderlyingMorphism( deduped_42_1 );
#!     deduped_36_1 := CoRelationMorphism( Source( deduped_45_1 ) );
#!     deduped_35_1 := Range( deduped_38_1 );
#!     deduped_34_1 := Source( deduped_38_1 );
#!     deduped_33_1 := CoRelationMorphism( Source( deduped_42_1 ) );
#!     deduped_32_1 := CoRelationMorphism( Source( deduped_41_1 ) );
#!     deduped_31_1 := Source( deduped_36_1 );
#!     deduped_30_1 := ZeroMorphism( deduped_40_1, deduped_34_1, deduped_35_1 );
#!     deduped_29_1 := IdentityMorphism( deduped_40_1, deduped_34_1 );
#!     deduped_28_1 := Source( CoRelationMorphism( Range( deduped_42_1 ) ) );
#!     deduped_27_1 := Range( deduped_33_1 );
#!     deduped_26_1 := Source( deduped_33_1 );
#!     deduped_25_1 := [ deduped_31_1, Source( deduped_32_1 ) ];
#!     deduped_24_1 := HomomorphismStructureOnObjects( deduped_40_1, deduped_35_1, deduped_28_1 );
#!     deduped_23_1 := HomomorphismStructureOnObjects( deduped_40_1, deduped_34_1, deduped_28_1 );
#!     deduped_22_1 := IdentityMorphism( deduped_40_1, deduped_28_1 );
#!     deduped_21_1 := ProjectionInFactorOfDirectSum( deduped_40_1, deduped_25_1, 1 );
#!     deduped_20_1 := DirectSumFunctorial( deduped_40_1, deduped_25_1, [ deduped_36_1, deduped_32_1 ], [ Range( deduped_36_1 ), Range( deduped_32_1 ) ] );
#!     deduped_19_1 := Source( deduped_20_1 );
#!     deduped_18_1 := PreCompose( deduped_40_1, IdentityMorphism( deduped_40_1, deduped_19_1 ), deduped_21_1 );
#!     deduped_17_1 := UniversalMorphismIntoDirectSum( deduped_40_1, [ Range( deduped_20_1 ), Source( CoRelationMorphism( Range( deduped_45_1 ) ) ) ], deduped_19_1,
#!        [ deduped_20_1, AdditionForMorphisms( deduped_40_1, PreCompose( deduped_40_1, deduped_21_1, UnderlyingMorphism( deduped_45_1 ) ),
#!              AdditiveInverseForMorphisms( deduped_40_1, PreCompose( deduped_40_1, ProjectionInFactorOfDirectSum( deduped_40_1, deduped_25_1, 2 ),
#!                  UnderlyingMorphism( deduped_41_1 ) ) ) ) ] );
#!     deduped_16_1 := CreateCapCategoryObjectWithAttributes( deduped_44_1, CoRelationMorphism, deduped_17_1 );
#!     deduped_15_1 := Range( deduped_17_1 );
#!     deduped_14_1 := Source( deduped_17_1 );
#!     deduped_13_1 := [ deduped_26_1, deduped_14_1 ];
#!     deduped_12_1 := [ deduped_14_1, deduped_26_1 ];
#!     deduped_11_1 := DirectSumFunctorial( deduped_40_1, deduped_13_1, [ deduped_33_1, deduped_17_1 ], [ deduped_27_1, deduped_15_1 ] );
#!     deduped_10_1 := ProjectionInFactorOfDirectSum( deduped_40_1, deduped_12_1, 1 );
#!     deduped_9_1 := DirectSumFunctorial( deduped_40_1, deduped_12_1, [ deduped_17_1, deduped_33_1 ], [ deduped_15_1, deduped_27_1 ] );
#!     deduped_8_1 := Range( deduped_11_1 );
#!     deduped_7_1 := Source( deduped_11_1 );
#!     deduped_6_1 := Source( deduped_9_1 );
#!     deduped_5_1 := HomomorphismStructureOnObjects( deduped_40_1, deduped_35_1, deduped_8_1 );
#!     deduped_4_1 := HomomorphismStructureOnObjects( deduped_40_1, deduped_34_1, deduped_8_1 );
#!     deduped_3_1 := HomomorphismStructureOnObjects( deduped_40_1, deduped_34_1, deduped_7_1 );
#!     deduped_2_1 := RankOfObject( deduped_3_1 );
#!     deduped_1_1 := CreateCapCategoryObjectWithAttributes( deduped_48_1, RelationMorphism, CreateCapCategoryMorphismWithAttributes( deduped_44_1,
#!          CreateCapCategoryObjectWithAttributes( deduped_44_1, CoRelationMorphism, UniversalMorphismIntoDirectSum( deduped_40_1, [ Range( deduped_9_1 ), deduped_31_1 ],
#!              deduped_6_1, [ deduped_9_1, AdditionForMorphisms( deduped_40_1, PreCompose( deduped_40_1, deduped_10_1, deduped_18_1 ),
#!                    AdditiveInverseForMorphisms( deduped_40_1, PreCompose( deduped_40_1, ProjectionInFactorOfDirectSum( deduped_40_1, deduped_12_1, 2 ), deduped_37_1 ) )
#!                    ) ] ) ), deduped_16_1, UnderlyingMorphism, PreCompose( deduped_40_1, IdentityMorphism( deduped_40_1, deduped_6_1 ), deduped_10_1 ) ) );
#!     return CreateCapCategoryMorphismWithAttributes( A_1, Source( tau_1 ), CreateCapCategoryObjectWithAttributes( A_1, UnderlyingCell, deduped_1_1 ), UnderlyingCell,
#!        CreateCapCategoryMorphismWithAttributes( deduped_48_1, Source( deduped_50_1 ), deduped_1_1, UnderlyingMorphism, CreateCapCategoryMorphismWithAttributes(
#!            deduped_44_1, deduped_43_1, deduped_16_1, UnderlyingMorphism,
#!            PreCompose( deduped_40_1, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( deduped_40_1, deduped_34_1, deduped_7_1,
#!                CreateCapCategoryMorphismWithAttributes( deduped_51_1, deduped_39_1, deduped_3_1, UnderlyingMatrix,
#!                  CertainColumns( SafeRightDivide( UnionOfColumns( deduped_47_1, RankOfObject( deduped_39_1 ),
#!                        [ UnderlyingMatrix( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( deduped_40_1, deduped_39_1,
#!                                ZeroMorphism( deduped_40_1, deduped_34_1, deduped_8_1 ), deduped_4_1 ) ),
#!                           UnderlyingMatrix( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( deduped_40_1, deduped_39_1,
#!                                PreCompose( deduped_40_1, UnderlyingMorphism( deduped_46_1 ), deduped_22_1 ), deduped_23_1 ) ) ] ),
#!                      UnionOfRows( deduped_47_1, Sum( [ RankOfObject( deduped_4_1 ), RankOfObject( deduped_23_1 ) ] ),
#!                        [
#!                           UnionOfColumns( deduped_47_1, deduped_2_1,
#!                              [ UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_40_1, deduped_3_1, deduped_29_1, deduped_11_1, deduped_4_1 ) )
#!                                   , UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_40_1, deduped_3_1, deduped_29_1,
#!                                      UniversalMorphismFromDirectSum( deduped_40_1, deduped_13_1, deduped_28_1, [ deduped_37_1, deduped_18_1 ] ), deduped_23_1 ) ) ] ),
#!                           UnionOfColumns( deduped_47_1, RankOfObject( deduped_5_1 ),
#!                              [ UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_40_1, deduped_5_1, deduped_38_1,
#!                                      AdditiveInverseForMorphisms( deduped_40_1, IdentityMorphism( deduped_40_1, deduped_8_1 ) ), deduped_4_1 ) ),
#!                                 UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_40_1, deduped_5_1, deduped_30_1,
#!                                      ZeroMorphism( deduped_40_1, deduped_8_1, deduped_28_1 ), deduped_23_1 ) ) ] ),
#!                           UnionOfColumns( deduped_47_1, RankOfObject( deduped_24_1 ),
#!                              [ UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_40_1, deduped_24_1, deduped_30_1,
#!                                      ZeroMorphism( deduped_40_1, deduped_28_1, deduped_8_1 ), deduped_4_1 ) ),
#!                                 UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_40_1, deduped_24_1, deduped_38_1,
#!                                      AdditiveInverseForMorphisms( deduped_40_1, deduped_22_1 ), deduped_23_1 ) ) ] ) ] ) ), [ 1 .. deduped_2_1 ] ) ) ),
#!              ProjectionInFactorOfDirectSum( deduped_40_1, deduped_13_1, 2 ) ) ) ) );
#! end


# StopCompilationAtCategory( DL );
# StopCompilationAtCategory( Qmat );

#! function ( A_1, phi_1, T_1, tau_1 )
#!     local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1,
#!     deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1,
#!     deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1, deduped_31_1, deduped_32_1, deduped_33_1, deduped_34_1,
#!     deduped_35_1, deduped_36_1, deduped_37_1, deduped_38_1, deduped_39_1, deduped_40_1, deduped_41_1, deduped_42_1, deduped_43_1, deduped_44_1, deduped_45_1,
#!     deduped_46_1, deduped_47_1, deduped_48_1, deduped_49_1, deduped_50_1, deduped_51_1, deduped_52_1;
#!     deduped_52_1 := RangeCategoryOfHomomorphismStructure( A_1 );
#!     deduped_51_1 := UnderlyingCell( tau_1 );
#!     deduped_50_1 := UnderlyingCell( phi_1 );
#!     deduped_49_1 := ModelingCategory( A_1 );
#!     deduped_48_1 := UnderlyingMorphism( deduped_51_1 );
#!     deduped_47_1 := UnderlyingMorphism( deduped_50_1 );
#!     deduped_46_1 := UnderlyingCategory( deduped_49_1 );
#!     deduped_45_1 := Source( deduped_48_1 );
#!     deduped_44_1 := RelationMorphism( Source( deduped_50_1 ) );
#!     deduped_43_1 := RelationMorphism( Range( deduped_50_1 ) );
#!     deduped_42_1 := UnderlyingCategory( deduped_46_1 );
#!     deduped_41_1 := DistinguishedObjectOfHomomorphismStructure( deduped_42_1 );
#!     deduped_40_1 := CoRelationMorphism( deduped_45_1 );
#!     deduped_39_1 := UnderlyingMorphism( deduped_44_1 );
#!     deduped_38_1 := CoRelationMorphism( Source( deduped_47_1 ) );
#!     deduped_37_1 := Range( deduped_40_1 );
#!     deduped_36_1 := Source( deduped_40_1 );
#!     deduped_35_1 := CoRelationMorphism( Source( deduped_44_1 ) );
#!     deduped_34_1 := CoRelationMorphism( Source( deduped_43_1 ) );
#!     deduped_33_1 := Source( deduped_38_1 );
#!     deduped_32_1 := ZeroMorphism( deduped_42_1, deduped_36_1, deduped_37_1 );
#!     deduped_31_1 := IdentityMorphism( deduped_42_1, deduped_36_1 );
#!     deduped_30_1 := Source( CoRelationMorphism( Range( deduped_44_1 ) ) );
#!     deduped_29_1 := Range( deduped_35_1 );
#!     deduped_28_1 := Source( deduped_35_1 );
#!     deduped_27_1 := [ deduped_33_1, Source( deduped_34_1 ) ];
#!     deduped_26_1 := HomomorphismStructureOnObjects( deduped_42_1, deduped_37_1, deduped_30_1 );
#!     deduped_25_1 := HomomorphismStructureOnObjects( deduped_42_1, deduped_36_1, deduped_30_1 );
#!     deduped_24_1 := IdentityMorphism( deduped_42_1, deduped_30_1 );
#!     deduped_23_1 := ProjectionInFactorOfDirectSum( deduped_42_1, deduped_27_1, 1 );
#!     deduped_22_1 := DirectSumFunctorial( deduped_42_1, deduped_27_1, [ deduped_38_1, deduped_34_1 ], [ Range( deduped_38_1 ), Range( deduped_34_1 ) ] );
#!     deduped_21_1 := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( deduped_42_1, deduped_41_1,
#!        PreCompose( deduped_42_1, UnderlyingMorphism( deduped_48_1 ), deduped_24_1 ), deduped_25_1 );
#!     deduped_20_1 := Source( deduped_22_1 );
#!     deduped_19_1 := PreCompose( deduped_42_1, IdentityMorphism( deduped_42_1, deduped_20_1 ), deduped_23_1 );
#!     deduped_18_1 := UniversalMorphismIntoDirectSum( deduped_42_1, [ Range( deduped_22_1 ), Source( CoRelationMorphism( Range( deduped_47_1 ) ) ) ], deduped_20_1,
#!        [ deduped_22_1, AdditionForMorphisms( deduped_42_1, PreCompose( deduped_42_1, deduped_23_1, UnderlyingMorphism( deduped_47_1 ) ),
#!              AdditiveInverseForMorphisms( deduped_42_1, PreCompose( deduped_42_1, ProjectionInFactorOfDirectSum( deduped_42_1, deduped_27_1, 2 ),
#!                  UnderlyingMorphism( deduped_43_1 ) ) ) ) ] );
#!     deduped_17_1 := CreateCapCategoryObjectWithAttributes( deduped_46_1, CoRelationMorphism, deduped_18_1 );
#!     deduped_16_1 := Range( deduped_18_1 );
#!     deduped_15_1 := Source( deduped_18_1 );
#!     deduped_14_1 := [ deduped_28_1, deduped_15_1 ];
#!     deduped_13_1 := [ deduped_15_1, deduped_28_1 ];
#!     deduped_12_1 := DirectSumFunctorial( deduped_42_1, deduped_14_1, [ deduped_35_1, deduped_18_1 ], [ deduped_29_1, deduped_16_1 ] );
#!     deduped_11_1 := ProjectionInFactorOfDirectSum( deduped_42_1, deduped_13_1, 1 );
#!     deduped_10_1 := DirectSumFunctorial( deduped_42_1, deduped_13_1, [ deduped_18_1, deduped_35_1 ], [ deduped_16_1, deduped_29_1 ] );
#!     deduped_9_1 := Range( deduped_12_1 );
#!     deduped_8_1 := Source( deduped_12_1 );
#!     deduped_7_1 := Source( deduped_10_1 );
#!     deduped_6_1 := HomomorphismStructureOnObjects( deduped_42_1, deduped_37_1, deduped_9_1 );
#!     deduped_5_1 := HomomorphismStructureOnObjects( deduped_42_1, deduped_36_1, deduped_8_1 );
#!     deduped_4_1 := HomomorphismStructureOnObjects( deduped_42_1, deduped_36_1, deduped_9_1 );
#!     deduped_3_1 := [ deduped_5_1, deduped_6_1, deduped_26_1 ];
#!     deduped_2_1 := ZeroMorphism( deduped_52_1, deduped_41_1, deduped_4_1 );
#!     deduped_1_1 := CreateCapCategoryObjectWithAttributes( deduped_49_1, RelationMorphism, CreateCapCategoryMorphismWithAttributes( deduped_46_1,
#!          CreateCapCategoryObjectWithAttributes( deduped_46_1, CoRelationMorphism, UniversalMorphismIntoDirectSum( deduped_42_1, [ Range( deduped_10_1 ), deduped_33_1 ],
#!              deduped_7_1, [ deduped_10_1, AdditionForMorphisms( deduped_42_1, PreCompose( deduped_42_1, deduped_11_1, deduped_19_1 ),
#!                    AdditiveInverseForMorphisms( deduped_42_1, PreCompose( deduped_42_1, ProjectionInFactorOfDirectSum( deduped_42_1, deduped_13_1, 2 ), deduped_39_1 ) )
#!                    ) ] ) ), deduped_17_1, UnderlyingMorphism, PreCompose( deduped_42_1, IdentityMorphism( deduped_42_1, deduped_7_1 ), deduped_11_1 ) ) );
#!     return CreateCapCategoryMorphismWithAttributes( A_1, Source( tau_1 ), CreateCapCategoryObjectWithAttributes( A_1, UnderlyingCell, deduped_1_1 ), UnderlyingCell,
#!        CreateCapCategoryMorphismWithAttributes( deduped_49_1, Source( deduped_51_1 ), deduped_1_1, UnderlyingMorphism, CreateCapCategoryMorphismWithAttributes(
#!            deduped_46_1, deduped_45_1, deduped_17_1, UnderlyingMorphism,
#!            PreCompose( deduped_42_1, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( deduped_42_1, deduped_36_1, deduped_8_1,
#!                ComponentOfMorphismIntoDirectSum( deduped_52_1, Lift( deduped_52_1, UniversalMorphismIntoDirectSum( deduped_52_1,
#!                      [ Range( deduped_2_1 ), Range( deduped_21_1 ) ], deduped_41_1, [ deduped_2_1, deduped_21_1 ] ), MorphismBetweenDirectSums( deduped_52_1,
#!                      deduped_3_1, [ [ HomomorphismStructureOnMorphismsWithGivenObjects( deduped_42_1, deduped_5_1, deduped_31_1, deduped_12_1, deduped_4_1 ),
#!                             HomomorphismStructureOnMorphismsWithGivenObjects( deduped_42_1, deduped_5_1, deduped_31_1, UniversalMorphismFromDirectSum( deduped_42_1,
#!                                  deduped_14_1, deduped_30_1, [ deduped_39_1, deduped_19_1 ] ), deduped_25_1 ) ],
#!                         [ HomomorphismStructureOnMorphismsWithGivenObjects( deduped_42_1, deduped_6_1, deduped_40_1, AdditiveInverseForMorphisms( deduped_42_1,
#!                                  IdentityMorphism( deduped_42_1, deduped_9_1 ) ), deduped_4_1 ), HomomorphismStructureOnMorphismsWithGivenObjects( deduped_42_1,
#!                                deduped_6_1, deduped_32_1, ZeroMorphism( deduped_42_1, deduped_9_1, deduped_30_1 ), deduped_25_1 ) ],
#!                         [ HomomorphismStructureOnMorphismsWithGivenObjects( deduped_42_1, deduped_26_1, deduped_32_1, ZeroMorphism( deduped_42_1, deduped_30_1,
#!                                  deduped_9_1 ), deduped_4_1 ), HomomorphismStructureOnMorphismsWithGivenObjects( deduped_42_1, deduped_26_1, deduped_40_1,
#!                                AdditiveInverseForMorphisms( deduped_42_1, deduped_24_1 ), deduped_25_1 ) ] ], [ deduped_4_1, deduped_25_1 ] ) ), deduped_3_1, 1 ) ),
#!              ProjectionInFactorOfDirectSum( deduped_42_1, deduped_14_1, 2 ) ) ) ) );
#! end


# StopCompilationAtPrimitivelyInstalledOperationsOfCategory( DL );

#! function ( A_1, phi_1, T_1, tau_1 )
#!     local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1,
#!     deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1,
#!     deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1, deduped_31_1, deduped_32_1, deduped_33_1, deduped_34_1,
#!     deduped_35_1, deduped_36_1, deduped_37_1, deduped_38_1, deduped_39_1, deduped_40_1, deduped_41_1, deduped_42_1, deduped_43_1, deduped_44_1, deduped_45_1,
#!     deduped_46_1, deduped_47_1, deduped_48_1, deduped_49_1, deduped_50_1, deduped_51_1, deduped_52_1, deduped_53_1, deduped_54_1, deduped_55_1, deduped_56_1,
#!     deduped_57_1, deduped_58_1, deduped_59_1, deduped_60_1, deduped_61_1, deduped_62_1, deduped_63_1, deduped_64_1, deduped_65_1, deduped_66_1, deduped_67_1;
#!     deduped_67_1 := RangeCategoryOfHomomorphismStructure( A_1 );
#!     deduped_66_1 := UnderlyingCell( tau_1 );
#!     deduped_65_1 := UnderlyingCell( phi_1 );
#!     deduped_64_1 := ModelingCategory( A_1 );
#!     deduped_63_1 := UnderlyingRing( deduped_67_1 );
#!     deduped_62_1 := UnderlyingMorphism( deduped_66_1 );
#!     deduped_61_1 := UnderlyingMorphism( deduped_65_1 );
#!     deduped_60_1 := UnderlyingCategory( deduped_64_1 );
#!     deduped_59_1 := Source( deduped_62_1 );
#!     deduped_58_1 := RelationMorphism( Source( deduped_65_1 ) );
#!     deduped_57_1 := RelationMorphism( Range( deduped_65_1 ) );
#!     deduped_56_1 := UnderlyingCategory( deduped_60_1 );
#!     deduped_55_1 := DistinguishedObjectOfHomomorphismStructure( deduped_56_1 );
#!     deduped_54_1 := CoRelationMorphism( deduped_59_1 );
#!     deduped_53_1 := UnderlyingMorphism( deduped_58_1 );
#!     deduped_52_1 := CoRelationMorphism( Source( deduped_61_1 ) );
#!     deduped_51_1 := Range( deduped_54_1 );
#!     deduped_50_1 := Source( deduped_54_1 );
#!     deduped_49_1 := CoRelationMorphism( Source( deduped_58_1 ) );
#!     deduped_48_1 := Source( deduped_52_1 );
#!     deduped_47_1 := CoRelationMorphism( Source( deduped_57_1 ) );
#!     deduped_46_1 := ZeroMorphism( deduped_56_1, deduped_50_1, deduped_51_1 );
#!     deduped_45_1 := IdentityMorphism( deduped_56_1, deduped_50_1 );
#!     deduped_44_1 := Source( CoRelationMorphism( Range( deduped_58_1 ) ) );
#!     deduped_43_1 := Source( deduped_49_1 );
#!     deduped_42_1 := Range( deduped_49_1 );
#!     deduped_41_1 := Source( deduped_47_1 );
#!     deduped_40_1 := [ deduped_48_1, deduped_41_1 ];
#!     deduped_39_1 := [ Range( deduped_52_1 ), Range( deduped_47_1 ) ];
#!     deduped_38_1 := HomomorphismStructureOnObjects( deduped_56_1, deduped_51_1, deduped_44_1 );
#!     deduped_37_1 := HomomorphismStructureOnObjects( deduped_56_1, deduped_50_1, deduped_44_1 );
#!     deduped_36_1 := IdentityMorphism( deduped_56_1, deduped_44_1 );
#!     deduped_35_1 := IdentityMorphism( deduped_56_1, deduped_43_1 );
#!     deduped_34_1 := DirectSum( deduped_56_1, deduped_40_1 );
#!     deduped_33_1 := UniversalMorphismFromDirectSumWithGivenDirectSum( deduped_56_1, deduped_40_1, deduped_41_1,
#!        [ ZeroMorphism( deduped_56_1, deduped_48_1, deduped_41_1 ), IdentityMorphism( deduped_56_1, deduped_41_1 ) ], deduped_34_1 );
#!     deduped_32_1 := UniversalMorphismFromDirectSumWithGivenDirectSum( deduped_56_1, deduped_40_1, deduped_48_1, [ IdentityMorphism( deduped_56_1, deduped_48_1 ),
#!           ZeroMorphism( deduped_56_1, deduped_41_1, deduped_48_1 ) ], deduped_34_1 );
#!     deduped_31_1 := UniversalMorphismIntoDirectSumWithGivenDirectSum( deduped_56_1, deduped_39_1, deduped_34_1,
#!        [ PreCompose( deduped_56_1, deduped_32_1, deduped_52_1 ), PreCompose( deduped_56_1, deduped_33_1, deduped_47_1 ) ], DirectSum( deduped_56_1, deduped_39_1 ) );
#!     deduped_30_1 := Source( deduped_31_1 );
#!     deduped_29_1 := [ Range( deduped_31_1 ), Source( CoRelationMorphism( Range( deduped_61_1 ) ) ) ];
#!     deduped_28_1 := PreCompose( deduped_56_1, IdentityMorphism( deduped_56_1, deduped_30_1 ), deduped_32_1 );
#!     deduped_27_1 := UniversalMorphismIntoDirectSumWithGivenDirectSum( deduped_56_1, deduped_29_1, deduped_30_1,
#!        [ deduped_31_1, AdditionForMorphisms( deduped_56_1, PreCompose( deduped_56_1, deduped_32_1, UnderlyingMorphism( deduped_61_1 ) ),
#!              AdditiveInverseForMorphisms( deduped_56_1, PreCompose( deduped_56_1, deduped_33_1, UnderlyingMorphism( deduped_57_1 ) ) ) ) ],
#!        DirectSum( deduped_56_1, deduped_29_1 ) );
#!     deduped_26_1 := CreateCapCategoryObjectWithAttributes( deduped_60_1, CoRelationMorphism, deduped_27_1 );
#!     deduped_25_1 := Source( deduped_27_1 );
#!     deduped_24_1 := Range( deduped_27_1 );
#!     deduped_23_1 := [ deduped_43_1, deduped_25_1 ];
#!     deduped_22_1 := [ deduped_42_1, deduped_24_1 ];
#!     deduped_21_1 := [ deduped_25_1, deduped_43_1 ];
#!     deduped_20_1 := [ deduped_24_1, deduped_42_1 ];
#!     deduped_19_1 := ZeroMorphism( deduped_56_1, deduped_25_1, deduped_43_1 );
#!     deduped_18_1 := ZeroMorphism( deduped_56_1, deduped_43_1, deduped_25_1 );
#!     deduped_17_1 := IdentityMorphism( deduped_56_1, deduped_25_1 );
#!     deduped_16_1 := DirectSum( deduped_56_1, deduped_23_1 );
#!     deduped_15_1 := DirectSum( deduped_56_1, deduped_21_1 );
#!     deduped_14_1 := UniversalMorphismFromDirectSumWithGivenDirectSum( deduped_56_1, deduped_23_1, deduped_25_1, [ deduped_18_1, deduped_17_1 ], deduped_16_1 );
#!     deduped_13_1 := UniversalMorphismFromDirectSumWithGivenDirectSum( deduped_56_1, deduped_21_1, deduped_43_1, [ deduped_19_1, deduped_35_1 ], deduped_15_1 );
#!     deduped_12_1 := UniversalMorphismFromDirectSumWithGivenDirectSum( deduped_56_1, deduped_21_1, deduped_25_1, [ deduped_17_1, deduped_18_1 ], deduped_15_1 );
#!     deduped_11_1 := UniversalMorphismIntoDirectSumWithGivenDirectSum( deduped_56_1, deduped_22_1, deduped_16_1,
#!        [ PreCompose( deduped_56_1, UniversalMorphismFromDirectSumWithGivenDirectSum( deduped_56_1, deduped_23_1, deduped_43_1, [ deduped_35_1, deduped_19_1 ],
#!                deduped_16_1 ), deduped_49_1 ), PreCompose( deduped_56_1, deduped_14_1, deduped_27_1 ) ], DirectSum( deduped_56_1, deduped_22_1 ) );
#!     deduped_10_1 := UniversalMorphismIntoDirectSumWithGivenDirectSum( deduped_56_1, deduped_20_1, deduped_15_1,
#!        [ PreCompose( deduped_56_1, deduped_12_1, deduped_27_1 ), PreCompose( deduped_56_1, deduped_13_1, deduped_49_1 ) ], DirectSum( deduped_56_1, deduped_20_1 ) );
#!     deduped_9_1 := Range( deduped_11_1 );
#!     deduped_8_1 := Source( deduped_11_1 );
#!     deduped_7_1 := Source( deduped_10_1 );
#!     deduped_6_1 := [ Range( deduped_10_1 ), deduped_48_1 ];
#!     deduped_5_1 := HomomorphismStructureOnObjects( deduped_56_1, deduped_51_1, deduped_9_1 );
#!     deduped_4_1 := HomomorphismStructureOnObjects( deduped_56_1, deduped_50_1, deduped_9_1 );
#!     deduped_3_1 := HomomorphismStructureOnObjects( deduped_56_1, deduped_50_1, deduped_8_1 );
#!     deduped_2_1 := RankOfObject( deduped_3_1 );
#!     deduped_1_1 := CreateCapCategoryObjectWithAttributes( deduped_64_1, RelationMorphism, CreateCapCategoryMorphismWithAttributes( deduped_60_1,
#!          CreateCapCategoryObjectWithAttributes( deduped_60_1, CoRelationMorphism, UniversalMorphismIntoDirectSumWithGivenDirectSum( deduped_56_1, deduped_6_1,
#!              deduped_7_1, [ deduped_10_1, AdditionForMorphisms( deduped_56_1, PreCompose( deduped_56_1, deduped_12_1, deduped_28_1 ),
#!                    AdditiveInverseForMorphisms( deduped_56_1, PreCompose( deduped_56_1, deduped_13_1, deduped_53_1 ) ) ) ], DirectSum( deduped_56_1, deduped_6_1 ) ) ),
#!          deduped_26_1, UnderlyingMorphism, PreCompose( deduped_56_1, IdentityMorphism( deduped_56_1, deduped_7_1 ), deduped_12_1 ) ) );
#!     return CreateCapCategoryMorphismWithAttributes( A_1, Source( tau_1 ), CreateCapCategoryObjectWithAttributes( A_1, UnderlyingCell, deduped_1_1 ), UnderlyingCell,
#!        CreateCapCategoryMorphismWithAttributes( deduped_64_1, Source( deduped_66_1 ), deduped_1_1, UnderlyingMorphism, CreateCapCategoryMorphismWithAttributes(
#!            deduped_60_1, deduped_59_1, deduped_26_1, UnderlyingMorphism,
#!            PreCompose( deduped_56_1, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( deduped_56_1, deduped_50_1, deduped_8_1,
#!                CreateCapCategoryMorphismWithAttributes( deduped_67_1, deduped_55_1, deduped_3_1, UnderlyingMatrix,
#!                  CertainColumns( SafeRightDivide( UnionOfColumns( deduped_63_1, RankOfObject( deduped_55_1 ),
#!                        [ UnderlyingMatrix( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( deduped_56_1, deduped_55_1,
#!                                ZeroMorphism( deduped_56_1, deduped_50_1, deduped_9_1 ), deduped_4_1 ) ),
#!                           UnderlyingMatrix( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( deduped_56_1, deduped_55_1,
#!                                PreCompose( deduped_56_1, UnderlyingMorphism( deduped_62_1 ), deduped_36_1 ), deduped_37_1 ) ) ] ),
#!                      UnionOfRows( deduped_63_1, Sum( [ RankOfObject( deduped_4_1 ), RankOfObject( deduped_37_1 ) ] ),
#!                        [
#!                           UnionOfColumns( deduped_63_1, deduped_2_1,
#!                              [ UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_56_1, deduped_3_1, deduped_45_1, deduped_11_1, deduped_4_1 ) )
#!                                   , UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_56_1, deduped_3_1, deduped_45_1,
#!                                      UniversalMorphismFromDirectSumWithGivenDirectSum( deduped_56_1, deduped_23_1, deduped_44_1, [ deduped_53_1, deduped_28_1 ],
#!                                        deduped_16_1 ), deduped_37_1 ) ) ] ), UnionOfColumns( deduped_63_1, RankOfObject( deduped_5_1 ),
#!                              [ UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_56_1, deduped_5_1, deduped_54_1,
#!                                      AdditiveInverseForMorphisms( deduped_56_1, IdentityMorphism( deduped_56_1, deduped_9_1 ) ), deduped_4_1 ) ),
#!                                 UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_56_1, deduped_5_1, deduped_46_1,
#!                                      ZeroMorphism( deduped_56_1, deduped_9_1, deduped_44_1 ), deduped_37_1 ) ) ] ),
#!                           UnionOfColumns( deduped_63_1, RankOfObject( deduped_38_1 ),
#!                              [ UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_56_1, deduped_38_1, deduped_46_1,
#!                                      ZeroMorphism( deduped_56_1, deduped_44_1, deduped_9_1 ), deduped_4_1 ) ),
#!                                 UnderlyingMatrix( HomomorphismStructureOnMorphismsWithGivenObjects( deduped_56_1, deduped_38_1, deduped_54_1,
#!                                      AdditiveInverseForMorphisms( deduped_56_1, deduped_36_1 ), deduped_37_1 ) ) ] ) ] ) ), [ 1 .. deduped_2_1 ] ) ) ), deduped_14_1 ) )
#!          ) );
#! end
