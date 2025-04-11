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
    local objects, l,
          object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          UC,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          mUC;
    
    Assert( 0, HasIsObjectFiniteCategory( C ) and IsObjectFiniteCategory( C ) and HasSetOfObjects( C ) );
    
    objects := SetOfObjects( C );
    
    l := Length( objects );
    
    ##
    object_datum_type :=
      CapJitDataTypeOfNTupleOf( 2,
              IsBigInt,
              CapJitDataTypeOfListOf( IsBigInt ) );
    
    ##
    object_constructor :=
      function( mUC, pair_of_int_and_list_of_multiplicities )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                l = Length( pair_of_int_and_list_of_multiplicities[2] ) and
                pair_of_int_and_list_of_multiplicities[1] = Sum( pair_of_int_and_list_of_multiplicities[2] ) );
        
        return CreateCapCategoryObjectWithAttributes( mUC,
                       PairOfIntAndList, pair_of_int_and_list_of_multiplicities );
        
    end;
    
    ##
    object_datum := { mUC, obj } -> PairOfIntAndList( obj );
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfNTupleOf( 2,
              CapJitDataTypeOfListOf( IsBigInt ),
              CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( C ) ) );
    
    ##
    morphism_constructor :=
      function ( mUC, S, pair_of_lists, T )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsList( pair_of_lists ) and
                Length( pair_of_lists ) = 2 and
                IsList( pair_of_lists[1] ) and
                IsList( pair_of_lists[2] ) );
        
        return CreateCapCategoryMorphismWithAttributes( mUC,
                       S,
                       T,
                       PairOfLists, pair_of_lists );
        
    end;
    
    ##
    morphism_datum := { mUC, phi } -> PairOfLists( phi );
    
    ## building the categorical tower:
    
    UC := FiniteStrictCoproductCompletion( C : FinalizeCategory := true );
    
    if HasIsInitialCategory( C ) and IsInitialCategory( C ) then
        Assert( 0, [ ] = MissingOperationsForConstructivenessOfCategory( UC, "IsEquippedWithHomomorphismStructure" ) );
    fi;
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( mUC, pair_of_int_and_list_of_multiplicities )
        local UC, objects, l, multiplicities;
        
        UC := ModelingCategory( mUC );
        
        objects := SetOfObjectsOfCategory( UnderlyingCategory( mUC ) );
        
        l := NumberOfObjectsOfUnderlyingCategory( mUC );
        
        multiplicities := pair_of_int_and_list_of_multiplicities[2];
        
        return ObjectConstructor( UC,
                       Pair( pair_of_int_and_list_of_multiplicities[1],
                             Concatenation( List( [ 1 .. l ], i ->
                                     ListWithIdenticalEntries( multiplicities[i], objects[i] ) ) ) ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function( mUC, objUC )
        local UC, C, objects, l, pair_of_int_and_list, list_of_objects;
        
        UC := ModelingCategory( mUC );
        
        C := UnderlyingCategory( mUC );
        
        objects := SetOfObjectsOfCategory( C );
        
        l := NumberOfObjectsOfUnderlyingCategory( mUC );
        
        pair_of_int_and_list := ObjectDatum( UC, objUC );

        list_of_objects := pair_of_int_and_list[2];
        
        return Pair( pair_of_int_and_list[1],
                     List( [ 1 .. l ], i ->
                           Length( PositionsProperty( list_of_objects, obj ->
                                   IsEqualForObjects( C, obj, objects[i] ) ) ) ) );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( mUC, source, pair_of_lists, target )
        local UC;
        
        UC := ModelingCategory( mUC );
        
        return MorphismConstructor( UC,
                       source,
                       pair_of_lists,
                       target );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum :=
      function( mUC, phi )
        local UC, pair_of_lists;
        
        UC := ModelingCategory( mUC );
        
        Error( );
        
    end;
    
    ##
    mUC :=
      ReinterpretationOfCategory( UC,
              rec( name := Concatenation( "FiniteStrictCoproductCompletionOfObjectFiniteCategory( ", Name( C ), " )" ),
                   category_filter := IsFiniteStrictCoproductCompletionOfObjectFiniteCategory,
                   category_object_filter := IsObjectInFiniteStrictCoproductCompletionOfObjectFiniteCategory,
                   category_morphism_filter := IsMorphismInFiniteStrictCoproductCompletionOfObjectFiniteCategory,
                   object_datum_type := object_datum_type,
                   morphism_datum_type := morphism_datum_type,
                   object_constructor := object_constructor,
                   object_datum := object_datum,
                   morphism_constructor := morphism_constructor,
                   morphism_datum := morphism_datum,
                   modeling_tower_object_constructor := modeling_tower_object_constructor,
                   modeling_tower_object_datum := modeling_tower_object_datum,
                   modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                   only_primitive_operations := true )
              : FinalizeCategory := false );
    
    SetUnderlyingCategory( mUC, C );
    SetNumberOfObjectsOfUnderlyingCategory( mUC, l );
    
    if HasIsSkeletalCategory( C ) and IsSkeletalCategory( C ) then
        SetIsSkeletalCategory( mUC, true );
    fi;
    
    Append( mUC!.compiler_hints.category_attribute_names,
            [ "UnderlyingCategory",
              "NumberOfObjectsOfUnderlyingCategory" ] );
    
    if HasIsInitialCategory( C ) and IsInitialCategory( C ) then
        Assert( 0, [ ] = MissingOperationsForConstructivenessOfCategory( mUC, "IsEquippedWithHomomorphismStructure" ) );
    fi;
    
    Finalize( mUC );
    
    return mUC;
    
end );

##
InstallMethodForCompilerForCAP( EmbeddingOfUnderlyingCategoryData,
        "for a finite coproduct cocompletion category",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory ],
        
  function( mUC )
    local embedding_on_objects, embedding_on_morphisms;
    
    embedding_on_objects :=
      objC -> ObjectConstructor( mUC, Pair( 1, [ objC ] ) );
    
    embedding_on_morphisms :=
      { source, morC, target } -> MorphismConstructor( mUC, source, Pair( [ 0 ], [ morC ] ), target );
    
    return Triple( UnderlyingCategory( mUC ),
                   Pair( embedding_on_objects, embedding_on_morphisms ),
                   mUC );
    
end );

##
InstallMethod( EmbeddingOfUnderlyingCategory,
        "for a finite coproduct cocompletion category",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory ],
        
  function( mUC )
    local data, Y;
    
    data := EmbeddingOfUnderlyingCategoryData( mUC );
    
    Y := CapFunctor( "Embedding functor into a finite strict product completion category", data[1], mUC );
    
    AddObjectFunction( Y, data[2][1] );
    
    AddMorphismFunction( Y, data[2][2] );
    
    return Y;
    
end );

##
InstallMethod( \.,
        "for a finite product completion category and a positive integer",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsPosInt ],
        
  function( mUC, string_as_int )
    local name, C, Y, Yc;
    
    name := NameRNam( string_as_int );
    
    C := UnderlyingCategory( mUC );
    
    Y := EmbeddingOfUnderlyingCategory( mUC );
    
    Yc := Y( C.(name) );
    
    if IsObjectInFiniteStrictCoproductCompletionOfObjectFiniteCategory( Yc ) then

        #TODO: is this true?
        #SetIsInjective( Yc, true );
        
    elif IsMorphismInFiniteStrictCoproductCompletionOfObjectFiniteCategory( Yc ) then
        
        if CanCompute( mUC, "IsMonomorphism" ) then
            IsMonomorphism( Yc );
        fi;
        
        if CanCompute( mUC, "IsSplitMonomorphism" ) then
            IsSplitMonomorphism( Yc );
        fi;
        
        if CanCompute( mUC, "IsEpimorphism" ) then
            IsEpimorphism( Yc );
        fi;
        
        if CanCompute( mUC, "IsSplitEpimorphism" ) then
            IsSplitEpimorphism( Yc );
        fi;
        
        ## IsIsomorphism = IsSplitMonomorphism and IsSplitEpimorphism
        ## we add this here in case the logic is deactivated
        if CanCompute( mUC, "IsIsomorphism" ) then
            IsIsomorphism( Yc );
        fi;
        
    fi;
    
    return Yc;
    
end );

##
InstallMethodForCompilerForCAP( ExtendFunctorToFiniteStrictCoproductCompletionOfObjectFiniteCategoryData,
        "for a two categories and a pair of functions",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsList, IsCartesianCategory ], ## IsStrictCartesianCategory would exclude the lazy category
        
  function( mUC, pair_of_funcs, category_with_strict_products )
    local functor_on_objects, functor_on_morphisms,
          extended_functor_on_objects, extended_functor_on_morphisms;
    
    functor_on_objects := pair_of_funcs[1];
    functor_on_morphisms := pair_of_funcs[2];
    
    ## the code below is the doctrine-specific ur-algorithm for strict cartesian (monoidal) categories
    
    extended_functor_on_objects :=
      function( objmUC )
        local L;
        
        L := ObjectDatum( mUC, objmUC )[2];
        
        return DirectProduct( category_with_strict_products, List( L, objC -> functor_on_objects( objC ) ) );
        
    end;
    
    extended_functor_on_morphisms :=
      function( source, mormUC, target )
        local pairS, pairT, s, t, S, T, source_diagram, target_diagram, pair_of_lists, map, mor, functor_on_mor;
        
        pairS := ObjectDatum( mUC, Source( mormUC ) );
        pairT := ObjectDatum( mUC, Target( mormUC ) );
        
        s := pairS[1];
        t := pairT[1];
        
        S := pairS[2];
        T := pairT[2];
        
        source_diagram := List( [ 0 .. s - 1 ], i -> functor_on_objects( S[1 + i] ) );
        target_diagram := List( [ 0 .. t - 1 ], i -> functor_on_objects( T[1 + i] ) );
        
        if not IsEqualForObjects( category_with_strict_products, source, DirectProduct( category_with_strict_products, source_diagram ) ) then
            Error( "source and DirectProduct( source_diagram ) do not coincide\n" );
        fi;
        
        if not IsEqualForObjects( category_with_strict_products, target, DirectProduct( category_with_strict_products, target_diagram ) ) then
            Error( "target and DirectProduct( target_diagram ) do not coincide\n" );
        fi;
        
        pair_of_lists := MorphismDatum( mUC, mormUC );
        
        map := pair_of_lists[1];
        mor := pair_of_lists[2];
        
        functor_on_mor := List( [ 0 .. t - 1 ], i ->
                      functor_on_morphisms(
                              target_diagram[1 + i],
                              mor[1 + i],
                              source_diagram[1 + map[1 + i]] ) );
        
        return MorphismBetweenDirectProductsWithGivenDirectProducts( category_with_strict_products,
                       source,
                       source_diagram,
                       Pair( map, functor_on_mor ),
                       target_diagram,
                       target );
        
    end;
    
    return Triple( mUC,
                   Pair( extended_functor_on_objects, extended_functor_on_morphisms ),
                   category_with_strict_products );
    
end );

##
InstallMethod( ExtendFunctorToFiniteStrictCoproductCompletionOfObjectFiniteCategory,
        "for a functor",
        [ IsCapFunctor ],
        
  function( F )
    local C, D, mUC, data, PF;
    
    C := SourceOfFunctor( F );
    D := RangeOfFunctor( F );
    
    mUC := FiniteStrictCoproductCompletionOfObjectFiniteCategory( C );
    
    data := ExtendFunctorToFiniteStrictCoproductCompletionOfObjectFiniteCategoryData(
                    mUC,
                    Pair( FunctorObjectOperation( F ), FunctorMorphismOperation( F ) ),
                    D );
    
    PF := CapFunctor( Concatenation( "Extension to FiniteStrictCoproductCompletionOfObjectFiniteCategory( Source( ", Name( F ), " ) )" ), mUC, D );
    
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
    
    Print( ObjectConstructor( sFinSets, ObjectDatum( Target( phi ) )[1] ) );
    Print( " ⱶ", MorphismDatum( phi )[1], "→ " );
    Print( ObjectConstructor( sFinSets, ObjectDatum( Source( phi ) )[1] ), "\n\n" );
    
    Print( MorphismDatum( phi )[2], "\n\n" );
    
    Print( "A morphism in ", Name( CapCategory( phi ) ), " given by the above data\n" );
    
end );
