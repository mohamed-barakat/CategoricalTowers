# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled", function ( cat )
    
    ##
    AddCoexponentialOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingColumn( b_1 );
    hoisted_2_1 := TransposedMatrix( deduped_3_1 );
    hoisted_1_1 := HomalgIdentityMatrix( NumberRows( deduped_3_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, CapFixpoint( function ( x_2, y_2 )
              return IsZero( DecideZeroRows( y_2, x_2 ) );
          end, function ( x_2 )
              return SyzygiesOfRows( hoisted_2_1, KroneckerMat( hoisted_1_1, x_2 ) );
          end, UnderlyingColumn( a_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoproduct( cat,
        
########
function ( cat_1, objects_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, Iterated( List( objects_1, UnderlyingColumn ), function ( I_2, J_2 )
              return SyzygiesOfRows( I_2, J_2 ) * I_2;
          end ) );
end
########
        
    , 100 );
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, objects_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, UnionOfRows( UnderlyingRing( cat_1 ), RankOfObject( BaseObject( cat_1 ) ), List( objects_1, UnderlyingColumn ) ) );
end
########
        
    , 100 );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, HomalgIdentityMatrix( RankOfObject( BaseObject( cat_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInternalCoHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingColumn( b_1 );
    hoisted_2_1 := TransposedMatrix( deduped_3_1 );
    hoisted_1_1 := HomalgIdentityMatrix( NumberRows( deduped_3_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, CapFixpoint( function ( x_2, y_2 )
              return IsZero( DecideZeroRows( y_2, x_2 ) );
          end, function ( x_2 )
              return SyzygiesOfRows( hoisted_2_1, KroneckerMat( hoisted_1_1, x_2 ) );
          end, UnderlyingColumn( a_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroRows( HomalgIdentityMatrix( 1, UnderlyingRing( cat_1 ) ), UnderlyingColumn( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return 1 = RankOfObject( BaseObject( cat_1 ) ) and IdFunc( function (  )
                if NumberColumns( UnderlyingColumn( arg2_1 ) ) <> 1 then
                    return false;
                else
                    return true;
                fi;
                return;
            end )(  );
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg4_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return fail;
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return UnderlyingColumn( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, KroneckerMat( UnderlyingColumn( arg2_1 ), UnderlyingColumn( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, HomalgIdentityMatrix( RankOfObject( BaseObject( cat_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddTerminalObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingColumn, HomalgZeroMatrix( 0, RankOfObject( BaseObject( cat_1 ) ), UnderlyingRing( cat_1 ) ) );
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

BindGlobal( "ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled", function ( R )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( R )
    local object_constructor, object_datum, morphism_constructor, morphism_datum, F, S, P, T, O, modeling_tower_object_constructor, modeling_tower_object_datum, modeling_tower_morphism_constructor, modeling_tower_morphism_datum, ZC, B;
    object_constructor := function ( ZC, column_matrix )
          return ObjectInZariskiFrameOrCoframe( ZC, column_matrix );
      end;
    object_datum := function ( ZC, A )
          return UnderlyingColumn( A );
      end;
    morphism_constructor := function ( ZC, source, dummy, range )
          return CreateCapCategoryMorphismWithAttributes( ZC, source, range );
      end;
    morphism_datum := function ( ZC, phi )
          return fail;
      end;
    if not IsBound( R!.CategoryOfRows ) then
        R!.CategoryOfRows := CategoryOfRows( R : overhead := false,
            FinalizeCategory := false );
        AddProjectionOfBiasedWeakFiberProduct( R!.CategoryOfRows, function ( cat, morphism_1, morphism_2 )
              local homalg_matrix;
              homalg_matrix := SyzygiesOfRows( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) );
              return CategoryOfRowsMorphism( cat, CategoryOfRowsObject( cat, NrRows( homalg_matrix ) ), homalg_matrix, Source( morphism_1 ) );
          end );
        Finalize( R!.CategoryOfRows : FinalizeCategory := true );
    fi;
    F := R!.CategoryOfRows;
    S := SliceCategoryOverTensorUnit( F : overhead := false,
        FinalizeCategory := true );
    P := PosetOfCategory( S : overhead := false,
        FinalizeCategory := true );
    T := StablePosetOfCategory( P : overhead := false,
        FinalizeCategory := true );
    O := Opposite( T : only_primitive_operations := true,
        overhead := false,
        FinalizeCategory := true );
    modeling_tower_object_constructor := function ( ZC, column_matrix )
          local O, T, P, S, F;
          O := ModelingCategory( ZC );
          T := OppositeCategory( O );
          P := AmbientCategory( T );
          S := AmbientCategory( P );
          F := AmbientCategory( S );
          return ObjectConstructor( O, ObjectConstructor( T, ObjectConstructor( P, ObjectConstructor( S, MorphismConstructor( F, ObjectConstructor( F, NrRows( column_matrix ) ), column_matrix, ObjectConstructor( F, 1 ) ) ) ) ) );
      end;
    modeling_tower_object_datum := function ( ZC, objO )
          local O, T, P, S, F;
          O := ModelingCategory( ZC );
          T := OppositeCategory( O );
          P := AmbientCategory( T );
          S := AmbientCategory( P );
          F := AmbientCategory( S );
          return MorphismDatum( F, ObjectDatum( S, ObjectDatum( P, ObjectDatum( T, ObjectDatum( O, objO ) ) ) ) );
      end;
    modeling_tower_morphism_constructor := function ( ZC, sourceO, dummy, rangeO )
          local O;
          O := ModelingCategory( ZC );
          return MorphismConstructor( O, sourceO, rangeO );
      end;
    modeling_tower_morphism_datum := function ( ZC, morO )
          return fail;
      end;
    ZC := ReinterpretationOfCategory( O, rec(
          name := Concatenation( "The coframe of Zariski closed subsets of the affine spectrum of ", RingName( R ) ),
          category_filter := IsZariskiCoframeOfAnAffineVariety,
          category_object_filter := IsObjectInZariskiCoframeOfAnAffineVariety,
          category_morphism_filter := IsMorphismInZariskiCoframeOfAnAffineVariety,
          object_constructor := object_constructor,
          object_datum := object_datum,
          morphism_constructor := morphism_constructor,
          morphism_datum := morphism_datum,
          modeling_tower_object_constructor := modeling_tower_object_constructor,
          modeling_tower_object_datum := modeling_tower_object_datum,
          modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
          modeling_tower_morphism_datum := modeling_tower_morphism_datum,
          only_primitive_operations := true ) : FinalizeCategory := false );
    SetUnderlyingRing( ZC, R );
    SetBaseObject( ZC, BaseObject( S ) );
    SetZariskiCoframeOfAffineSpectrum( R, ZC );
    ZC!.Constructor := ClosedSubsetOfSpec;
    ZC!.ConstructorByListOfColumns := ClosedSubsetOfSpecByListOfColumns;
    ZC!.ConstructorByRadicalColumn := ClosedSubsetOfSpecByRadicalColumn;
    ZC!.ConstructorByStandardColumn := ClosedSubsetOfSpecByStandardColumn;
    ZC!.compiler_hints.category_attribute_names := [ "UnderlyingRing", "BaseObject" ];
    ZC!.compiler_hints.precompiled_towers := [ rec(
            remaining_constructors_in_tower := [ "MeetSemilatticeOfDifferences" ],
            precompiled_functions_adder := ValueGlobal( "ADD_FUNCTIONS_FOR_MeetSemilatticeOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled" ) ), rec(
            remaining_constructors_in_tower := [ "MeetSemilatticeOfMultipleDifferences" ],
            precompiled_functions_adder := ValueGlobal( "ADD_FUNCTIONS_FOR_MeetSemilatticeOfMultipleDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled" ) ), rec(
            remaining_constructors_in_tower := [ "BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences" ],
            precompiled_functions_adder := ValueGlobal( "ADD_FUNCTIONS_FOR_BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled" ) ) ];
    B := BaseRing( R );
    if not IsIdenticalObj( R, B ) then
        SetBaseOfFibration( ZC, TerminalObject( ZariskiCoframeOfAffineSpectrum( B : FinalizeCategory := true ) ) );
    fi;
    if ValueOption( "no_precompiled_code" ) <> true then
        ADD_FUNCTIONS_FOR_ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled( ZC );
    fi;
    Finalize( ZC );
    return ZC;
end;
        
        
    
    cat := category_constructor( R : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
