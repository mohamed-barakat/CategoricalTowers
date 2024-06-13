# Spdx-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Implementations
#

##
InstallMethod( CategoryOfHopfMonoids,
        [ IsCapCategory and IsSymmetricMonoidalCategory ],
        
  function( B )
    local name, object_datum_type, morphism_datum_type, HmonB;
    
    ##
    name := Concatenation( "CategoryOfHopfMonoids( ", Name( B ), " )" );
    
    ##
    object_datum_type :=
      CapJitDataTypeOfNTupleOf( 6,
              CapJitDataTypeOfObjectOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ) );
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfMorphismOfCategory( B );
    
    ##
    HmonB :=
      CreateCapCategoryWithDataTypes( name,
              IsCategoryOfInternalHopfMonoids,
              IsInternalHopfMonoid,
              IsInternalHopfMonoidMorphism,
              IsCapCategoryTwoCell,
              object_datum_type,
              morphism_datum_type,
              fail );
    
    if IsBound( B!.supports_empty_limits ) and B!.supports_empty_limits = true then
        HmonB!.supports_empty_limits := true;
    fi;
    
    SetUnderlyingCategory( HmonB, B );
    
    SetAssociatedCategoryOfMonoids( HmonB, CategoryOfMonoids( B ) );
    SetAssociatedCategoryOfComonoids( HmonB, CategoryOfComonoids( B ) );

    if ValueOption( "reverse" ) = true then
        SetAssociatedCategoryOfBimonoids( HmonB, CategoryOfBimonoids2( B ) );
    else
        SetAssociatedCategoryOfBimonoids( HmonB, CategoryOfBimonoids( B ) );
    fi;
    
    HmonB!.compiler_hints :=
      rec( category_attribute_names :=
           [ "UnderlyingCategory",
             "AssociatedCategoryOfMonoids",
             "AssociatedCategoryOfComonoids",
             "AssociatedCategoryOfBimonoids",
             ] );
    
    SetIsCategoryWithZeroObject( HmonB, true );
    SetIsSymmetricMonoidalCategory( HmonB, true );
    
    ##
    AddObjectConstructor( HmonB,
      function( HmonB, sextuple_of_object_unit_multiplication_counit_comultiplication_antipode )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                Length( sextuple_of_object_unit_multiplication_counit_comultiplication_antipode ) = 6 and
                IsCapCategoryObject( sextuple_of_object_unit_multiplication_counit_comultiplication_antipode[1] ) and
                ForAll( sextuple_of_object_unit_multiplication_counit_comultiplication_antipode{[ 2 .. 6 ]}, IsCapCategoryMorphism ) and
                ForAll( sextuple_of_object_unit_multiplication_counit_comultiplication_antipode, cell -> IsIdenticalObj( B, CapCategory( cell ) ) ) );
        
        return CreateCapCategoryObjectWithAttributes( HmonB,
                       DefiningSextupleOfInternalHopfMonoid, sextuple_of_object_unit_multiplication_counit_comultiplication_antipode );
        
    end );
    
    ##
    AddObjectDatum( HmonB,
      function( HmonB, object )
        
        return DefiningSextupleOfInternalHopfMonoid( object );
        
    end );
    
    ##
    AddMorphismConstructor( HmonB,
      function( HmonB, source, morphism, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsCapCategoryMorphism( morphism ) and
                IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( HmonB ) ) );
        
        return CreateCapCategoryMorphismWithAttributes( HmonB,
                       source,
                       target,
                       UnderlyingMorphism, morphism );
        
    end );
    
    ##
    AddMorphismDatum( HmonB,
      function( HmonB, morphism )
        
        return UnderlyingMorphism( morphism );
        
    end );
    
    ##
    AddIsEqualForObjects( HmonB,
      function( HmonB, object1, object2 )
        local B, sextuple1, sextuple2;
        
        B := UnderlyingCategory( HmonB );
        
        sextuple1 := ObjectDatum( HmonB, object1 );
        sextuple2 := ObjectDatum( HmonB, object2 );
        
        return IsEqualForObjects( B, sextuple1[1], sextuple2[1] ) and
               IsCongruentForMorphisms( B, sextuple1[2], sextuple2[2] ) and
               IsCongruentForMorphisms( B, sextuple1[3], sextuple2[3] ) and
               IsCongruentForMorphisms( B, sextuple1[4], sextuple2[4] ) and
               IsCongruentForMorphisms( B, sextuple1[5], sextuple2[5] ) and
               IsCongruentForMorphisms( B, sextuple1[6], sextuple2[6] );
        
    end );
    
    ##
    AddIsEqualForMorphisms( HmonB,
      function( HmonB, morphism1, morphism2 )
        
        return IsEqualForMorphisms( UnderlyingCategory( HmonB ),
                       MorphismDatum( HmonB, morphism1 ),
                       MorphismDatum( HmonB, morphism2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( HmonB,
      function( HmonB, morphism1, morphism2 )
        
        return IsCongruentForMorphisms( UnderlyingCategory( HmonB ),
                       MorphismDatum( HmonB, morphism1 ),
                       MorphismDatum( HmonB, morphism2 ) );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( HmonB,
      function( HmonB, hopf_monoid )
        local B, sextuple, object, unit, mult, counit, comult, antipode,
              extract_datum, obstruction, id_object, rhs_antipode, lhs_antipode_left, lhs_antipode_right;
        
        B := UnderlyingCategory( HmonB );
        
        sextuple := ObjectDatum( HmonB, hopf_monoid );
        
        if not IsList( sextuple ) then
            return false;
        elif not Length( sextuple ) = 6 then
            return false;
        elif not IsCapCategoryObject( sextuple[1] ) then
            return false;
        elif not ForAll( sextuple{[ 2 .. 6 ]}, IsCapCategoryMorphism ) then
            return false;
        elif not ForAll( sextuple, cell -> IsIdenticalObj( B, CapCategory( cell ) ) ) then
            return false;
        fi;
        
        if not IsWellDefinedForObjects( AssociatedCategoryOfBimonoids( HmonB ),
                   UnderlyingBimonoid( HmonB, hopf_monoid ) ) then
            return false;
        fi;
        
        object := sextuple[1];
        unit := sextuple[2];
        mult := sextuple[3];
        counit := sextuple[4];
        comult := sextuple[5];
        antipode := sextuple[6];
        
        extract_datum :=
          function( mor )
            while IsCapCategoryMorphism( mor ) do
                mor := MorphismDatum( mor );
            od;
            return mor;
        end;
        
        obstruction := ValueOption( "obstruction" );
        
        id_object := IdentityMorphism( B, object );
        
        rhs_antipode := PreCompose( B,
                                counit,
                                unit );
        
        lhs_antipode_left := PreComposeList( B,
                                     [ comult,
                                       TensorProductOnMorphisms( B,
                                               antipode,
                                               id_object ),
                                       mult ] );
        
        if not IsCongruentForMorphisms( B, lhs_antipode_left, rhs_antipode ) then
            if not obstruction = fail then
                Add( obstruction, Pair( extract_datum( lhs_antipode_left ), extract_datum( rhs_antipode ) ) );
            else
                return false;
            fi;
        fi;
        
        lhs_antipode_right := PreComposeList( B,
                                      [ comult,
                                        TensorProductOnMorphisms( B,
                                                id_object,
                                                antipode ),
                                        mult ] );
        
        if not IsCongruentForMorphisms( B, lhs_antipode_right, rhs_antipode ) then
            if not obstruction = fail then
                Add( obstruction, Pair( extract_datum( lhs_antipode_right ), extract_datum( rhs_antipode ) ) );
            else
                return false;
            fi;
        fi;
        
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( HmonB,
      function( HmonB, hopf_monoid_morphism )
        local B, morphism;
        
        B := UnderlyingCategory( HmonB );
        
        morphism := MorphismDatum( HmonB, hopf_monoid_morphism );
        
        if not IsCapCategoryMorphism( morphism ) then
            return false;
        elif not IsIdenticalObj( B, CapCategory( morphism ) ) then
            return false;
        elif not IsWellDefinedForMorphisms( B, morphism ) then
            return false;
        fi;
        
        return IsWellDefinedForMorphisms( AssociatedCategoryOfBimonoids( HmonB ),
                       UnderlyingBimonoidMorphism( HmonB, hopf_monoid_morphism ) );
        
    end );
    
    ##
    AddIdentityMorphism( HmonB,
      function( HmonB, object )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       object,
                       IdentityMorphism( B,
                               ObjectDatum( HmonB, object )[1] ),
                       object );
        
    end );
    
    ##
    AddPreCompose( HmonB,
      function( HmonB, pre_morphism, post_morphism )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       Source( pre_morphism ),
                       PreCompose( B,
                               MorphismDatum( HmonB, pre_morphism ),
                               MorphismDatum( HmonB, post_morphism ) ),
                       Target( post_morphism ) );
        
    end );
    
    ##
    AddIsIsomorphism( HmonB,
      function( HmonB, hopf_monoid_morphism )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return IsIsomorphism( B,
                       MorphismDatum( HmonB,
                               hopf_monoid_morphism ) );
        
    end );
    
    ##
    AddInverseForMorphisms( HmonB,
      function( HmonB, hopf_monoid_morphism )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       Target( hopf_monoid_morphism ),
                       InverseForMorphisms( B,
                               MorphismDatum( HmonB,
                                       hopf_monoid_morphism ) ),
                       Source( hopf_monoid_morphism ) );
        
    end );
    
    ##
    AddTensorUnit( HmonB,
      function( HmonB )
        local B, BimonB, quintuple;
        
        B := UnderlyingCategory( HmonB );
        
        BimonB := AssociatedCategoryOfBimonoids( HmonB );
        
        quintuple := ObjectDatum( BimonB,
                             TensorUnit( BimonB ) );
        
        return ObjectConstructor( HmonB,
                       NTuple( 6,
                               quintuple[1],
                               quintuple[2],
                               quintuple[3],
                               quintuple[4],
                               quintuple[5],
                               IdentityMorphism( B, quintuple[1] ) ) );
            
    end );
    
    ##
    AddTensorProductOnObjects( HmonB,
      function( HmonB, hopf_monoid1, hopf_monoid2 )
        local B, BimonB, quintuple;
        
        B := UnderlyingCategory( HmonB );
        
        BimonB := AssociatedCategoryOfBimonoids( HmonB );
        
        quintuple := ObjectDatum( BimonB,
                             TensorProductOnObjects( BimonB,
                                     UnderlyingBimonoid( HmonB,
                                             hopf_monoid1 ),
                                     UnderlyingBimonoid( HmonB,
                                             hopf_monoid2 ) ) );
        
        return ObjectConstructor( HmonB,
                       NTuple( 6,
                               quintuple[1],
                               quintuple[2],
                               quintuple[3],
                               quintuple[4],
                               quintuple[5],
                               TensorProductOnMorphismsWithGivenTensorProducts( B,
                                       quintuple[1],
                                       ObjectDatum( HmonB, hopf_monoid1 )[6],
                                       ObjectDatum( HmonB, hopf_monoid2 )[6],
                                       quintuple[1] ) ) );
        
    end );
        
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( HmonB,
      function( HmonB, source, hopf_monoid_morphism1, hopf_monoid_morphism2, target )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       source,
                       TensorProductOnMorphisms( B,
                               MorphismDatum( HmonB, hopf_monoid_morphism1 ),
                               MorphismDatum( HmonB, hopf_monoid_morphism2 ) ),
                       target );
        
    end );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( HmonB,
      function( HmonB, object, source )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       source,
                       LeftUnitorWithGivenTensorProduct( B,
                               ObjectDatum( HmonB, object )[1],
                               ObjectDatum( HmonB, source )[1] ),
                       object );
        
    end );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( HmonB,
      function( HmonB, object, target )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       object,
                       LeftUnitorInverseWithGivenTensorProduct( B,
                               ObjectDatum( HmonB, object )[1],
                               ObjectDatum( HmonB, target )[1] ),
                       target );
        
    end );
    
    ##
    AddRightUnitorWithGivenTensorProduct( HmonB,
      function( HmonB, object, source )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       source,
                       RightUnitorWithGivenTensorProduct( B,
                               ObjectDatum( HmonB, object )[1],
                               ObjectDatum( HmonB, source )[1] ),
                       object );
        
    end );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( HmonB,
      function( HmonB, object, target )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       object,
                       RightUnitorInverseWithGivenTensorProduct( B,
                               ObjectDatum( HmonB, object )[1],
                               ObjectDatum( HmonB, target )[1] ),
                       target );
        
    end );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( HmonB,
      function( HmonB, source, object1, object2, object3, target )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       source,
                       AssociatorLeftToRightWithGivenTensorProducts( B,
                               ObjectDatum( HmonB, source )[1],
                               ObjectDatum( HmonB, object1 )[1],
                               ObjectDatum( HmonB, object2 )[1],
                               ObjectDatum( HmonB, object3 )[1],
                               ObjectDatum( HmonB, target )[1] ),
                       target );
        
    end );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( HmonB,
      function( HmonB, source, object1, object2, object3, target )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       source,
                       AssociatorRightToLeftWithGivenTensorProducts( B,
                               ObjectDatum( HmonB, source )[1],
                               ObjectDatum( HmonB, object1 )[1],
                               ObjectDatum( HmonB, object2 )[1],
                               ObjectDatum( HmonB, object3 )[1],
                               ObjectDatum( HmonB, target )[1] ),
                       target );
        
    end );
    
    ##
    AddBraidingWithGivenTensorProducts( HmonB,
      function( HmonB, source, object1, object2, target )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       source,
                       BraidingWithGivenTensorProducts( B,
                               ObjectDatum( HmonB, source )[1],
                               ObjectDatum( HmonB, object1 )[1],
                               ObjectDatum( HmonB, object2 )[1],
                               ObjectDatum( HmonB, target )[1] ),
                       target );
        
    end );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( HmonB,
      function( HmonB, source, object1, object2, target )
        local B;
        
        B := UnderlyingCategory( HmonB );
        
        return MorphismConstructor( HmonB,
                       source,
                       BraidingInverseWithGivenTensorProducts( B,
                               ObjectDatum( HmonB, source )[1],
                               ObjectDatum( HmonB, object1 )[1],
                               ObjectDatum( HmonB, object2 )[1],
                               ObjectDatum( HmonB, target )[1] ),
                       target );
        
    end );
    
    ##
    AddZeroObject( HmonB,
      function( HmonB )
        
        return TensorUnit( HmonB );
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( HmonB,
      function( HmonB, object, unit )
        
        return MorphismConstructor( HmonB,
                       unit,
                       ObjectDatum( HmonB, object )[2],
                       object );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( HmonB,
      function( HmonB, object, unit )
        
        return MorphismConstructor( HmonB,
                       object,
                       ObjectDatum( HmonB, object )[4],
                       unit );
        
    end );
    
    Finalize( HmonB );
    
    return HmonB;
    
end );

##
InstallMethod( UnderlyingObject,
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    
    return ObjectDatum( hopf_monoid )[1];
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingMonoid,
        [ IsCategoryOfInternalHopfMonoids, IsInternalHopfMonoid ],

  function( HmonB, hopf_monoid )
    local sextuple;
    
    sextuple := ObjectDatum( HmonB, hopf_monoid );
    
    return ObjectConstructor( AssociatedCategoryOfMonoids( HmonB ),
                   Triple( sextuple[1],
                           sextuple[2],
                           sextuple[3] ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingComonoid,
        [ IsCategoryOfInternalHopfMonoids, IsInternalHopfMonoid ],

  function( HmonB, hopf_monoid )
    local sextuple;
    
    sextuple := ObjectDatum( HmonB, hopf_monoid );
    
    return ObjectConstructor( AssociatedCategoryOfComonoids( HmonB ),
                   Triple( sextuple[1],
                           sextuple[4],
                           sextuple[5] ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingBimonoid,
        [ IsCategoryOfInternalHopfMonoids, IsInternalHopfMonoid ],

  function( HmonB, hopf_monoid )
    local sextuple;
    
    sextuple := ObjectDatum( HmonB, hopf_monoid );
    
    return ObjectConstructor( AssociatedCategoryOfBimonoids( HmonB ),
                   NTuple( 5,
                           sextuple[1],
                           sextuple[2],
                           sextuple[3],
                           sextuple[4],
                           sextuple[5] ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingMonoidMorphism,
        [ IsCategoryOfInternalHopfMonoids, IsInternalHopfMonoidMorphism ],
        
  function( HmonB, hopf_monoid_morphism )
    
    return MorphismConstructor( AssociatedCategoryOfMonoids( HmonB ),
                   UnderlyingMonoid( HmonB, Source( hopf_monoid_morphism ) ),
                   MorphismDatum( HmonB, hopf_monoid_morphism ),
                   UnderlyingMonoid( HmonB, Target( hopf_monoid_morphism ) ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingComonoidMorphism,
        [ IsCategoryOfInternalHopfMonoids, IsInternalHopfMonoidMorphism ],
        
  function( HmonB, hopf_monoid_morphism )
    
    return MorphismConstructor( AssociatedCategoryOfComonoids( HmonB ),
                   UnderlyingComonoid( HmonB, Source( hopf_monoid_morphism ) ),
                   MorphismDatum( HmonB, hopf_monoid_morphism ),
                   UnderlyingComonoid( HmonB, Target( hopf_monoid_morphism ) ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingBimonoidMorphism,
        [ IsCategoryOfInternalHopfMonoids, IsInternalHopfMonoidMorphism ],
        
  function( HmonB, hopf_monoid_morphism )
    
    return MorphismConstructor( AssociatedCategoryOfBimonoids( HmonB ),
                   UnderlyingBimonoid( HmonB, Source( hopf_monoid_morphism ) ),
                   MorphismDatum( HmonB, hopf_monoid_morphism ),
                   UnderlyingBimonoid( HmonB, Target( hopf_monoid_morphism ) ) );
    
end );

##
InstallMethod( DualHopfMonoid,
        [ IsInternalHopfMonoid ],

  function( hopf_monoid )
    local HmonB, B, sextuple, dual;
    
    HmonB := CapCategory( hopf_monoid );
    
    B := UnderlyingCategory( HmonB );
    
    if not CanCompute( B, "DualOnMorphisms" ) then
        TryNextMethod( );
    fi;
    
    sextuple := ObjectDatum( HmonB, hopf_monoid );
    
    dual := DualOnObjects( B, sextuple[1] );
    
    return ObjectConstructor( HmonB,
                   NTuple( 6,
                           dual,
                           DualOnMorphismsWithGivenDuals( B,
                                   TensorUnit( B ),
                                   sextuple[4],
                                   dual ),
                           DualOnMorphismsWithGivenDuals( B,
                                   TensorProductOnObjects( B,
                                           dual,
                                           dual ),
                                   sextuple[5],
                                   dual ),
                           DualOnMorphismsWithGivenDuals( B,
                                   dual,
                                   sextuple[2],
                                   TensorUnit( B ) ),
                           DualOnMorphismsWithGivenDuals( B,
                                   dual,
                                   sextuple[3],
                                   TensorProductOnObjects( B,
                                           dual,
                                           dual ) ),
                           DualOnMorphismsWithGivenDuals( B,
                                   dual,
                                   sextuple[6],
                                   dual ) ) );
    
end );

##
InstallMethod( LinearizationOfSetGroup,
        [ IsMonoidalCategory and IsLinearCategoryOverCommutativeRing, IsGroup ],
        
  function( B, set_theoretic_group )
    local dim, U, object, object2, elements, k, id, o, unit, mult, counit, comult, antipode, hopf_monoid;
    
    dim := Size( set_theoretic_group );
    
    U := TensorUnit( B );
    
    object := ObjectConstructor( B, dim );
    
    object2 := TensorProductOnObjects( B, object, object );
    
    elements := Elements( set_theoretic_group );
    
    Assert( 0, dim = Length( elements ) );
    
    k := CommutativeRingOfLinearCategory( B );
    
    id := HomalgIdentityMatrix( dim, k );
    
    o := PositionProperty( elements, IsOne );
    
    unit := CertainRows( id, [ o ] );
    unit := MorphismConstructor( B, U, unit, object );
    
    mult := List( elements, b ->
                  List( elements, a ->
                        Position( elements, a * b ) ) );
    mult := CertainRows( id, Concatenation( mult ) );
    mult := MorphismConstructor( B, object2, mult, object );
    
    counit := Sum( [ 1 .. dim ], j -> CertainColumns( id, [ j ] ) );
    counit := MorphismConstructor( B, object, counit, U );
    
    comult := UnionOfRows( k, dim^2,
                      List( [ 1 .. dim ], i ->
                            KroneckerMat( CertainRows( id, [ i ] ),  CertainRows( id, [ i ] ) ) ) );
    comult := MorphismConstructor( B, object, comult, object2 );
    
    antipode := List( elements, a ->
                      Position( elements, Inverse( a ) ) );
    antipode := CertainRows( id, antipode );
    antipode := MorphismConstructor( B, object, antipode, object );
    
    hopf_monoid := ObjectConstructor( CategoryOfHopfMonoids( B ),
                           NTuple( 6,
                                   object,
                                   unit,
                                   mult,
                                   counit,
                                   comult,
                                   antipode ) );
    
    hopf_monoid!.set_theoretic_group := set_theoretic_group;
    hopf_monoid!.elements := elements;
    
    return hopf_monoid;
    
end );

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
InstallMethod( DisplayString,
        [ IsInternalHopfMonoid ],

  function( hopf_monoid )
    local sextuple;

    sextuple := ObjectDatum( hopf_monoid );
    
    return Concatenation(
                   "Multiplication of Hopf monoid:\n\n",
                   StringDisplay( sextuple[3] ),
                   "\nComultiplication of Hopf monoid:\n\n",
                   StringDisplay( sextuple[5] ),
                   "\nAntipode of Hopf monoid:\n\n",
                   StringDisplay( sextuple[6] ),
                   "\nUnit of Hopf monoid:\n\n",
                   StringDisplay( sextuple[2] ),
                   "\nCounit of Hopf monoid:\n\n",
                   StringDisplay( sextuple[4] ),
                   "\nObject of Hopf monoid:\n\n",
                   StringDisplay( sextuple[1] ),
                   "\nA hopf_monoid given by the above data" );
    
end );

##
InstallMethod( DisplayString,
        [ IsInternalHopfMonoidMorphism ],

  function( hopf_monoid_morphism )
    
    return Concatenation(
                   StringDisplay( MorphismDatum( hopf_monoid_morphism ) ),
                   "\nA hopf_monoid morphism given by the above data" );
    
end );
