# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled", function ( cat )
    
    ##
    AddCoexponentialOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    local hoisted_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingMeetSemilatticeOfDifferences( cat_1 );
    deduped_10_1 := UnderlyingCategory( cat_1 );
    deduped_9_1 := UnderlyingRing( deduped_10_1 );
    deduped_8_1 := RankOfObject( BaseObject( deduped_10_1 ) );
    hoisted_7_1 := HomalgIdentityMatrix( 1, deduped_9_1 );
    hoisted_6_1 := CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, [ CreateCapCategoryObjectWithAttributes( deduped_11_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_10_1, UnderlyingColumn, HomalgZeroMatrix( 0, deduped_8_1, deduped_9_1 ) ), CreateCapCategoryObjectWithAttributes( deduped_10_1, UnderlyingColumn, HomalgIdentityMatrix( deduped_8_1, deduped_9_1 ) ) ), IsLocallyClosed, true ) ] );
    hoisted_5_1 := ListOfPreObjectsInMeetSemilatticeOfDifferences( b_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, Filtered( Concatenation( List( ListOfPreObjectsInMeetSemilatticeOfDifferences( a_1 ), function ( A_i_2 )
                  local deduped_1_2, hoisted_3_2, deduped_5_2, deduped_6_2, deduped_7_2;
                  deduped_7_2 := MinuendAndSubtrahendInUnderlyingLattice( A_i_2 );
                  deduped_6_2 := deduped_7_2[1];
                  deduped_5_2 := deduped_7_2[2];
                  hoisted_3_2 := UnderlyingColumn( deduped_6_2 );
                  deduped_1_2 := UnderlyingColumn( deduped_5_2 );
                  return ListOfObjectsInMeetSemilatticeOfDifferences( Iterated( List( hoisted_5_1, function ( B_j_3 )
                              local deduped_1_3;
                              deduped_1_3 := MinuendAndSubtrahendInUnderlyingLattice( B_j_3 );
                              return CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, [ CreateCapCategoryObjectWithAttributes( deduped_11_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, deduped_6_2, CreateCapCategoryObjectWithAttributes( deduped_10_1, UnderlyingColumn, SyzygiesOfRows( deduped_1_2, UnderlyingColumn( deduped_1_3[1] ) ) * deduped_1_2 ) ), IsLocallyClosed, true ), CreateCapCategoryObjectWithAttributes( deduped_11_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_10_1, UnderlyingColumn, UnionOfRows( deduped_9_1, deduped_8_1, [ hoisted_3_2, UnderlyingColumn( deduped_1_3[2] ) ] ) ), deduped_5_2 ), IsLocallyClosed, true ) ] );
                          end ), function ( A_3, B_3 )
                            local hoisted_1_3, hoisted_2_3, hoisted_3_3, hoisted_4_3, deduped_5_3, deduped_6_3;
                            deduped_6_3 := ListOfObjectsInMeetSemilatticeOfDifferences( B_3 );
                            deduped_5_3 := ListOfObjectsInMeetSemilatticeOfDifferences( A_3 );
                            hoisted_4_3 := List( deduped_6_3, function ( logic_new_func_x_4 )
                                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_4 )[2] );
                                end );
                            hoisted_3_3 := List( deduped_5_3, function ( logic_new_func_x_4 )
                                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_4 )[2] );
                                end );
                            hoisted_2_3 := List( deduped_6_3, function ( logic_new_func_x_4 )
                                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_4 )[1] );
                                end );
                            hoisted_1_3 := List( deduped_5_3, function ( logic_new_func_x_4 )
                                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_4 )[1] );
                                end );
                            return CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, List( Cartesian( [ [ 1 .. Length( deduped_5_3 ) ], [ 1 .. Length( deduped_6_3 ) ] ] ), function ( i_4 )
                                      local deduped_1_4, deduped_2_4, deduped_3_4;
                                      deduped_3_4 := i_4[2];
                                      deduped_2_4 := i_4[1];
                                      deduped_1_4 := hoisted_3_3[deduped_2_4];
                                      return CreateCapCategoryObjectWithAttributes( deduped_11_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_10_1, UnderlyingColumn, UnionOfRows( deduped_9_1, deduped_8_1, [ hoisted_1_3[deduped_2_4], hoisted_2_3[deduped_3_4] ] ) ), CreateCapCategoryObjectWithAttributes( deduped_10_1, UnderlyingColumn, SyzygiesOfRows( deduped_1_4, hoisted_4_3[deduped_3_4] ) * deduped_1_4 ) ), IsLocallyClosed, true );
                                  end ) );
                        end, hoisted_6_1 ) );
              end ) ), function ( d_2 )
              local hoisted_1_2, hoisted_2_2, deduped_3_2, deduped_4_2;
              deduped_4_2 := MinuendAndSubtrahendInUnderlyingLattice( d_2 );
              deduped_3_2 := UnderlyingColumn( deduped_4_2[2] );
              hoisted_2_2 := TransposedMatrix( deduped_3_2 );
              hoisted_1_2 := HomalgIdentityMatrix( NumberRows( deduped_3_2 ), deduped_9_1 );
              return not IsZero( DecideZeroRows( hoisted_7_1, CapFixpoint( function ( x_3, y_3 )
                             return IsZero( DecideZeroRows( y_3, x_3 ) );
                         end, function ( x_3 )
                             return SyzygiesOfRows( hoisted_2_2, KroneckerMat( hoisted_1_2, x_3 ) );
                         end, UnderlyingColumn( deduped_4_2[1] ) ) ) );
          end ) );
end
########
        
    , 100 );
    
    ##
    AddCoproduct( cat,
        
########
function ( cat_1, objects_1 )
    local hoisted_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( UnderlyingCategory( cat_1 ) );
    hoisted_2_1 := HomalgIdentityMatrix( 1, deduped_3_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, Filtered( Concatenation( List( objects_1, ListOfObjectsInMeetSemilatticeOfDifferences ) ), function ( d_2 )
              local hoisted_1_2, hoisted_2_2, deduped_3_2, deduped_4_2;
              deduped_4_2 := MinuendAndSubtrahendInUnderlyingLattice( d_2 );
              deduped_3_2 := UnderlyingColumn( deduped_4_2[2] );
              hoisted_2_2 := TransposedMatrix( deduped_3_2 );
              hoisted_1_2 := HomalgIdentityMatrix( NumberRows( deduped_3_2 ), deduped_3_1 );
              return not IsZero( DecideZeroRows( hoisted_2_1, CapFixpoint( function ( x_3, y_3 )
                             return IsZero( DecideZeroRows( y_3, x_3 ) );
                         end, function ( x_3 )
                             return SyzygiesOfRows( hoisted_2_2, KroneckerMat( hoisted_1_2, x_3 ) );
                         end, UnderlyingColumn( deduped_4_2[1] ) ) ) );
          end ) );
end
########
        
    , 100 );
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, objects_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingCategory( cat_1 );
    deduped_7_1 := UnderlyingMeetSemilatticeOfDifferences( cat_1 );
    deduped_6_1 := UnderlyingRing( deduped_8_1 );
    deduped_5_1 := RankOfObject( BaseObject( deduped_8_1 ) );
    return Iterated( objects_1, function ( A_2, B_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, deduped_5_2, deduped_6_2;
            deduped_6_2 := ListOfObjectsInMeetSemilatticeOfDifferences( B_2 );
            deduped_5_2 := ListOfObjectsInMeetSemilatticeOfDifferences( A_2 );
            hoisted_4_2 := List( deduped_6_2, function ( logic_new_func_x_3 )
                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_3 )[2] );
                end );
            hoisted_3_2 := List( deduped_5_2, function ( logic_new_func_x_3 )
                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_3 )[2] );
                end );
            hoisted_2_2 := List( deduped_6_2, function ( logic_new_func_x_3 )
                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_3 )[1] );
                end );
            hoisted_1_2 := List( deduped_5_2, function ( logic_new_func_x_3 )
                    return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_3 )[1] );
                end );
            return CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, List( Cartesian( [ [ 1 .. Length( deduped_5_2 ) ], [ 1 .. Length( deduped_6_2 ) ] ] ), function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3;
                      deduped_3_3 := i_3[2];
                      deduped_2_3 := i_3[1];
                      deduped_1_3 := hoisted_3_2[deduped_2_3];
                      return CreateCapCategoryObjectWithAttributes( deduped_7_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_8_1, UnderlyingColumn, UnionOfRows( deduped_6_1, deduped_5_1, [ hoisted_1_2[deduped_2_3], hoisted_2_2[deduped_3_3] ] ) ), CreateCapCategoryObjectWithAttributes( deduped_8_1, UnderlyingColumn, SyzygiesOfRows( deduped_1_3, hoisted_4_2[deduped_3_3] ) * deduped_1_3 ) ), IsLocallyClosed, true );
                  end ) );
        end, CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, [ CreateCapCategoryObjectWithAttributes( deduped_7_1, PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_8_1, UnderlyingColumn, HomalgZeroMatrix( 0, deduped_5_1, deduped_6_1 ) ), CreateCapCategoryObjectWithAttributes( deduped_8_1, UnderlyingColumn, HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ) ) ), IsLocallyClosed, true ) ] ) );
end
########
        
    , 100 );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, [  ] );
end
########
        
    , 100 );
    
    ##
    AddIsHomSetInhabited( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, hoisted_2_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingCategory( cat_1 );
    deduped_9_1 := Length( arg3_1 );
    deduped_8_1 := UnderlyingRing( deduped_10_1 );
    hoisted_7_1 := [ 0 .. deduped_9_1 ];
    hoisted_6_1 := HomalgIdentityMatrix( 1, deduped_8_1 );
    hoisted_5_1 := RankOfObject( BaseObject( deduped_10_1 ) );
    hoisted_4_1 := List( arg3_1, function ( logic_new_func_x_2 )
            return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_2 )[2] );
        end );
    hoisted_2_1 := List( arg3_1, function ( logic_new_func_x_2 )
            return UnderlyingColumn( MinuendAndSubtrahendInUnderlyingLattice( logic_new_func_x_2 )[1] );
        end );
    deduped_1_1 := [ 1 .. deduped_9_1 ];
    return ForAll( ListOfObjectsInMeetSemilatticeOfDifferences( arg2_1 ), function ( M_2 )
            local hoisted_1_2, hoisted_2_2, deduped_3_2;
            deduped_3_2 := MinuendAndSubtrahendInUnderlyingLattice( M_2 );
            hoisted_2_2 := [ UnderlyingColumn( deduped_3_2[1] ) ];
            hoisted_1_2 := [ UnderlyingColumn( deduped_3_2[2] ) ];
            return ForAll( hoisted_7_1, function ( i_3 )
                    return ForAll( Combinations( deduped_1_1, i_3 ), function ( I_4 )
                            local hoisted_1_4, hoisted_2_4, deduped_3_4;
                            deduped_3_4 := Iterated( Concatenation( hoisted_1_2, hoisted_2_1{Difference( deduped_1_1, I_4 )} ), function ( I_5, J_5 )
                                    return SyzygiesOfRows( I_5, J_5 ) * I_5;
                                end );
                            hoisted_2_4 := TransposedMatrix( deduped_3_4 );
                            hoisted_1_4 := HomalgIdentityMatrix( NumberRows( deduped_3_4 ), deduped_8_1 );
                            return IsZero( DecideZeroRows( hoisted_6_1, CapFixpoint( function ( x_5, y_5 )
                                        return IsZero( DecideZeroRows( y_5, x_5 ) );
                                    end, function ( x_5 )
                                        return SyzygiesOfRows( hoisted_2_4, KroneckerMat( hoisted_1_4, x_5 ) );
                                    end, UnionOfRows( deduped_8_1, hoisted_5_1, Concatenation( hoisted_2_2, hoisted_4_1{I_4} ) ) ) ) );
                        end );
                end );
        end );
end
########
        
    , 100 );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( UnderlyingCategory( cat_1 ) );
    hoisted_2_1 := HomalgIdentityMatrix( 1, deduped_3_1 );
    return ForAll( ListOfObjectsInMeetSemilatticeOfDifferences( arg2_1 ), function ( d_2 )
            local hoisted_1_2, hoisted_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := MinuendAndSubtrahendInUnderlyingLattice( d_2 );
            deduped_3_2 := UnderlyingColumn( deduped_4_2[2] );
            hoisted_2_2 := TransposedMatrix( deduped_3_2 );
            hoisted_1_2 := HomalgIdentityMatrix( NumberRows( deduped_3_2 ), deduped_3_1 );
            return IsZero( DecideZeroRows( hoisted_2_1, CapFixpoint( function ( x_3, y_3 )
                        return IsZero( DecideZeroRows( y_3, x_3 ) );
                    end, function ( x_3 )
                        return SyzygiesOfRows( hoisted_2_2, KroneckerMat( hoisted_1_2, x_3 ) );
                    end, UnderlyingColumn( deduped_4_2[1] ) ) ) );
        end );
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingCategory( cat_1 );
    deduped_2_1 := 1 = RankOfObject( BaseObject( deduped_3_1 ) );
    return ForAll( ListOfObjectsInMeetSemilatticeOfDifferences( arg2_1 ), function ( M_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2;
            deduped_3_2 := MinuendAndSubtrahendInUnderlyingLattice( M_2 );
            deduped_2_2 := deduped_3_2[2];
            deduped_1_2 := deduped_3_2[1];
            return IS_IDENTICAL_OBJ( CapCategory( deduped_1_2 ), deduped_3_1 ) and IS_IDENTICAL_OBJ( CapCategory( deduped_2_2 ), deduped_3_1 ) and (deduped_2_1 and IdFunc( function (  )
                            if NumberColumns( UnderlyingColumn( deduped_1_2 ) ) <> 1 then
                                return false;
                            else
                                return true;
                            fi;
                            return;
                        end )(  )) and (deduped_2_1 and IdFunc( function (  )
                          if NumberColumns( UnderlyingColumn( deduped_2_2 ) ) <> 1 then
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
    return CreateCapCategoryObjectWithAttributes( cat_1, ListOfPreObjectsInMeetSemilatticeOfDifferences, [ CreateCapCategoryObjectWithAttributes( UnderlyingMeetSemilatticeOfDifferences( cat_1 ), PreMinuendAndSubtrahendInUnderlyingLattice, NTuple( 2, CreateCapCategoryObjectWithAttributes( deduped_3_1, UnderlyingColumn, HomalgZeroMatrix( 0, deduped_1_1, deduped_2_1 ) ), CreateCapCategoryObjectWithAttributes( deduped_3_1, UnderlyingColumn, HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) ) ), IsLocallyClosed, true ) ] );
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

BindGlobal( "BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled", function ( R )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( R )
    local ZC;
    ZC := ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled( R : FinalizeCategory := true );
    return BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences( ZC );
end;
        
        
    
    cat := category_constructor( R : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
