# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

##
InstallMethod( FiniteStrictCoproductCompletionOfObjectFiniteCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    local UCm, objectsC, l, H,
          corresponding_list_of_objects_in_C, modeling_tower_object_datum,
          object_func, morphism_func, object_func_inverse, morphism_func_inverse, extended;
    
    Assert( 0, HasIsObjectFiniteCategory( C ) and IsObjectFiniteCategory( C ) and CanCompute( C, "SetOfObjectsOfCategory" ) );
    
    ##
    UCm := CreateCapCategoryWithDataTypes(
                  Concatenation( "FiniteStrictCoproductCompletionOfObjectFiniteCategory( ", Name( C ), " )" ),
                  IsFiniteStrictCoproductCompletionOfObjectFiniteCategory,
                  IsObjectInFiniteStrictCoproductCompletionOfObjectFiniteCategory,
                  IsMorphismInFiniteStrictCoproductCompletionOfObjectFiniteCategory,
                  IsCapCategoryTwoCell,
                  CapJitDataTypeOfNTupleOf( 2,
                          IsBigInt,
                          CapJitDataTypeOfListOf( IsBigInt ) ),
                  CapJitDataTypeOfNTupleOf( 2,
                          CapJitDataTypeOfListOf( IsBigInt ),
                          CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( C ) ) ),
                  fail );
    
    ## UCm supports empty limits, regardless of C
    UCm!.supports_empty_limits := true;
    
    ##
    UCm!.compiler_hints :=
      rec( category_attribute_names :=
           [ "UnderlyingCategory",
             "NumberOfObjectsOfUnderlyingCategory",
             ],
           );
    
    SetUnderlyingCategory( UCm, C );
    
    if HasIsSkeletalCategory( C ) and IsSkeletalCategory( C ) then
        SetIsSkeletalCategory( UCm, true );
    fi;
    
    ##
    SetUnderlyingCategory( UCm, C );
    
    objectsC := SetOfObjects( C );
    
    l := Length( objectsC );
    
    SetNumberOfObjectsOfUnderlyingCategory( UCm, l );
    
    SetIsCocartesianCategory( UCm, true );
    
    SetIsStrictCocartesianCategory( UCm, true );

    if HasIsCartesianCategory( C ) and IsCartesianCategory( C ) then
        if HasIsStrictCartesianCategory( C ) and IsStrictCartesianCategory( C ) then
            SetIsStrictCartesianCategory( UCm, true );
        fi;
        SetIsDistributiveCategory( UCm, true );
    fi;
    
    if HasIsFiniteCompleteCategory( C ) and IsFiniteCompleteCategory( C ) then
        
        SetIsFiniteCompleteCategory( UCm, true );
        
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( C ) then
        
        H := RangeCategoryOfHomomorphismStructure( C );
        
        if IsIntervalCategory( H ) then
            
            SetIsThinCategory( UCm, true );
            SetIsCategoryWithDecidableColifts( UCm, true );
            
            if HasIsEquivalentToFiniteCategory( C ) and IsEquivalentToFiniteCategory( C ) then
                SetIsEquivalentToFiniteCategory( UCm, true );
            fi;
            
        fi;
        
    fi;
    
    corresponding_list_of_objects_in_C :=
      function( UCm, multiplicities )
        local objects, l;
        
        objects := SetOfObjectsOfCategory( UnderlyingCategory( UCm ) );
        
        l := NumberOfObjectsOfUnderlyingCategory( UCm );
        
        return Concatenation( List( [ 1 .. l ], i ->
                       ListWithIdenticalEntries( multiplicities[i], objects[i] ) ) );
        
    end;
    
    ##
    AddObjectConstructor( UCm,
      function( UCm, pair_of_int_and_list_of_multiplicities )
        local l;
        
        l := NumberOfObjectsOfUnderlyingCategory( UCm );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                l = Length( pair_of_int_and_list_of_multiplicities[2] ) and
                pair_of_int_and_list_of_multiplicities[1] = Sum( pair_of_int_and_list_of_multiplicities[2] ) );
        
        return CreateCapCategoryObjectWithAttributes( UCm,
                       PairOfIntAndList, pair_of_int_and_list_of_multiplicities );
        
    end );
    
    ##
    AddObjectDatum( UCm,
      function ( UCm, object )
        
        return PairOfIntAndList( object );
        
    end );
    
    ##
    AddMorphismConstructor( UCm,
      function ( UCm, S, pair_of_lists, T )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsList( pair_of_lists ) and
                Length( pair_of_lists ) = 2 and
                IsList( pair_of_lists[1] ) and
                Length( pair_of_lists[1] ) = ObjectDatum( S )[1] and
                IsList( pair_of_lists[2] ) and
                Length( pair_of_lists[2] ) = Length( pair_of_lists[1] ) );
        
        return CreateCapCategoryMorphismWithAttributes( UCm,
                       S,
                       T,
                       PairOfLists, pair_of_lists );
        
    end );
    
    ##
    AddMorphismDatum( UCm,
      function ( UCm, morphism )
        
        return PairOfLists( morphism );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( UCm,
      function ( UCm, object )
        local pair_of_int_and_list_of_multiplicities, l;
        
        pair_of_int_and_list_of_multiplicities := ObjectDatum( UCm, object );
        
        l := NumberOfObjectsOfUnderlyingCategory( UCm );
        
        return l = Length( pair_of_int_and_list_of_multiplicities[2] ) and
               pair_of_int_and_list_of_multiplicities[1] = Sum( pair_of_int_and_list_of_multiplicities[2] );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( UCm,
      function ( UCm, morphism )
        local pairS, pairT, pair_of_lists, s, t, map, S, T, mors, C;
        
        pairS := ObjectDatum( UCm, Source( morphism ) );
        pairT := ObjectDatum( UCm, Target( morphism ) );
        
        pair_of_lists := MorphismDatum( UCm, morphism );
        
        ## SkeletalFinSets code:
        s := pairS[1];
        t := pairT[1];
        
        map := pair_of_lists[1];
        
        ## FiniteStrictCoproductCompletion code:
        C := UnderlyingCategory( UCm );
        
        S := corresponding_list_of_objects_in_C( UCm, pairS[2] );
        T := corresponding_list_of_objects_in_C( UCm, pairT[2] );
        
        mors := pair_of_lists[2];
        
        if not ForAll( map, a -> IsBigInt( a ) and a >= 0 ) then
            return false;
        elif not s = Length( map ) then
            return false;
        elif not ForAll( map, a -> a < t ) then
            return false;
        elif not ( Length( map ) = Length( mors ) ) then
            return false;
        else
            return ForAll( [ 1 .. Length( mors ) ],
                           i ->
                           IsCapCategoryMorphism( mors[i] ) and
                           IsIdenticalObj( CapCategory( mors[i] ), C ) and
                           IsEqualForObjects( C, Source( mors[i] ), S[i] ) and
                           IsEqualForObjects( C, Target( mors[i] ), T[1 + map[i]] ) and
                           IsWellDefinedForMorphisms( C, mors[i] ) );
        fi;
        
    end );
    
    ##
    AddIsEqualForObjects( UCm,
      function ( UCm, object1, object2 )
        local pair1, pair2, C, L1, L2;
        
        pair1 := ObjectDatum( UCm, object1 );
        pair2 := ObjectDatum( UCm, object2 );
        
        ## SkeletalFinSets code:
        if not pair1[1] = pair2[1] then
            return false;
        fi;
        
        return pair1[2] = pair2[2];
        
    end );
    
    ##
    AddIsEqualForMorphisms( UCm,
      function ( UCm, morphism1, morphism2 )
        local pair_of_lists1, pair_of_lists2, C, m1, m2;
        
        pair_of_lists1 := MorphismDatum( UCm, morphism1 );
        pair_of_lists2 := MorphismDatum( UCm, morphism2 );
        
        ## SkeletalFinSets code:
        if not pair_of_lists1[1] = pair_of_lists2[1] then
            return false;
        fi;
        
        ## FiniteStrictCoproductCompletion code:
        C := UnderlyingCategory( UCm );
        
        m1 := pair_of_lists1[2];
        m2 := pair_of_lists2[2];
        
        return ForAll( [ 1 .. Length( m1 ) ], i -> IsEqualForMorphisms( C, m1[i], m2[i] ) );
        
    end );

    if not ( IsBound( H ) and IsIntervalCategory( H ) ) then
        
        ##
        AddIsCongruentForMorphisms( UCm,
          function ( UCm, morphism1, morphism2 )
            local pair_of_lists1, pair_of_lists2, C, m1, m2;
            
            pair_of_lists1 := MorphismDatum( UCm, morphism1 );
            pair_of_lists2 := MorphismDatum( UCm, morphism2 );
            
            ## SkeletalFinSets code:
            if not pair_of_lists1[1] = pair_of_lists2[1] then
                return false;
            fi;
            
            ## FiniteStrictCoproductCompletion code:
            C := UnderlyingCategory( UCm );
            
            m1 := pair_of_lists1[2];
            m2 := pair_of_lists2[2];
            
            return ForAll( [ 1 .. Length( m1 ) ], i -> IsCongruentForMorphisms( C, m1[i], m2[i] ) );
            
        end );
        
    fi;
    
    ##
    AddIdentityMorphism( UCm,
      function ( UCm, object )
        local pair, map, C, objects, mor;
        
        pair := ObjectDatum( UCm, object );
        
        ## SkeletalFinSets code:
        map := [ 0 .. pair[1] - 1 ];
        
        ## FiniteStrictCoproductCompletion code:
        C := UnderlyingCategory( UCm );
        
        objects := corresponding_list_of_objects_in_C( UCm, pair[2] );
        
        mor := List( objects, objC -> IdentityMorphism( C, objC ) );
        
        return MorphismConstructor( UCm, object, Pair( map, mor ), object );
        
    end );
    
    ##
    AddPreCompose( UCm,
      function ( UCm, pre_morphism, post_morphism )
        local S, T, pair_of_lists_pre, pair_of_lists_post,
              maps_pre, maps_post, s, maps_cmp,
              C, mors_pre, mors_post, mors_cmp;
        
        S := Source( pre_morphism );
        T := Target( post_morphism );
        
        pair_of_lists_pre := MorphismDatum( UCm, pre_morphism );
        pair_of_lists_post := MorphismDatum( UCm, post_morphism );
        
        ## SkeletalFinSets code:
        maps_pre := pair_of_lists_pre[1];
        maps_post := pair_of_lists_post[1];
        
        s := [ 0 .. ObjectDatum( UCm, S )[1] - 1 ];
        
        maps_cmp := List( s, i ->
                          maps_post[1 + maps_pre[1 + i]] );
        
        ## FiniteStrictCoproductCompletion code:
        C := UnderlyingCategory( UCm );
        
        mors_pre := pair_of_lists_pre[2];
        mors_post := pair_of_lists_post[2];
        
        mors_cmp := List( s, i ->
                          PreCompose( C,
                                  mors_pre[1 + i],
                                  mors_post[1 + maps_pre[1 + i]] ) );
        
        return MorphismConstructor( UCm, S, Pair( maps_cmp, mors_cmp ), T );
        
    end );
    
    ##
    AddIsInitial( UCm,
      function ( UCm, object )
        
        ## SkeletalFinSets code:
        return ObjectDatum( UCm, object )[1] = 0;
        
    end );
    
    ##
    AddCoproduct( UCm,
      function ( UCm, diagram )
        local data, l;
        
        data := List( diagram, objC -> ObjectDatum( UCm, objC ) );
        
        l := NumberOfObjectsOfUnderlyingCategory( UCm );
        
        return ObjectConstructor( UCm,
                       Pair( ## SkeletalFinSets code:
                             Sum( List( data, datum -> datum[1] ) ),
                             ## FiniteStrictCoproductCompletion code:
                             ListWithIdenticalEntries( l, 0 ) + Sum( List( data, datum -> datum[2] ) ) ) );
        
    end );
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( UCm,
      function ( UCm, diagram, k, coproduct )
        local data, multiplicities, multiplicity_k, multiplicity, offsets, offsets_k, map, C, mor;
        
        data := List( diagram, objC -> ObjectDatum( UCm, objC ) );
        
        l := NumberOfObjectsOfUnderlyingCategory( UCm );
        
        ## SkeletalFinSets code:
        multiplicities := List( data, datum -> datum[2] );
        
        multiplicity_k := multiplicities[k];
        
        multiplicity := ObjectDatum( UCm, coproduct )[2];
        
        offsets := List( [ 1 .. l ], i -> Sum( multiplicity{[ 1 .. i - 1 ]} ) );

        offsets_k := ListWithIdenticalEntries( l, 0 ) + Sum( multiplicities{[ 1 .. k - 1 ]} );
        
        map := Concatenation( List( [ 1 .. l ], i -> offsets[i] + offsets_k[i] + [ 0 .. multiplicity_k[i] - 1 ] ) );
        
        ## FiniteStrictCoproductCompletion code:
        C := UnderlyingCategory( UCm );
        
        mor := List( corresponding_list_of_objects_in_C( UCm, multiplicity_k ), objC -> IdentityMorphism( C, objC ) );
        
        return MorphismConstructor( UCm,
                       diagram[k],
                       Pair( map, mor ),
                       coproduct );
        
    end );
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( UCm,
      function ( UCm, diagram, test_object, taus, S )
        local d, data_diagram, l, offsets, data_taus, maps, map, mors, mor;
        
        d := Length( diagram );
        
        data_diagram := List( [ 1 .. d ], o -> ObjectDatum( UCm, diagram[o] )[2] );
        
        l := NumberOfObjectsOfUnderlyingCategory( UCm );
        
        offsets := List( [ 1 .. d ], o -> List( [ 1 .. l ], i -> Sum( data_diagram[o]{[ 1 .. i - 1 ]} ) ) );
        
        data_taus := List( taus, morC -> MorphismDatum( UCm, morC ) );
        
        ## SkeletalFinSets code:
        
        maps := List( data_taus, map -> map[1] );
        
        map := Concatenation( List( [ 1 .. l ], i -> Concatenation( List( [ 1 .. d ], o -> maps[o]{offsets[o][i] + [ 1 .. data_diagram[o][i] ]} ) ) ) );
        
        ## FiniteStrictCoproductCompletion code:
        mors := List( data_taus, map -> map[2] );
        
        mor := Concatenation( List( [ 1 .. l ], i -> Concatenation( List( [ 1 .. d ], o -> mors[o]{offsets[o][i] + [ 1 .. data_diagram[o][i] ]} ) ) ) );
        
        return MorphismConstructor( UCm,
                       S,
                       Pair( map, mor ),
                       test_object );
        
    end );
    
    Finalize( UCm );
    
    return UCm;
    
end );

##
InstallMethodForCompilerForCAP( EmbeddingOfUnderlyingCategoryData,
        "for a finite coproduct cocompletion category",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory ],
        
  function( UCm )
    local C, objsC, func, embedding_on_objects, embedding_on_morphisms;
    
    C := UnderlyingCategory( UCm );
    
    objsC := SetOfObjects( C );
    
    func :=
      function( objC )
        local L, pos;
        
        L := ListWithIdenticalEntries( Length( objsC ), 0 );
        
        pos := PositionProperty( objsC, o -> IsEqualForObjects( C, o, objC ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsInt( pos ) );
        
        L[pos] := 1;
        
        return L;
        
    end;
    
    embedding_on_objects :=
      objC -> ObjectConstructor( UCm, Pair( 1, func( objC ) ) );
    
    embedding_on_morphisms :=
      { source, morC, target } -> MorphismConstructor( UCm, source, Pair( [ 0 ], [ morC ] ), target );
    
    return Triple( UnderlyingCategory( UCm ),
                   Pair( embedding_on_objects, embedding_on_morphisms ),
                   UCm );
    
end );

##
InstallMethod( EmbeddingOfUnderlyingCategory,
        "for a finite coproduct cocompletion category",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory ],
        
  function( UCm )
    local data, Y;
    
    data := EmbeddingOfUnderlyingCategoryData( UCm );
    
    Y := CapFunctor( "Embedding functor into a finite strict product completion category", data[1], UCm );
    
    AddObjectFunction( Y, data[2][1] );
    
    AddMorphismFunction( Y, data[2][2] );
    
    return Y;
    
end );

##
InstallMethod( \.,
        "for a finite product completion category and a positive integer",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsPosInt ],
        
  function( UCm, string_as_int )
    local name, C, Y, Yc;
    
    name := NameRNam( string_as_int );
    
    C := UnderlyingCategory( UCm );
    
    Y := EmbeddingOfUnderlyingCategory( UCm );
    
    Yc := Y( C.(name) );
    
    if IsObjectInFiniteStrictCoproductCompletionOfObjectFiniteCategory( Yc ) then

        #TODO: is this true?
        #SetIsInjective( Yc, true );
        
    elif IsMorphismInFiniteStrictCoproductCompletionOfObjectFiniteCategory( Yc ) then
        
        if CanCompute( UCm, "IsMonomorphism" ) then
            IsMonomorphism( Yc );
        fi;
        
        if CanCompute( UCm, "IsSplitMonomorphism" ) then
            IsSplitMonomorphism( Yc );
        fi;
        
        if CanCompute( UCm, "IsEpimorphism" ) then
            IsEpimorphism( Yc );
        fi;
        
        if CanCompute( UCm, "IsSplitEpimorphism" ) then
            IsSplitEpimorphism( Yc );
        fi;
        
        ## IsIsomorphism = IsSplitMonomorphism and IsSplitEpimorphism
        ## we add this here in case the logic is deactivated
        if CanCompute( UCm, "IsIsomorphism" ) then
            IsIsomorphism( Yc );
        fi;
        
    fi;
    
    return Yc;
    
end );

##
InstallMethodForCompilerForCAP( ExtendFunctorToFiniteStrictCoproductCompletionOfObjectFiniteCategoryData,
        "for a two categories and a pair of functions",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsList, IsCartesianCategory ], ## IsStrictCartesianCategory would exclude the lazy category
        
  function( UCm, pair_of_funcs, category_with_strict_coproducts )
    local functor_on_objects, functor_on_morphisms,
          extended_functor_on_objects, extended_functor_on_morphisms;
    
    functor_on_objects := pair_of_funcs[1];
    functor_on_morphisms := pair_of_funcs[2];
    
    ## the code below is the doctrine-specific ur-algorithm for strict cocartesian (monoidal) categories
    
    extended_functor_on_objects :=
      function( objUCm )
        local L;
        
        L := ObjectDatum( UCm, objUCm )[2];
        
        return Coproduct( category_with_strict_coproducts, List( L, objC -> functor_on_objects( objC ) ) );
        
    end;

    extended_functor_on_morphisms :=
      function( source, morUCm, target )
        local pairS, pairT, s, t, S, T, source_diagram, target_diagram, pair_of_lists, map, mor, functor_on_mor;
        
        pairS := ObjectDatum( UCm, Source( morUCm ) );
        pairT := ObjectDatum( UCm, Target( morUCm ) );
        
        s := pairS[1];
        t := pairT[1];
        
        S := pairS[2];
        T := pairT[2];
        
        source_diagram := List( [ 0 .. s - 1 ], i -> functor_on_objects( S[1 + i] ) );
        target_diagram := List( [ 0 .. t - 1 ], i -> functor_on_objects( T[1 + i] ) );
        
        if not IsEqualForObjects( category_with_strict_coproducts, source, Coproduct( category_with_strict_coproducts, source_diagram ) ) then
            Error( "source and Coproduct( source_diagram ) do not coincide\n" );
        fi;
        
        if not IsEqualForObjects( category_with_strict_coproducts, target, Coproduct( category_with_strict_coproducts, target_diagram ) ) then
            Error( "target and Coproduct( target_diagram ) do not coincide\n" );
        fi;
        
        pair_of_lists := MorphismDatum( UCm, morUCm );
        
        map := pair_of_lists[1];
        mor := pair_of_lists[2];
        
        functor_on_mor :=
          List( [ 0 .. s - 1 ], i ->
                functor_on_morphisms(
                        source_diagram[1 + i],
                        mor[1 + i],
                        target_diagram[1 + map[1 + i]] ) );
        
        return MorphismBetweenCoproductsWithGivenCoproducts( category_with_strict_coproducts,
                       source,
                       source_diagram,
                       Pair( map, functor_on_mor ),
                       target_diagram,
                       target );
        
    end;
    
    return Triple( UCm,
                   Pair( extended_functor_on_objects, extended_functor_on_morphisms ),
                   category_with_strict_coproducts );
    
end );

##
InstallMethod( ExtendFunctorToFiniteStrictCoproductCompletionOfObjectFiniteCategory,
        "for a functor",
        [ IsCapFunctor ],
        
  function( F )
    local C, D, mUCm, data, PF;
    
    C := SourceOfFunctor( F );
    D := RangeOfFunctor( F );
    
    mUCm := FiniteStrictCoproductCompletionOfObjectFiniteCategory( C );
    
    data := ExtendFunctorToFiniteStrictCoproductCompletionOfObjectFiniteCategoryData(
                    mUCm,
                    Pair( FunctorObjectOperation( F ), FunctorMorphismOperation( F ) ),
                    D );
    
    PF := CapFunctor( Concatenation( "Extension to FiniteStrictCoproductCompletionOfObjectFiniteCategory( Source( ", Name( F ), " ) )" ), mUCm, D );
    
    AddObjectFunction( PF,
            data[2][1] );
    
    AddMorphismFunction( PF,
            data[2][2] );
    
    return PF;
    
end );

##
InstallMethod( DatumOfCellAsEvaluatableString,
        [ IsObjectInFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsList ],
        
  function( obj, list_of_evaluatable_strings )
    local datum, data;
    
    datum := ObjectDatum( CapCategory( obj ), obj );
    
    data := List( datum[2], d -> CellAsEvaluatableString( d, list_of_evaluatable_strings ) );
    
    return Concatenation( "Pair( ", String( datum[1] ), ", [ ", JoinStringsWithSeparator( data, ", " ), " ] )" );
    
end );

##
InstallMethod( DatumOfCellAsEvaluatableString,
        [ IsMorphismInFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsList ],
        
  function( mor, list_of_evaluatable_strings )
    local datum, data;
    
    datum := MorphismDatum( CapCategory( mor ), mor );
    
    data := List( datum[2], d -> CellAsEvaluatableString( d, list_of_evaluatable_strings ) );
    
    return Concatenation( "Pair( [ ", JoinStringsWithSeparator( datum[1], ", " ), " ], [ ", JoinStringsWithSeparator( data, ", " ), " ] )" );
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( Display,
        [ IsObjectInFiniteStrictCoproductCompletionOfObjectFiniteCategory ],
        
  function ( a )
    
    Display( ObjectDatum( a ) );
    
    Print( "\nAn object in ", Name( CapCategory( a ) ), " given by the above data\n" );
    
end );

##
InstallMethod( Display,
        [ IsMorphismInFiniteStrictCoproductCompletionOfObjectFiniteCategory ],
        
  function ( phi )
    local sFinSets;
    
    sFinSets := ValueGlobal( "SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory" );
    
    Print( ObjectConstructor( sFinSets, ObjectDatum( Source( phi ) )[1] ) );
    Print( " ⱶ", MorphismDatum( phi )[1], "→ " );
    Print( ObjectConstructor( sFinSets, ObjectDatum( Target( phi ) )[1] ), "\n\n" );
    
    Print( MorphismDatum( phi )[2], "\n\n" );
    
    Print( "A morphism in ", Name( CapCategory( phi ) ), " given by the above data\n" );
    
end );
