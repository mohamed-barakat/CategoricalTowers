# SPDX-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfBimonoidsAsComonoidsOfMonoidsPrecompiled", function ( cat )
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingCategory( cat_1 );
    deduped_3_1 := TensorUnit( deduped_4_1 );
    deduped_2_1 := TensorProductOnObjects( deduped_4_1, deduped_3_1, deduped_3_1 );
    deduped_1_1 := IdentityMorphism( deduped_4_1, deduped_3_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, DefiningQuintupleOfInternalBimonoid, NTuple( 5, deduped_3_1, deduped_1_1, LeftUnitorWithGivenTensorProduct( deduped_4_1, deduped_3_1, deduped_2_1 ), deduped_1_1, LeftUnitorInverseWithGivenTensorProduct( deduped_4_1, deduped_3_1, deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1, deduped_31_1, deduped_32_1, deduped_33_1, deduped_34_1, deduped_35_1, deduped_36_1, deduped_37_1, deduped_38_1, deduped_39_1, deduped_40_1, deduped_41_1, deduped_42_1;
    deduped_42_1 := DefiningQuintupleOfInternalBimonoid( arg3_1 );
    deduped_41_1 := DefiningQuintupleOfInternalBimonoid( arg2_1 );
    deduped_40_1 := UnderlyingCategory( cat_1 );
    deduped_39_1 := deduped_42_1[5];
    deduped_38_1 := deduped_41_1[5];
    deduped_37_1 := deduped_42_1[4];
    deduped_36_1 := deduped_41_1[4];
    deduped_35_1 := deduped_42_1[3];
    deduped_34_1 := deduped_41_1[3];
    deduped_33_1 := deduped_42_1[2];
    deduped_32_1 := deduped_41_1[2];
    deduped_31_1 := TensorUnit( deduped_40_1 );
    deduped_30_1 := deduped_42_1[1];
    deduped_29_1 := deduped_41_1[1];
    deduped_28_1 := TensorProductOnObjects( deduped_40_1, deduped_29_1, deduped_29_1 );
    deduped_27_1 := IdentityMorphism( deduped_40_1, deduped_29_1 );
    deduped_26_1 := IdentityMorphism( deduped_40_1, deduped_30_1 );
    deduped_25_1 := TensorProductOnObjects( deduped_40_1, deduped_30_1, deduped_29_1 );
    deduped_24_1 := TensorProductOnObjects( deduped_40_1, deduped_31_1, deduped_31_1 );
    deduped_23_1 := TensorProductOnObjects( deduped_40_1, deduped_29_1, deduped_30_1 );
    deduped_22_1 := BraidingInverseWithGivenTensorProducts( deduped_40_1, deduped_23_1, deduped_30_1, deduped_29_1, deduped_25_1 );
    deduped_21_1 := IdentityMorphism( deduped_40_1, deduped_23_1 );
    deduped_20_1 := TensorProductOnObjects( deduped_40_1, deduped_28_1, TensorProductOnObjects( deduped_40_1, deduped_30_1, deduped_30_1 ) );
    deduped_19_1 := TensorProductOnObjects( deduped_40_1, deduped_28_1, deduped_30_1 );
    deduped_18_1 := TensorProductOnObjects( deduped_40_1, deduped_29_1, deduped_23_1 );
    deduped_17_1 := Range( deduped_27_1 );
    deduped_16_1 := BraidingWithGivenTensorProducts( deduped_40_1, deduped_25_1, deduped_30_1, deduped_29_1, deduped_23_1 );
    deduped_15_1 := Source( deduped_27_1 );
    deduped_14_1 := Range( deduped_26_1 );
    deduped_13_1 := Source( deduped_26_1 );
    deduped_12_1 := TensorProductOnObjects( deduped_40_1, deduped_29_1, deduped_25_1 );
    deduped_11_1 := TensorProductOnObjects( deduped_40_1, deduped_23_1, deduped_29_1 );
    deduped_10_1 := TensorProductOnObjects( deduped_40_1, deduped_23_1, deduped_23_1 );
    deduped_9_1 := AssociatorRightToLeftWithGivenTensorProducts( deduped_40_1, deduped_12_1, deduped_29_1, deduped_30_1, deduped_29_1, deduped_11_1 );
    deduped_8_1 := AssociatorLeftToRightWithGivenTensorProducts( deduped_40_1, deduped_19_1, deduped_29_1, deduped_29_1, deduped_30_1, deduped_18_1 );
    deduped_7_1 := TensorProductOnObjects( deduped_40_1, deduped_19_1, deduped_30_1 );
    deduped_6_1 := AssociatorRightToLeftWithGivenTensorProducts( deduped_40_1, deduped_18_1, deduped_29_1, deduped_29_1, deduped_30_1, deduped_19_1 );
    deduped_5_1 := AssociatorLeftToRightWithGivenTensorProducts( deduped_40_1, deduped_11_1, deduped_29_1, deduped_30_1, deduped_29_1, deduped_12_1 );
    deduped_4_1 := TensorProductOnObjects( deduped_40_1, deduped_11_1, deduped_30_1 );
    deduped_3_1 := IdentityMorphism( deduped_40_1, deduped_10_1 );
    deduped_2_1 := TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, deduped_15_1, Source( deduped_22_1 ) ), deduped_27_1, deduped_22_1, TensorProductOnObjects( deduped_40_1, deduped_17_1, Range( deduped_22_1 ) ) );
    deduped_1_1 := TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, deduped_15_1, Source( deduped_16_1 ) ), deduped_27_1, deduped_16_1, TensorProductOnObjects( deduped_40_1, deduped_17_1, Range( deduped_16_1 ) ) );
    return CreateCapCategoryObjectWithAttributes( cat_1, DefiningQuintupleOfInternalBimonoid, NTuple( 5, deduped_23_1, PreCompose( deduped_40_1, LeftUnitorInverseWithGivenTensorProduct( deduped_40_1, deduped_31_1, deduped_24_1 ), TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_32_1 ), Source( deduped_33_1 ) ), deduped_32_1, deduped_33_1, TensorProductOnObjects( deduped_40_1, Range( deduped_32_1 ), Range( deduped_33_1 ) ) ) ), PreCompose( deduped_40_1, PreCompose( deduped_40_1, PreCompose( deduped_40_1, PreCompose( deduped_40_1, PreCompose( deduped_40_1, PreCompose( deduped_40_1, PreCompose( deduped_40_1, deduped_3_1, AssociatorRightToLeftWithGivenTensorProducts( deduped_40_1, deduped_10_1, deduped_23_1, deduped_29_1, deduped_30_1, deduped_4_1 ) ), TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_5_1 ), deduped_13_1 ), deduped_5_1, deduped_26_1, TensorProductOnObjects( deduped_40_1, Range( deduped_5_1 ), deduped_14_1 ) ) ), TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_1_1 ), deduped_13_1 ), deduped_1_1, deduped_26_1, TensorProductOnObjects( deduped_40_1, Range( deduped_1_1 ), deduped_14_1 ) ) ), TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_6_1 ), deduped_13_1 ), deduped_6_1, deduped_26_1, TensorProductOnObjects( deduped_40_1, Range( deduped_6_1 ), deduped_14_1 ) ) ), AssociatorLeftToRightWithGivenTensorProducts( deduped_40_1, deduped_7_1, deduped_28_1, deduped_30_1, deduped_30_1, deduped_20_1 ) ), TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_34_1 ), Source( deduped_35_1 ) ), deduped_34_1, deduped_35_1, TensorProductOnObjects( deduped_40_1, Range( deduped_34_1 ), Range( deduped_35_1 ) ) ) ), deduped_21_1 ), PreCompose( deduped_40_1, TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_36_1 ), Source( deduped_37_1 ) ), deduped_36_1, deduped_37_1, TensorProductOnObjects( deduped_40_1, Range( deduped_36_1 ), Range( deduped_37_1 ) ) ), LeftUnitorWithGivenTensorProduct( deduped_40_1, deduped_31_1, deduped_24_1 ) ), PreCompose( deduped_40_1, deduped_21_1, PreCompose( deduped_40_1, TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_38_1 ), Source( deduped_39_1 ) ), deduped_38_1, deduped_39_1, TensorProductOnObjects( deduped_40_1, Range( deduped_38_1 ), Range( deduped_39_1 ) ) ), PreCompose( deduped_40_1, AssociatorRightToLeftWithGivenTensorProducts( deduped_40_1, deduped_20_1, deduped_28_1, deduped_30_1, deduped_30_1, deduped_7_1 ), PreCompose( deduped_40_1, TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_8_1 ), deduped_13_1 ), deduped_8_1, deduped_26_1, TensorProductOnObjects( deduped_40_1, Range( deduped_8_1 ), deduped_14_1 ) ), PreCompose( deduped_40_1, TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_2_1 ), deduped_13_1 ), deduped_2_1, deduped_26_1, TensorProductOnObjects( deduped_40_1, Range( deduped_2_1 ), deduped_14_1 ) ), PreCompose( deduped_40_1, TensorProductOnMorphismsWithGivenTensorProducts( deduped_40_1, TensorProductOnObjects( deduped_40_1, Source( deduped_9_1 ), deduped_13_1 ), deduped_9_1, deduped_26_1, TensorProductOnObjects( deduped_40_1, Range( deduped_9_1 ), deduped_14_1 ) ), PreCompose( deduped_40_1, AssociatorLeftToRightWithGivenTensorProducts( deduped_40_1, deduped_4_1, deduped_23_1, deduped_29_1, deduped_30_1, deduped_10_1 ), deduped_3_1 ) ) ) ) ) ) ) ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "CategoryOfBimonoidsAsComonoidsOfMonoidsPrecompiled", function ( symmoncat )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( symmoncat )
    return CATEGORY_OF_BIMONOIDS_AS_COMONOIDS_OF_MONOIDS( symmoncat );
end;
        
        
    
    cat := category_constructor( symmoncat : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfBimonoidsAsComonoidsOfMonoidsPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
