# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_MeetSemilatticeOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled", function ( cat )
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, objects_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingCategory( cat_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_1_1, UnderlyingColumn, UnionOfRows( UnderlyingRing( deduped_1_1 ), RankOfObject( BaseObject( deduped_1_1 ) ), List( objects_1, function ( logic_new_func_x_2 )
                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_2 )[1] );
                end ) ) ), CreateCapCategoryObjectWithAttributes( deduped_1_1, UnderlyingColumn, Iterated( List( objects_1, function ( logic_new_func_x_2 )
                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_2 )[2] );
                end ), function ( I_2, J_2 )
                  return SyzygiesOfRows( I_2, J_2 ) * I_2;
              end ) ) ), IsLocallyClosed, true );
end
########
        
    , 100 );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingCategory( cat_1 );
    deduped_1_1 := CreateCapCategoryObjectWithAttributes( deduped_2_1, UnderlyingColumn, HomalgIdentityMatrix( RankOfObject( BaseObject( deduped_2_1 ) ), UnderlyingRing( deduped_2_1 ) ) );
    return CreateCapCategoryObjectWithAttributes( cat_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, deduped_1_1, deduped_1_1 ), IsLocallyClosed, true );
end
########
        
    , 100 );
    
    ##
    AddIsHomSetInhabited( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := MinuendAndSubtrahendInUnderlyingLattice( arg3_1 );
    deduped_11_1 := MinuendAndSubtrahendInUnderlyingLattice( arg2_1 );
    deduped_10_1 := UnderlyingCategory( cat_1 );
    deduped_9_1 := UnderlyingRing( deduped_10_1 );
    deduped_8_1 := UnderlyingColumn( deduped_11_1[2] );
    deduped_7_1 := UnderlyingColumn( deduped_11_1[1] );
    deduped_6_1 := HomalgIdentityMatrix( 1, deduped_9_1 );
    deduped_5_1 := SyzygiesOfRows( deduped_8_1, UnderlyingColumn( deduped_12_1[1] ) ) * deduped_8_1;
    hoisted_4_1 := TransposedMatrix( deduped_8_1 );
    hoisted_3_1 := HomalgIdentityMatrix( NumberRows( deduped_8_1 ), deduped_9_1 );
    hoisted_2_1 := TransposedMatrix( deduped_5_1 );
    hoisted_1_1 := HomalgIdentityMatrix( NumberRows( deduped_5_1 ), deduped_9_1 );
    return IsZero( DecideZeroRows( deduped_6_1, CapFixpoint( function ( x_2, y_2 )
                  return IsZero( DecideZeroRows( y_2, x_2 ) );
              end, function ( x_2 )
                  return SyzygiesOfRows( hoisted_2_1, KroneckerMat( hoisted_1_1, x_2 ) );
              end, deduped_7_1 ) ) ) and IsZero( DecideZeroRows( deduped_6_1, CapFixpoint( function ( x_2, y_2 )
                  return IsZero( DecideZeroRows( y_2, x_2 ) );
              end, function ( x_2 )
                  return SyzygiesOfRows( hoisted_4_1, KroneckerMat( hoisted_3_1, x_2 ) );
              end, UnionOfRows( deduped_9_1, RankOfObject( BaseObject( deduped_10_1 ) ), [ deduped_7_1, UnderlyingColumn( deduped_12_1[2] ) ] ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := MinuendAndSubtrahendInUnderlyingLattice( arg2_1 );
    deduped_4_1 := UnderlyingRing( UnderlyingCategory( cat_1 ) );
    deduped_3_1 := UnderlyingColumn( deduped_5_1[2] );
    hoisted_2_1 := TransposedMatrix( deduped_3_1 );
    hoisted_1_1 := HomalgIdentityMatrix( NumberRows( deduped_3_1 ), deduped_4_1 );
    return IsZero( DecideZeroRows( HomalgIdentityMatrix( 1, deduped_4_1 ), CapFixpoint( function ( x_2, y_2 )
                return IsZero( DecideZeroRows( y_2, x_2 ) );
            end, function ( x_2 )
                return SyzygiesOfRows( hoisted_2_1, KroneckerMat( hoisted_1_1, x_2 ) );
            end, UnderlyingColumn( deduped_5_1[1] ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingCategory( cat_1 );
    deduped_4_1 := MinuendAndSubtrahendInUnderlyingLattice( arg2_1 );
    deduped_3_1 := deduped_4_1[2];
    deduped_2_1 := deduped_4_1[1];
    deduped_1_1 := 1 = RankOfObject( BaseObject( deduped_5_1 ) );
    return IS_IDENTICAL_OBJ( CapCategory( deduped_2_1 ), deduped_5_1 ) and IS_IDENTICAL_OBJ( CapCategory( deduped_3_1 ), deduped_5_1 ) and (deduped_1_1 and IdFunc( function (  )
                    if NumberColumns( UnderlyingColumn( deduped_2_1 ) ) <> 1 then
                        return false;
                    else
                        return true;
                    fi;
                    return;
                end )(  )) and (deduped_1_1 and IdFunc( function (  )
                  if NumberColumns( UnderlyingColumn( deduped_3_1 ) ) <> 1 then
                      return false;
                  else
                      return true;
                  fi;
                  return;
              end )(  ));
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, PreMinuendAndSubtrahendInUnderlyingLattice, arg2_1, IsLocallyClosed, true );
end
########
        
    , 100 );
    
    ##
    AddTerminalObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingCategory( cat_1 );
    deduped_2_1 := UnderlyingRing( deduped_3_1 );
    deduped_1_1 := RankOfObject( BaseObject( deduped_3_1 ) );
    return CreateCapCategoryObjectWithAttributes( cat_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_3_1, UnderlyingColumn, HomalgZeroMatrix( 0, deduped_1_1, deduped_2_1 ) ), CreateCapCategoryObjectWithAttributes( deduped_3_1, UnderlyingColumn, HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) ) ), IsLocallyClosed, true );
end
########
        
    , 100 );
    
    ##
    AddUniqueMorphism( cat,
        
########
function ( cat_1, A_1, B_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, B_1 );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "MeetSemilatticeOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled", function ( R )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( R )
    local ZC;
    ZC := ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows( R : FinalizeCategory := true );
    return MeetSemilatticeOfSingleDifferences( ZC );
end;
        
        
    
    cat := category_constructor( R : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_MeetSemilatticeOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
