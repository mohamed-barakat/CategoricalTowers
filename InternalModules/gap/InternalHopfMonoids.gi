# Spdx-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Implementations
#

##
InstallMethodForCompilerForCAP( LeftAntipodeLawOfHopfMonoid,
        "for a symmetric monoidal category, one object, and five morphisms therein",
        [ IsMonoidalCategory, IsCapCategoryObject, IsList, IsList, IsCapCategoryMorphism ],
        
  function( B, object, unit_mult, counit_comult, antipode )
    local unit, mult, counit, comult, lhs_left_antipode, rhs_antipode, bool, obstruction;
    
    unit := unit_mult[1];
    mult := unit_mult[2];
    
    counit := counit_comult[1];
    comult := counit_comult[2];
    
    lhs_left_antipode := PreCompose( B,
                                 PreCompose( B,
                                         comult,
                                         TensorProductOnMorphisms( B,
                                                 antipode,
                                                 IdentityMorphism( B, object ) ) ),
                                 mult );
    
    rhs_antipode := PreCompose( B,
                            counit,
                            unit );
    
    bool := IsCongruentForMorphisms( B, lhs_left_antipode, rhs_antipode );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    obstruction := ValueOption( "obstruction" );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    if not bool and not obstruction = fail then
        Add( obstruction, Pair( Pair( lhs_left_antipode, rhs_antipode ), "LeftAntipodeLawOfHopfMonoid" ) );
        return true;
    fi;
    
    return bool;
    
end );

##
InstallMethodForCompilerForCAP( RightAntipodeLawOfHopfMonoid,
        "for a symmetric monoidal category, one object, and five morphisms therein",
        [ IsMonoidalCategory, IsCapCategoryObject, IsList, IsList, IsCapCategoryMorphism ],
        
  function( B, object, unit_mult, counit_comult, antipode )
    local unit, mult, counit, comult, lhs_right_antipode, rhs_antipode, bool, obstruction;
    
    unit := unit_mult[1];
    mult := unit_mult[2];
    
    counit := counit_comult[1];
    comult := counit_comult[2];
    
    lhs_right_antipode := PreCompose( B,
                                  PreCompose( B,
                                          comult,
                                          TensorProductOnMorphisms( B,
                                                  IdentityMorphism( B, object ),
                                                  antipode ) ),
                                  mult );
    
    rhs_antipode := PreCompose( B,
                            counit,
                            unit );
    
    bool := IsCongruentForMorphisms( B, lhs_right_antipode, rhs_antipode );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    obstruction := ValueOption( "obstruction" );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    if not bool and not obstruction = fail then
        Add( obstruction, Pair( Pair( lhs_right_antipode, rhs_antipode ), "RightAntipodeLawOfHopfMonoid" ) );
        return true;
    fi;
    
    return bool;
    
end );

##
InstallMethod( CATEGORY_OF_HOPF_MONOIDS,
        "for a monoidal category",
        [ IsCapCategory and IsMonoidalCategory ],
        
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
    
    SetAssociatedCategoryOfMonoids( HmonB, CATEGORY_OF_MONOIDS( B ) );
    SetAssociatedCategoryOfComonoids( HmonB, CATEGORY_OF_COMONOIDS( B ) );

    if ValueOption( "reverse" ) = true then
        SetAssociatedCategoryOfBimonoids( HmonB, CATEGORY_OF_BIMONOIDS_AS_MONOIDS_OF_COMONOIDS( B ) );
    else
        SetAssociatedCategoryOfBimonoids( HmonB, CATEGORY_OF_BIMONOIDS_AS_COMONOIDS_OF_MONOIDS( B ) );
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
        local B, sextuple, object, unit, mult, counit, comult, antipode;
        
        B := UnderlyingCategory( HmonB );
        
        sextuple := ObjectDatum( HmonB, hopf_monoid );
        
        object := sextuple[1];
        unit := sextuple[2];
        mult := sextuple[3];
        counit := sextuple[4];
        comult := sextuple[5];
        antipode := sextuple[6];
        
        return IsWellDefinedForObjects( AssociatedCategoryOfBimonoids( HmonB ), UnderlyingBimonoid( HmonB, hopf_monoid ) ) and
               LeftAntipodeLawOfHopfMonoid( B, object, Pair( unit, mult ), Pair( counit, comult ), antipode ) and
               RightAntipodeLawOfHopfMonoid( B, object, Pair( unit, mult ), Pair( counit, comult ), antipode );
               
    end );
    
    ##
    AddIsWellDefinedForMorphisms( HmonB,
      function( HmonB, hopf_monoid_morphism )
        
        ## Since a bimonoid can have at most one antipode,
        ## a bimonoid morphism between two Hopf monoids is automatically a Hopf monoid morphism:
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
                       TensorProductOnMorphismsWithGivenTensorProducts( B,
                               ObjectDatum( HmonB, source )[1],
                               MorphismDatum( HmonB, hopf_monoid_morphism1 ),
                               MorphismDatum( HmonB, hopf_monoid_morphism2 ),
                               ObjectDatum( HmonB, target )[1] ),
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
    
    if HasIsRigidSymmetricClosedMonoidalCategory( B ) and IsRigidSymmetricClosedMonoidalCategory( B ) then
        
        SetIsRigidSymmetricClosedMonoidalCategory( HmonB, true );
        
        if CanCompute( B, "DualOnMorphisms" ) then
            
            ##
            AddDualOnObjects( HmonB,
              function( HmonB, hopf_monoid )
                local B, antipode, BimonB, bimonoid, quintuple, dual_object;
                
                B := UnderlyingCategory( HmonB );
                
                antipode := ObjectDatum( HmonB, hopf_monoid )[6];
                
                BimonB := AssociatedCategoryOfBimonoids( HmonB );
                
                bimonoid := UnderlyingBimonoid( HmonB,
                                    hopf_monoid );
                
                quintuple := ObjectDatum( BimonB,
                                     DualOnObjects( BimonB,
                                             bimonoid ) );
                
                dual_object := quintuple[1];

                return ObjectConstructor( HmonB,
                               NTuple( 6,
                                       dual_object,
                                       quintuple[2],
                                       quintuple[3],
                                       quintuple[4],
                                       quintuple[5],
                                       DualOnMorphismsWithGivenDuals( B,
                                               dual_object,
                                               antipode,
                                               dual_object ) ) );
                
            end );
            
            ##
            AddDualOnMorphismsWithGivenDuals( HmonB,
              function( HmonB, source, hopf_monoid_morphism, target )
                local B;
                
                B := UnderlyingCategory( HmonB );
                
                return MorphismConstructor( HmonB,
                               source,
                               DualOnMorphismsWithGivenDuals( B,
                                       ObjectDatum( HmonB, source )[1],
                                       MorphismDatum( HmonB, hopf_monoid_morphism ),
                                       ObjectDatum( HmonB, target )[1] ),
                               target );
                
            end );
            
            ##
            AddEvaluationForDualWithGivenTensorProduct( HmonB,
              function( HmonB, source, hopf_monoid, target )
                local B;
                
                B := UnderlyingCategory( HmonB );
                
                return MorphismConstructor( HmonB,
                               source,
                               EvaluationForDualWithGivenTensorProduct( B,
                                       ObjectDatum( HmonB, source )[1],
                                       ObjectDatum( HmonB, hopf_monoid )[1],
                                       ObjectDatum( HmonB, target )[1] ),
                               target );
                
            end );
            
            ##
            AddCoevaluationForDualWithGivenTensorProduct( HmonB,
              function( HmonB, source, hopf_monoid, target )
                local B;
                
                B := UnderlyingCategory( HmonB );
                
                return MorphismConstructor( HmonB,
                               source,
                               CoevaluationForDualWithGivenTensorProduct( B,
                                       ObjectDatum( HmonB, source )[1],
                                       ObjectDatum( HmonB, hopf_monoid )[1],
                                       ObjectDatum( HmonB, target )[1] ),
                               target );
                
            end );
            
        fi;
        
    fi;
    
    Finalize( HmonB );
    
    return HmonB;
    
end );

##
InstallMethod( CategoryOfHopfMonoids,
        "for a monoidal category",
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    
    return CATEGORY_OF_HOPF_MONOIDS( B );
    
end );

##
InstallMethod( UnderlyingObject,
        "for an internal Hopf monoid",
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    
    return ObjectDatum( hopf_monoid )[1];
    
end );

##
InstallMethod( \.,
        "for an internal Hopf monoid",
        [ IsInternalHopfMonoid, IsPosInt ],
        
  function ( hopf_monoid, string_as_int )
    local name, datum;
    
    name := NameRNam( string_as_int );
    
    datum := ObjectDatum( hopf_monoid );
    
    if name = "object" then
        return datum[1];
    elif name = "unit" then
        return datum[2];
    elif name = "mult" or name = "multiplication" then
        return datum[3];
    elif name = "counit" then
        return datum[4];
    elif name = "comult" or name = "comultiplication" then
        return datum[5];
    elif name = "antipode" then
        return datum[6];
    else
        Error( "the Hopf monoid only has the componenets `object`, `unit`, `mult` (or `multiplication`), `counit`, `comult` (or `comultiplication`), `antipode`" );
    fi;
    
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
InstallMethod( UnderlyingMonoid,
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    
    return UnderlyingMonoid( CapCategory( hopf_monoid ), hopf_monoid );
    
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
InstallMethod( UnderlyingMonoidMorphism,
        [ IsInternalHopfMonoidMorphism ],
        
  function( hopf_monoid_morphism )
    
    return UnderlyingMonoidMorphism( CapCategory( hopf_monoid_morphism ), hopf_monoid_morphism );
    
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
InstallMethod( UnderlyingComonoid,
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    
    return UnderlyingComonoid( CapCategory( hopf_monoid ), hopf_monoid );
    
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
InstallMethod( UnderlyingComonoidMorphism,
        [ IsInternalHopfMonoidMorphism ],
        
  function( hopf_monoid_morphism )
    
    return UnderlyingComonoidMorphism( CapCategory( hopf_monoid_morphism ), hopf_monoid_morphism );
    
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
InstallMethod( UnderlyingBimonoid,
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    
    return UnderlyingBimonoid( CapCategory( hopf_monoid ), hopf_monoid );
    
end );

##
InstallMethod( UnderlyingBimonoidMorphism,
        [ IsInternalHopfMonoidMorphism ],
        
  function( hopf_monoid_morphism )
    
    return UnderlyingBimonoidMorphism( CapCategory( hopf_monoid_morphism ), hopf_monoid_morphism );
    
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
InstallMethod( IsCommutative,
        "for an internal Hopf monoid",
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    
    return IsCommutative( UnderlyingBimonoid( hopf_monoid ) );
    
end );

##
InstallMethod( IsCocommutative,
        "for an internal Hopf monoid",
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    
    return IsCocommutative( UnderlyingBimonoid( hopf_monoid ) );
    
end );

##
InstallMethod( OppositeHopfMonoid,
        "for an internal Hopf monoid",
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    local HmonB, B, sextuple, object;
    
    HmonB := CapCategory( hopf_monoid );
    
    B := UnderlyingCategory( HmonB );
    
    sextuple := ObjectDatum( HmonB, hopf_monoid );
    
    object := sextuple[1];
    
    return ObjectConstructor( HmonB,
                   NTuple( 6,
                           sextuple[1],
                           sextuple[2],
                           PreCompose( B,
                                   Braiding( B,
                                           object,
                                           object ),
                                   sextuple[3] ),
                           sextuple[4],
                           sextuple[5],
                           InverseForMorphisms( B,
                                   sextuple[6] ) ) );
    
end );

##
InstallMethod( CoOppositeHopfMonoid,
        "for an internal Hopf monoid",
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    local HmonB, B, sextuple, object;
    
    HmonB := CapCategory( hopf_monoid );
    
    B := UnderlyingCategory( HmonB );
    
    sextuple := ObjectDatum( HmonB, hopf_monoid );
    
    object := sextuple[1];
    
    return ObjectConstructor( HmonB,
                   NTuple( 6,
                           sextuple[1],
                           sextuple[2],
                           sextuple[3],
                           sextuple[4],
                           PreCompose( B,
                                   sextuple[5],
                                   Braiding( B,
                                           object,
                                           object ) ),
                           InverseForMorphisms( B,
                                   sextuple[6] ) ) );
    
end );

##
InstallMethod( OppositeCoOppositeHopfMonoid,
        "for an internal Hopf monoid",
        [ IsInternalHopfMonoid ],
        
  function( hopf_monoid )
    
    return CoOppositeHopfMonoid( OppositeHopfMonoid( hopf_monoid ) );
    
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

##
InstallMethod( TransformedHopfMonoid,
        "for a morphism and an internal Hopf monoid",
        [ IsCapCategoryMorphism, IsInternalHopfMonoid ],
        
  function( iso, hopf_monoid )
    local HmonB, B, sextuple, object, unit, mult, counit, comult, antipode, inv;
    
    HmonB := CapCategory( hopf_monoid );
    
    B := UnderlyingCategory( HmonB );
    
    sextuple := ObjectDatum( HmonB, hopf_monoid );
    
    object := sextuple[1];
    unit := sextuple[2];
    mult := sextuple[3];
    counit := sextuple[4];
    comult := sextuple[5];
    antipode := sextuple[6];
    
    if not IsIdenticalObj( B, CapCategory( iso ) ) then
        Error( "the category of the isomorphism `iso` and the underlying category `B` do not coincide\n" );
    fi;
    
    Assert( 0, IsEndomorphism( iso ) and IsEqualForObjects( B, Source( iso ), object ) );
    Assert( 0, IsIsomorphism( iso ) );
    
    inv := InverseForMorphisms( B, iso );
    
    return ObjectConstructor( HmonB,
                   NTuple( 6,
                           object,
                           PreCompose( B,
                                   unit,
                                   iso ),
                           PreComposeList( B,
                                   Source( mult ),
                                   [ TensorProductOnMorphisms( B,
                                           inv,
                                           inv ),
                                     mult,
                                     iso ],
                                   Target( mult ) ),
                           PreCompose( B,
                                   inv,
                                   counit ),
                           PreComposeList( B,
                                   Source( comult ),
                                   [ inv,
                                     comult,
                                     TensorProductOnMorphisms( B,
                                             iso,
                                             iso ) ],
                                   Target( comult ) ),
                           PreComposeList( B,
                                   Source( antipode ),
                                   [ inv,
                                     antipode,
                                     iso ],
                                   Target( antipode ) ) ) );
    
end );

##
InstallOtherMethod( Pullback,
        "for a ring map and an internal Hopf monoid",
        [ IsHomalgRingMap, IsCategoryOfRows, IsInternalHopfMonoid ],
        
  function( ring_map, B, hopf_monoid )
    local HmonB, sextuple, C, HmonC, object, unit, mult, counit, comult, antipode;
    
    HmonB := CapCategory( hopf_monoid );
    
    Assert( 0, HasUnderlyingRing( B ) );
    #Assert( 0, IsIdenticalObj( UnderlyingRing( B ), Source( ring_map ) ) );
    
    C := CategoryOfRows( Range( ring_map ) );
    
    HmonC := CategoryOfHopfMonoids( C );
    
    sextuple := ObjectDatum( HmonB, hopf_monoid );
    
    object := sextuple[1];
    unit := sextuple[2];
    mult := sextuple[3];
    counit := sextuple[4];
    comult := sextuple[5];
    antipode := sextuple[6];
    
    return ObjectConstructor( HmonC,
                   NTuple( 6,
                           ObjectDatum( object ) / C,
                           Pullback( ring_map, MorphismDatum( unit ) ) / C,
                           Pullback( ring_map, MorphismDatum( mult ) ) / C,
                           Pullback( ring_map, MorphismDatum( counit ) ) / C,
                           Pullback( ring_map, MorphismDatum( comult ) ) / C,
                           Pullback( ring_map, MorphismDatum( antipode ) ) / C ) );
    
end );

##
InstallMethod( Pullback,
        "for a ring map and an internal Hopf monoid",
        [ IsHomalgRingMap, IsInternalHopfMonoid ],
        
  function( ring_map, hopf_monoid )
    
    return Pullback( ring_map, UnderlyingCategory( CapCategory( hopf_monoid ) ), hopf_monoid );
    
end );

##
InstallMethod( HopfMonoid,
        "for an internal bimonoid",
        [ IsInternalBimonoid and HasUnderlyingAlgebra, IsList ],
        
  function( bimonoid, antipode_list )
    local BimonB, B, k, A, o, basis, decompose, basis_decomp, object, unit, mult, counit, comult, antipode, hopf_monoid;
    
    BimonB := CapCategory( bimonoid );
    
    B := UnderlyingCategory( BimonB );
    
    k := CommutativeRingOfLinearCategory( B );
    
    A := UnderlyingAlgebra( bimonoid );
    
    o := SetOfObjects( A );
    
    Assert( 0, Length( o ) = 1 );
    
    o := o[1];
    
    basis := BasisOfExternalHom( o, o );
    
    decompose :=
      function( b )
        local decomp;
        
        if IsQuotientCategoryMorphism( b ) then
            b := CanonicalRepresentative( b );
        fi;
        decomp := MorphismDatum( b );
        Assert( 0, Length( decomp[1] ) = 1 and Length( decomp[2] ) = 1 and IsOne( decomp[1][1] ) );
        return MorphismDatum( decomp[2][1] )[2];
    end;
    
    basis_decomp := List( basis, decompose );
    
    object := bimonoid.object;
    unit := bimonoid.unit;
    mult := bimonoid.mult;
    counit := bimonoid.counit;
    comult := bimonoid.comult;
    
    antipode := List( antipode_list, gen -> Sum( gen, summand -> ( summand[1] / k ) * ( k * MorphismDatum( HomStructure( summand[2] ) ) / B ) ) );
    antipode := List( basis_decomp, indices -> List( indices, i -> antipode[i] ) );
    antipode := List( antipode, images -> Iterated( images, { a, b } -> PreCompose( TensorProduct( b, a ), mult ), unit ) );
    antipode := UniversalMorphismFromDirectSum( antipode );
    
    hopf_monoid := ObjectConstructor( CategoryOfHopfMonoids( B ),
                           NTuple( 6,
                                   object,
                                   unit,
                                   mult,
                                   counit,
                                   comult,
                                   antipode ) );
    
    SetUnderlyingAlgebra( hopf_monoid, A );
    
    return hopf_monoid;
    
end );

##
InstallMethod( HopfMonoid,
        "for an internal monoid",
        [ IsInternalMonoid and HasUnderlyingAlgebra, IsList, IsList, IsList ],
        
  function( monoid, counit_list, comult_list, antipode_list )
    
    return HopfMonoid( Bimonoid( monoid, counit_list, comult_list ), antipode_list );
    
end );

##
InstallMethod( HopfMonoid,
        "for an internal bimonoid",
        [ IsInternalBimonoid and HasUnderlyingAlgebra, IsRecord ],
        
  function( bimonoid, antipode_record )
    local BimonB, B, A, gens, g, antipode_gen_names, antipode_unknown,
          o, basis, dim, antipode_vars, k, vars, R, antipode_func, antipode;
    
    BimonB := CapCategory( bimonoid );
    
    B := UnderlyingCategory( BimonB );
    
    A := UnderlyingAlgebra( bimonoid );
    
    gens := SetOfGeneratingMorphisms( A );
    
    g := Length( gens );
    
    antipode_gen_names := RecNames( antipode_record );
    
    Assert( 0, Length( antipode_gen_names ) = g );
    
    antipode_unknown := Filtered( antipode_gen_names, k -> antipode_record.(k) = fail );
    
    if IsEmpty( antipode_unknown ) then
        
        antipode_func := k -> [ A.(k), antipode_record.(k) ];
        
    else
        
        Assert( 0, HasCommutativeRingOfLinearCategory( B ) );
        
        o := SetOfObjects( A );
        
        Assert( 0, Length( o ) = 1 );
        
        o := o[1];
        
        basis := BasisOfExternalHom( o, o );
        
        dim := Length( basis );
        
        antipode_vars := List( [ 1 .. Length( antipode_unknown ) ], i -> List( [ 1 .. dim ], j -> Concatenation( "s_", antipode_unknown[i], "_", String( j ) ) ) );
        
        k := CommutativeRingOfLinearCategory( B );
        
        vars := Concatenation( antipode_vars );
        
        if IsEmpty( vars ) then
            R := k;
        else
            if HasIndeterminatesOfPolynomialRing( k ) and HasCoefficientsRing( k ) then
                vars := Concatenation( List( IndeterminatesOfPolynomialRing( k ), String ), vars );
                k := CoefficientsRing( k );
            fi;
            
            R := k * vars;
            if Length( vars ) > 3 then
                SetName( R, Concatenation( RingName( k ), "[", vars[1], ",...,", vars[Length( vars )], "]" ) );
            fi;
        fi;
        
        B := CategoryOfRows( R );
        
        antipode_func :=
          function( k )
            local pos, coeffs;
            
            pos := Position( antipode_unknown, k );
            
            if IsInt( pos ) then
                coeffs := antipode_vars[pos];
                return [ A.(k), List( [ 1 .. dim ], i -> [ coeffs[i] / R, basis[i] ] ) ];
            else
                return [ A.(k), antipode_record.(k) ];
            fi;
            
        end;
        
        bimonoid := ObjectConstructor( CategoryOfBimonoids( B ),
                            NTuple( 5,
                                    ObjectDatum( bimonoid.object ) / B,
                                    R * MorphismDatum( bimonoid.unit ) / B,
                                    R * MorphismDatum( bimonoid.mult ) / B,
                                    R * MorphismDatum( bimonoid.counit ) / B,
                                    R * MorphismDatum( bimonoid.comult ) / B ) );
        
        SetUnderlyingAlgebra( bimonoid, A );
        
    fi;
    
    antipode := List( RecNames( antipode_record ), antipode_func );
    antipode := List( gens, gen -> antipode[PositionProperty( antipode, a -> a[1] = gen )][2] );
    
    return HopfMonoid( bimonoid, antipode );
    
end );

##
InstallMethod( HopfMonoid,
        "for an internal monoid",
        [ IsInternalMonoid and HasUnderlyingAlgebra, IsRecord, IsRecord, IsRecord ],
        
  function( monoid, counit_record, comult_record, antipode_record )
    
    return HopfMonoid( Bimonoid( monoid, counit_record, comult_record ), antipode_record );
    
end );

##
InstallMethod( AffineVarietyOfHopfMonoids,
        "for an internal monoid",
        [ IsInternalMonoid ],
        
  function( monoid )
    local B, k, triple, object, unit, mult, dim, counit, comult, antipode, R, rows, hopf_monoid,
          obstruction, extract_matrix, relations, hopf_variety;
    
    B := UnderlyingCategory( CapCategory( monoid ) );
    
    if not HasCommutativeRingOfLinearCategory( B ) then
        TryNextMethod( );
    fi;
    
    k := CommutativeRingOfLinearCategory( B );
    
    triple := ObjectDatum( monoid );
    
    object := triple[1];
    unit := triple[2];
    mult := triple[3];
    
    dim := ObjectDatum( object );
    
    counit := List( [ 1 .. dim ], i -> Concatenation( "e", String( i ) ) );
    comult := List( [ 1 .. dim^3 ], i -> Concatenation( "d", String( i ) ) );
    antipode := List( [ 1 .. dim^2 ], i -> Concatenation( "s", String( i ) ) );
    
    R := k * Concatenation( counit, comult, antipode );
    SetName( R, Concatenation( RingName( k ), "[e1..", String( dim ), ",d1..", String( dim^3 ), ",s1..", String( dim^2 ), "]" ) );
    
    rows := CategoryOfRows( R );
    
    object := dim / rows;
    
    unit := ( R * UnderlyingMatrix( unit ) ) / rows;
    
    mult := ( R * UnderlyingMatrix( mult ) ) / rows;
    
    counit := List( counit, x -> x / R );
    counit := HomalgMatrix( counit, dim, 1, R );
    counit := counit / rows;
    
    comult := List( comult, x -> x / R );
    comult := HomalgMatrix( comult, dim, dim^2, R );
    comult := comult / rows;
    
    antipode := List( antipode, x -> x / R );
    antipode := HomalgMatrix( antipode, dim, dim, R );
    antipode := antipode / rows;
    
    hopf_monoid := ObjectConstructor( CategoryOfHopfMonoids( rows ),
                           NTuple( 6,
                                   object,
                                   unit,
                                   mult,
                                   counit,
                                   comult,
                                   antipode ) );
    
    obstruction := [ ];
    
    IsWellDefined( hopf_monoid : obstruction := obstruction );
    
    extract_matrix :=
      function( mor )
        while IsCapCategoryMorphism( mor ) do
            mor := MorphismDatum( mor );
        od;
        return mor;
    end;
    
    relations := List( obstruction, obs -> ConvertMatrixToColumn( extract_matrix( obs[1][1] ) - extract_matrix( obs[1][2] ) ) );
    relations := List( relations, mat -> CertainRows( mat, NonZeroRows( mat ) ) );
    relations := UnionOfRows( relations );
    
    hopf_variety := ClosedSubsetOfSpec( relations );
    SetParametrizedObject( hopf_variety, hopf_monoid );
    
    return hopf_variety;
    
end );

##
InstallMethod( AffineVarietyOfHopfMonoids,
        "for an internal comonoid",
        [ IsInternalComonoid ],
        
  function( comonoid )
    local B, k, triple, object, counit, comult, dim, unit, mult, antipode, R, rows, hopf_monoid,
          obstruction, extract_matrix, relations, hopf_variety;
    
    B := UnderlyingCategory( CapCategory( comonoid ) );
    
    if not HasCommutativeRingOfLinearCategory( B ) then
        TryNextMethod( );
    fi;
    
    k := CommutativeRingOfLinearCategory( B );
    
    triple := ObjectDatum( comonoid );
    
    object := triple[1];
    counit := triple[2];
    comult := triple[3];
    
    dim := ObjectDatum( object );
    
    unit := List( [ 1 .. dim ], i -> Concatenation( "u", String( i ) ) );
    mult := List( [ 1 .. dim^3 ], i -> Concatenation( "m", String( i ) ) );
    antipode := List( [ 1 .. dim^2 ], i -> Concatenation( "s", String( i ) ) );
    
    R := k * Concatenation( unit, mult, antipode );
    SetName( R, Concatenation( RingName( k ), "[u1..", String( dim ), ",m1..", String( dim^3 ), ",s1..", String( dim^2 ), "]" ) );
    
    rows := CategoryOfRows( R );
    
    object := dim / rows;
    
    counit := ( R * UnderlyingMatrix( counit ) ) / rows;
    
    comult := ( R * UnderlyingMatrix( comult ) ) / rows;
    
    unit := List( unit, x -> x / R );
    unit := HomalgMatrix( unit, 1, dim, R );
    unit := unit / rows;
    
    mult := List( mult, x -> x / R );
    mult := HomalgMatrix( mult, dim^2, dim, R );
    mult := mult / rows;
    
    antipode := List( antipode, x -> x / R );
    antipode := HomalgMatrix( antipode, dim, dim, R );
    antipode := antipode / rows;
    
    hopf_monoid := ObjectConstructor( CategoryOfHopfMonoids( rows : reverse := true ),
                           NTuple( 6,
                                   object,
                                   unit,
                                   mult,
                                   counit,
                                   comult,
                                   antipode ) );
    
    obstruction := [ ];
    
    IsWellDefined( hopf_monoid : obstruction := obstruction );
    
    extract_matrix :=
      function( mor )
        while IsCapCategoryMorphism( mor ) do
            mor := MorphismDatum( mor );
        od;
        return mor;
    end;
    
    relations := List( obstruction, obs -> ConvertMatrixToColumn( extract_matrix( obs[1][1] ) - extract_matrix( obs[1][2] ) ) );
    relations := List( relations, mat -> CertainRows( mat, NonZeroRows( mat ) ) );
    relations := UnionOfRows( relations );
    
    hopf_variety := ClosedSubsetOfSpec( relations );
    SetParametrizedObject( hopf_variety, hopf_monoid );
    
    return hopf_variety;
    
end );

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
InstallMethod( DisplayString,
        "for an internal Hopf monoid",
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
        "for a morphism of internal Hopf monoids",
        [ IsInternalHopfMonoidMorphism ],
        
  function( hopf_monoid_morphism )
    
    return Concatenation(
                   StringDisplay( MorphismDatum( hopf_monoid_morphism ) ),
                   "\nA hopf_monoid morphism given by the above data" );
    
end );
