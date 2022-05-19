# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_MeetSemilatticeOfMultipleDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled", function ( cat )
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, objects_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingCategory( cat_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, PreMinuendAndSubtrahendsInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_1_1, UnderlyingColumn, UnionOfRows( UnderlyingRing( deduped_1_1 ), RankOfObject( BaseObject( deduped_1_1 ) ), List( objects_1, function ( logic_new_func_x_2 )
                    return UnderlyingColumn( MinuendAndSubtrahendsInUnderlyingLattice( logic_new_func_x_2 )[1] );
                end ) ) ), Concatenation( List( objects_1, function ( logic_new_func_x_2 )
                  return MinuendAndSubtrahendsInUnderlyingLattice( logic_new_func_x_2 )[2];
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
    return CreateCapCategoryObjectWithAttributes( cat_1, PreMinuendAndSubtrahendsInUnderlyingLattice, NTuple( 2, deduped_1_1, [ deduped_1_1 ] ), IsLocallyClosed, true );
end
########
        
    , 100 );
    
    ##
    AddIsHomSetInhabited( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := MinuendAndSubtrahendsInUnderlyingLattice( arg3_1 );
    deduped_17_1 := MinuendAndSubtrahendsInUnderlyingLattice( arg2_1 );
    deduped_16_1 := UnderlyingCategory( cat_1 );
    deduped_15_1 := UnderlyingRing( deduped_16_1 );
    deduped_14_1 := List( deduped_17_1[2], UnderlyingColumn );
    deduped_13_1 := UnderlyingColumn( deduped_17_1[1] );
    deduped_12_1 := RankOfObject( BaseObject( deduped_16_1 ) );
    deduped_11_1 := HomalgIdentityMatrix( 1, deduped_15_1 );
    deduped_10_1 := Iterated( Concatenation( deduped_14_1, [ UnderlyingColumn( deduped_18_1[1] ) ] ), function ( I_2, J_2 )
            return SyzygiesOfRows( I_2, J_2 ) * I_2;
        end );
    deduped_9_1 := Iterated( Concatenation( deduped_14_1, [ HomalgIdentityMatrix( deduped_12_1, deduped_15_1 ) ] ), function ( I_2, J_2 )
            return SyzygiesOfRows( I_2, J_2 ) * I_2;
        end );
    hoisted_4_1 := TransposedMatrix( deduped_9_1 );
    hoisted_3_1 := HomalgIdentityMatrix( NumberRows( deduped_9_1 ), deduped_15_1 );
    hoisted_2_1 := TransposedMatrix( deduped_10_1 );
    hoisted_1_1 := HomalgIdentityMatrix( NumberRows( deduped_10_1 ), deduped_15_1 );
    return IsZero( DecideZeroRows( deduped_11_1, CapFixpoint( function ( x_2, y_2 )
                  return IsZero( DecideZeroRows( y_2, x_2 ) );
              end, function ( x_2 )
                  return SyzygiesOfRows( hoisted_2_1, KroneckerMat( hoisted_1_1, x_2 ) );
              end, UnionOfRows( deduped_15_1, deduped_12_1, [ deduped_13_1, HomalgZeroMatrix( 0, deduped_12_1, deduped_15_1 ) ] ) ) ) ) and ForAll( deduped_18_1[2], function ( s_2 )
              return IsZero( DecideZeroRows( deduped_11_1, CapFixpoint( function ( x_3, y_3 )
                          return IsZero( DecideZeroRows( y_3, x_3 ) );
                      end, function ( x_3 )
                          return SyzygiesOfRows( hoisted_4_1, KroneckerMat( hoisted_3_1, x_3 ) );
                      end, UnionOfRows( deduped_15_1, deduped_12_1, [ deduped_13_1, UnderlyingColumn( s_2 ) ] ) ) ) );
          end );
end
########
        
    , 100 );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := MinuendAndSubtrahendsInUnderlyingLattice( arg2_1 );
    deduped_4_1 := UnderlyingRing( UnderlyingCategory( cat_1 ) );
    deduped_3_1 := Iterated( List( deduped_5_1[2], UnderlyingColumn ), function ( I_2, J_2 )
            return SyzygiesOfRows( I_2, J_2 ) * I_2;
        end );
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
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingCategory( cat_1 );
    deduped_6_1 := MinuendAndSubtrahendsInUnderlyingLattice( arg2_1 );
    deduped_5_1 := deduped_6_1[2];
    deduped_4_1 := deduped_6_1[1];
    deduped_3_1 := 1 = RankOfObject( BaseObject( deduped_7_1 ) );
    return IS_IDENTICAL_OBJ( CapCategory( deduped_4_1 ), deduped_7_1 ) and ForAll( deduped_5_1, function ( s_2 )
                  return IS_IDENTICAL_OBJ( CapCategory( s_2 ), deduped_7_1 );
              end ) and (deduped_3_1 and IdFunc( function (  )
                    if NumberColumns( UnderlyingColumn( deduped_4_1 ) ) <> 1 then
                        return false;
                    else
                        return true;
                    fi;
                    return;
                end )(  )) and ForAll( deduped_5_1, function ( s_2 )
              return (deduped_3_1 and IdFunc( function (  )
                          if NumberColumns( UnderlyingColumn( s_2 ) ) <> 1 then
                              return false;
                          else
                              return true;
                          fi;
                          return;
                      end )(  ));
          end );
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
    return CreateCapCategoryObjectWithAttributes( cat_1, PreMinuendAndSubtrahendsInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_3_1, UnderlyingColumn, HomalgZeroMatrix( 0, deduped_1_1, deduped_2_1 ) ), [ CreateCapCategoryObjectWithAttributes( deduped_3_1, UnderlyingColumn, HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) ) ] ), IsLocallyClosed, true );
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

BindGlobal( "MeetSemilatticeOfMultipleDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled", function ( R )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( R )
    local ZC;
    ZC := ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows( R : FinalizeCategory := true );
    return MeetSemilatticeOfMultipleDifferences( ZC );
end;
        
        
    
    cat := category_constructor( R : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_MeetSemilatticeOfMultipleDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
