# Spdx-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Implementations
#

##
InstallMethod( CategoryOfBimonoids,
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    local object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          MonB, ComonMonB,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          BimonB;
    
    ##
    object_datum_type :=
      CapJitDataTypeOfNTupleOf( 5,
              CapJitDataTypeOfObjectOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ) );
    
    ##
    object_constructor :=
      function( BimonB, quintuple_of_object_unit_multiplication_counit_comultiplication )
        local B;
        
        B := UnderlyingCategory( BimonB );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                Length( quintuple_of_object_unit_multiplication_counit_comultiplication ) = 5 and
                IsCapCategoryObject( quintuple_of_object_unit_multiplication_counit_comultiplication[1] ) and
                ForAll( quintuple_of_object_unit_multiplication_counit_comultiplication{[ 2 .. 5 ]}, IsCapCategoryMorphism ) and
                ForAll( quintuple_of_object_unit_multiplication_counit_comultiplication, cell -> IsIdenticalObj( B, CapCategory( cell ) ) ) );
        
        return CreateCapCategoryObjectWithAttributes( BimonB,
                       DefiningQuintupleOfInternalBimonoid, quintuple_of_object_unit_multiplication_counit_comultiplication );
        
    end;
    
    ##
    object_datum := { BimonB, bimonoid } -> DefiningQuintupleOfInternalBimonoid( bimonoid );
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfMorphismOfCategory( B );
    
    ##
    morphism_constructor :=
      function ( BimonB, source, morphism, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsCapCategoryMorphism( morphism ) and
                IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( BimonB ) ) );
        
        return CreateCapCategoryMorphismWithAttributes( BimonB,
                       source,
                       target,
                       UnderlyingMorphism, morphism );
        
    end;
    
    ##
    morphism_datum := { BimonB, bimonoid_morphism } -> UnderlyingMorphism( bimonoid_morphism );
    
    ## building the categorical tower:
    
    MonB := CategoryOfMonoids( B : FinalizeCategory := true );
    ComonMonB := CategoryOfComonoids( MonB : FinalizeCategory := true );
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( BimonB, quintuple_of_object_unit_multiplication_counit_comultiplication )
        local ComonMonB, MonB, object, unit, mult, monoid, counit, comult;
        
        ComonMonB := ModelingCategory( BimonB );
        
        MonB := UnderlyingCategory( ComonMonB );
        
        object := quintuple_of_object_unit_multiplication_counit_comultiplication[1];
        unit := quintuple_of_object_unit_multiplication_counit_comultiplication[2];
        mult := quintuple_of_object_unit_multiplication_counit_comultiplication[3];
        
        monoid := ObjectConstructor( MonB,
                          Triple( object,
                                  unit,
                                  mult ) );
        
        counit := MorphismConstructor( MonB,
                          monoid,
                          quintuple_of_object_unit_multiplication_counit_comultiplication[4],
                          TensorUnit( MonB ) );
        
        comult := MorphismConstructor( MonB,
                          monoid,
                          quintuple_of_object_unit_multiplication_counit_comultiplication[5],
                          TensorProductOnObjects( MonB,
                                  monoid,
                                  monoid ) );
        
        return ObjectConstructor( ComonMonB,
                       Triple( monoid,
                               counit,
                               comult ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function( BimonB, P )
        local ComonMonB, MonB, triple_of_monoid_counit_comultiplication, triple_of_object_unit_multiplication, object, unit, mult, counit, comult;
        
        ComonMonB := ModelingCategory( BimonB );
        
        MonB := UnderlyingCategory( ComonMonB );
        
        triple_of_monoid_counit_comultiplication := ObjectDatum( ComonMonB, P );
        
        triple_of_object_unit_multiplication := ObjectDatum( MonB, triple_of_monoid_counit_comultiplication[1] );
        
        object := triple_of_object_unit_multiplication[1];
        unit := triple_of_object_unit_multiplication[2];
        mult := triple_of_object_unit_multiplication[3];
        counit := MorphismDatum( MonB, triple_of_monoid_counit_comultiplication[2] );
        comult := MorphismDatum( MonB, triple_of_monoid_counit_comultiplication[3] );
        
        return NTuple( 5,
                       object,
                       unit,
                       mult,
                       counit,
                       comult );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( BimonB, source, morphism, target )
        local ComonMonB, MonB;
        
        ComonMonB := ModelingCategory( BimonB );
        
        MonB := UnderlyingCategory( ComonMonB );
        
        return MorphismConstructor( ComonMonB,
                       source,
                       MorphismConstructor( MonB,
                               ObjectDatum( ComonMonB, source )[1],
                               morphism,
                               ObjectDatum( ComonMonB, target )[1] ),
                       target );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum :=
      function( BimonB, phi )
        local ComonMonB, MonB;
        
        ComonMonB := ModelingCategory( BimonB );
        
        MonB := UnderlyingCategory( ComonMonB );
        
        return  MorphismDatum( MonB,
                        MorphismDatum( ComonMonB, phi ) );
        
    end;
    
    ##
    BimonB :=
      ReinterpretationOfCategory( ComonMonB,
              rec( name := Concatenation( "CategoryOfBimonoids( ", Name( B ), " )" ),
                   category_filter := IsCategoryOfInternalBimonoids,
                   category_object_filter := IsInternalBimonoid,
                   category_morphism_filter := IsInternalBimonoidMorphism,
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
    
    SetUnderlyingCategory( BimonB, B );
    
    SetAssociatedCategoryOfMonoids( BimonB, MonB );
    SetAssociatedCategoryOfComonoids( BimonB, CategoryOfComonoids( B ) );
    
    Append( BimonB!.compiler_hints.category_attribute_names,
            [ "UnderlyingCategory",
              "AssociatedCategoryOfMonoids",
              "AssociatedCategoryOfComonoids",
              ] );
    
    Finalize( BimonB );
    
    return BimonB;
    
end );

##
InstallMethod( CategoryOfBimonoids2,
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    local object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          ComonB, MonComonB,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          BimonB;
    
    ##
    object_datum_type :=
      CapJitDataTypeOfNTupleOf( 5,
              CapJitDataTypeOfObjectOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ) );
    
    ##
    object_constructor :=
      function( BimonB, quintuple_of_object_unit_multiplication_counit_comultiplication )
        local B;
        
        B := UnderlyingCategory( BimonB );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                Length( quintuple_of_object_unit_multiplication_counit_comultiplication ) = 5 and
                IsCapCategoryObject( quintuple_of_object_unit_multiplication_counit_comultiplication[1] ) and
                ForAll( quintuple_of_object_unit_multiplication_counit_comultiplication{[ 2 .. 5 ]}, IsCapCategoryMorphism ) and
                ForAll( quintuple_of_object_unit_multiplication_counit_comultiplication, cell -> IsIdenticalObj( B, CapCategory( cell ) ) ) );
        
        return CreateCapCategoryObjectWithAttributes( BimonB,
                       DefiningQuintupleOfInternalBimonoid, quintuple_of_object_unit_multiplication_counit_comultiplication );
        
    end;
    
    ##
    object_datum := { BimonB, bimonoid } -> DefiningQuintupleOfInternalBimonoid( bimonoid );
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfMorphismOfCategory( B );
    
    ##
    morphism_constructor :=
      function ( BimonB, source, morphism, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsCapCategoryMorphism( morphism ) and
                IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( BimonB ) ) );
        
        return CreateCapCategoryMorphismWithAttributes( BimonB,
                       source,
                       target,
                       UnderlyingMorphism, morphism );
        
    end;
    
    ##
    morphism_datum := { BimonB, bimonoid_morphism } -> UnderlyingMorphism( bimonoid_morphism );
    
    ## building the categorical tower:
    
    ComonB := CategoryOfComonoids( B : FinalizeCategory := true );
    MonComonB := CategoryOfMonoids( ComonB : FinalizeCategory := true );
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( BimonB, quintuple_of_object_unit_multiplication_counit_comultiplication )
        local MonComonB, ComonB, object, counit, comult, comonoid, unit, mult;
        
        MonComonB := ModelingCategory( BimonB );
        
        ComonB := UnderlyingCategory( MonComonB );
        
        object := quintuple_of_object_unit_multiplication_counit_comultiplication[1];
        counit := quintuple_of_object_unit_multiplication_counit_comultiplication[4];
        comult := quintuple_of_object_unit_multiplication_counit_comultiplication[5];
        
        comonoid := ObjectConstructor( ComonB,
                            Triple( object,
                                    counit,
                                    comult ) );
        
        unit := MorphismConstructor( ComonB,
                        TensorUnit( ComonB ),
                        quintuple_of_object_unit_multiplication_counit_comultiplication[2],
                        comonoid );
        
        mult := MorphismConstructor( ComonB,
                        TensorProductOnObjects( ComonB,
                                comonoid,
                                comonoid ),
                        quintuple_of_object_unit_multiplication_counit_comultiplication[3],
                        comonoid );
        
        return ObjectConstructor( MonComonB,
                       Triple( comonoid,
                               unit,
                               mult ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function( BimonB, P )
        local MonComonB, ComonB, triple_of_comonoid_unit_multiplication, triple_of_object_counit_comultiplication, object, counit, comult, unit, mult;
        
        MonComonB := ModelingCategory( BimonB );
        
        ComonB := UnderlyingCategory( MonComonB );
        
        triple_of_comonoid_unit_multiplication := ObjectDatum( MonComonB, P );
        
        triple_of_object_counit_comultiplication := ObjectDatum( ComonB, triple_of_comonoid_unit_multiplication[1] );
        
        object := triple_of_object_counit_comultiplication[1];
        counit := triple_of_object_counit_comultiplication[2];
        comult := triple_of_object_counit_comultiplication[3];
        unit := MorphismDatum( ComonB, triple_of_comonoid_unit_multiplication[2] );
        mult := MorphismDatum( ComonB, triple_of_comonoid_unit_multiplication[3] );
        
        return NTuple( 5,
                       object,
                       unit,
                       mult,
                       counit,
                       comult );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( BimonB, source, morphism, target )
        local MonComonB, ComonB;
        
        MonComonB := ModelingCategory( BimonB );
        
        ComonB := UnderlyingCategory( MonComonB );
        
        return MorphismConstructor( MonComonB,
                       source,
                       MorphismConstructor( ComonB,
                               ObjectDatum( MonComonB, source )[1],
                               morphism,
                               ObjectDatum( MonComonB, target )[1] ),
                       target );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum :=
      function( BimonB, phi )
        local MonComonB, ComonB;
        
        MonComonB := ModelingCategory( BimonB );
        
        ComonB := UnderlyingCategory( MonComonB );
        
        return  MorphismDatum( ComonB,
                        MorphismDatum( MonComonB, phi ) );
        
    end;
    
    ##
    BimonB :=
      ReinterpretationOfCategory( MonComonB,
              rec( name := Concatenation( "CategoryOfBimonoids2( ", Name( B ), " )" ),
                   category_filter := IsCategoryOfInternalBimonoids,
                   category_object_filter := IsInternalBimonoid,
                   category_morphism_filter := IsInternalBimonoidMorphism,
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
    
    SetUnderlyingCategory( BimonB, B );
    
    SetAssociatedCategoryOfComonoids( BimonB, ComonB );
    SetAssociatedCategoryOfMonoids( BimonB, CategoryOfMonoids( B ) );
    
    Append( BimonB!.compiler_hints.category_attribute_names,
            [ "UnderlyingCategory",
              "AssociatedCategoryOfMonoids",
              "AssociatedCategoryOfComonoids",
              ] );
    
    Finalize( BimonB );
    
    return BimonB;
    
end );

##
InstallMethod( UnderlyingObject,
        [ IsInternalBimonoid ],

  function( bimonoid )
    
    return ObjectDatum( bimonoid )[1];
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingMonoid,
        [ IsCategoryOfInternalBimonoids, IsInternalBimonoid ],

  function( BimonB, bimonoid )
    local quintuple;
    
    quintuple := ObjectDatum( BimonB, bimonoid );
    
    return ObjectConstructor( AssociatedCategoryOfMonoids( BimonB ),
                   Triple( quintuple[1],
                           quintuple[2],
                           quintuple[3] ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingComonoid,
        [ IsCategoryOfInternalBimonoids, IsInternalBimonoid ],

  function( BimonB, bimonoid )
    local quintuple;
    
    quintuple := ObjectDatum( BimonB, bimonoid );
    
    return ObjectConstructor( AssociatedCategoryOfComonoids( BimonB ),
                   Triple( quintuple[1],
                           quintuple[4],
                           quintuple[5] ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingMonoidMorphism,
        [ IsCategoryOfInternalBimonoids, IsInternalBimonoidMorphism ],
        
  function( BimonB, bimonoid_morphism )
    
    return MorphismConstructor( AssociatedCategoryOfMonoids( BimonB ),
                   UnderlyingMonoid( BimonB, Source( bimonoid_morphism ) ),
                   MorphismDatum( BimonB, bimonoid_morphism ),
                   UnderlyingMonoid( BimonB, Target( bimonoid_morphism ) ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingComonoidMorphism,
        [ IsCategoryOfInternalBimonoids, IsInternalBimonoidMorphism ],
        
  function( BimonB, bimonoid_morphism )
    
    return MorphismConstructor( AssociatedCategoryOfComonoids( BimonB ),
                   UnderlyingComonoid( BimonB, Source( bimonoid_morphism ) ),
                   MorphismDatum( BimonB, bimonoid_morphism ),
                   UnderlyingComonoid( BimonB, Target( bimonoid_morphism ) ) );
    
end );

##
InstallMethod( DualBimonoid,
        [ IsInternalBimonoid ],

  function( bimonoid )
    local BimonB, B, quintuple, dual;
    
    BimonB := CapCategory( bimonoid );
    
    B := UnderlyingCategory( BimonB );
    
    if not CanCompute( B, "DualOnMorphisms" ) then
        TryNextMethod( );
    fi;
    
    quintuple := ObjectDatum( BimonB, bimonoid );
    
    dual := DualOnObjects( B, quintuple[1] );
    
    return ObjectConstructor( BimonB,
                   NTuple( 5,
                           dual,
                           DualOnMorphismsWithGivenDuals( B,
                                   TensorUnit( B ),
                                   quintuple[4],
                                   dual ),
                           DualOnMorphismsWithGivenDuals( B,
                                   TensorProductOnObjects( B,
                                           dual,
                                           dual ),
                                   quintuple[5],
                                   dual ),
                           DualOnMorphismsWithGivenDuals( B,
                                   dual,
                                   quintuple[2],
                                   TensorUnit( B ) ),
                           DualOnMorphismsWithGivenDuals( B,
                                   dual,
                                   quintuple[3],
                                   TensorProductOnObjects( B,
                                           dual,
                                           dual ) ) ) );
    
end );

##
InstallMethod( LinearizationOfSetMonoid,
        [ IsMonoidalCategory and IsLinearCategoryOverCommutativeRing, IsMonoid ],
        
  function( B, set_theoretic_monoid )
    local dim, U, object, object2, elements, k, id, o, unit, mult, counit, comult, bimonoid;
    
    dim := Size( set_theoretic_monoid );
    
    U := TensorUnit( B );
    
    object := ObjectConstructor( B, dim );
    
    object2 := TensorProductOnObjects( B, object, object );
    
    elements := Elements( set_theoretic_monoid );
    
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
                      List( [ 1 .. dim ], i -> KroneckerMat( CertainRows( id, [ i ] ),  CertainRows( id, [ i ] ) ) ) );
    comult := MorphismConstructor( B, object, comult, object2 );
    
    bimonoid := ObjectConstructor( CategoryOfBimonoids( B ),
                        NTuple( 5,
                                object,
                                unit,
                                mult,
                                counit,
                                comult ) );
    
    bimonoid!.set_theoretic_monoid := set_theoretic_monoid;
    bimonoid!.elements := elements;
    
    return bimonoid;
    
end );

##
InstallMethod( TransformedBimonoid,
        [ IsCapCategoryMorphism, IsInternalBimonoid ],
        
  function( iso, monoid )
    local MonB, B, quintuple, object, unit, mult, counit, comult, inv;
    
    MonB := CapCategory( monoid );
    
    B := UnderlyingCategory( MonB );
    
    quintuple := ObjectDatum( MonB, monoid );
    
    object := quintuple[1];
    unit := quintuple[2];
    mult := quintuple[3];
    counit := quintuple[4];
    comult := quintuple[5];
    
    if not IsIdenticalObj( B, CapCategory( iso ) ) then
        Error( "the category of the isomorphism `iso` and the underlying category `B` do not coincide\n" );
    fi;
    
    Assert( 0, IsEndomorphism( iso ) and IsEqualForObjects( B, Source( iso ), object ) );
    Assert( 0, IsIsomorphism( iso ) );
    
    inv := InverseForMorphisms( B, iso );
    
    return ObjectConstructor( MonB,
                   NTuple( 5,
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
                                   Target( comult ) ) ) );
    
end );

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
InstallMethod( DisplayString,
        [ IsInternalBimonoid ],

  function( bimonoid )
    local quintuple;

    quintuple := ObjectDatum( bimonoid );
    
    return Concatenation(
                   "Multiplication of bimonoid:\n\n",
                   StringDisplay( quintuple[3] ),
                   "\nComultiplication of bimonoid:\n\n",
                   StringDisplay( quintuple[5] ),
                   "\nUnit of bimonoid:\n\n",
                   StringDisplay( quintuple[2] ),
                   "\nCounit of bimonoid:\n\n",
                   StringDisplay( quintuple[4] ),
                   "\nObject of bimonoid:\n\n",
                   StringDisplay( quintuple[1] ),
                   "\nA bimonoid given by the above data" );
    
end );

##
InstallMethod( DisplayString,
        [ IsInternalBimonoidMorphism ],

  function( bimonoid_morphism )
    
    return Concatenation(
                   StringDisplay( MorphismDatum( bimonoid_morphism ) ),
                   "\nA bimonoid morphism given by the above data" );
    
end );
