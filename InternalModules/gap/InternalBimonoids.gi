# Spdx-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Implementations
#

##
InstallMethod( CATEGORY_OF_BIMONOIDS_AS_COMONOIDS_OF_MONOIDS,
        "for a monoidal category",
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
    
    MonB := CATEGORY_OF_MONOIDS( B : FinalizeCategory := true );
    ComonMonB := CATEGORY_OF_COMONOIDS( MonB : FinalizeCategory := false );
    
    if HasIsRigidSymmetricClosedMonoidalCategory( B ) and IsRigidSymmetricClosedMonoidalCategory( B ) then
        
        SetIsRigidSymmetricClosedMonoidalCategory( ComonMonB, true );
        
        if CanCompute( B, "DualOnMorphisms" ) then
            
            ##
            AddDualOnObjects( ComonMonB,
              function( ComonMonB, comonoid_on_monoid )
                local MonB, B, triple_of_monoid_counit_comultiplication, triple_of_object_unit_multiplication, dual_object, unit, mult, monoid, counit, comult;
                
                MonB := UnderlyingCategory( ComonMonB );
                
                B := UnderlyingCategory( MonB );
                
                triple_of_monoid_counit_comultiplication := ObjectDatum( ComonMonB, comonoid_on_monoid );
                
                triple_of_object_unit_multiplication := ObjectDatum( MonB, triple_of_monoid_counit_comultiplication[1] );
                
                dual_object := DualOnObjects( B, triple_of_object_unit_multiplication[1] );
                
                unit := DualOnMorphismsWithGivenDuals( B,
                                TensorUnit( B ),
                                MorphismDatum( MonB, triple_of_monoid_counit_comultiplication[2] ),
                                dual_object );
                
                mult := DualOnMorphismsWithGivenDuals( B,
                                TensorProductOnObjects( B,
                                        dual_object,
                                        dual_object ),
                                MorphismDatum( MonB, triple_of_monoid_counit_comultiplication[3] ),
                                dual_object );
                
                monoid := ObjectConstructor( MonB,
                                  Triple( dual_object,
                                          unit,
                                          mult ) );
                
                counit := MorphismConstructor( MonB,
                                  monoid,
                                  DualOnMorphismsWithGivenDuals( B,
                                          Target( unit ),
                                          triple_of_object_unit_multiplication[2],
                                          Source( unit ) ),
                                  TensorUnit( MonB ) );
                
                comult := MorphismConstructor( MonB,
                                  TensorProductOnObjects( MonB,
                                          monoid,
                                          monoid ),
                                  DualOnMorphismsWithGivenDuals( B,
                                          Target( mult ),
                                          triple_of_object_unit_multiplication[3],
                                          Source( mult ) ),
                                  monoid );
                
                return ObjectConstructor( ComonMonB,
                               Triple( monoid,
                                       counit,
                                       comult ) );
                
            end );
            
            ##
            AddDualOnMorphismsWithGivenDuals( ComonMonB,
              function( ComonMonB, source, comonoid_on_monoid_morphism, target )
                local MonB, B, source_monoid, target_monoid, source_object, target_object, monoid_morphism, morphism,
                      dual_morphism, dual_monoid_morphism;
                
                MonB := UnderlyingCategory( ComonMonB );
                
                B := UnderlyingCategory( MonB );
                
                source_monoid := ObjectDatum( ComonMonB, source )[1];
                target_monoid := ObjectDatum( ComonMonB, target )[1];
                
                source_object := ObjectDatum( MonB, source_monoid )[1];
                target_object := ObjectDatum( MonB, target_monoid )[1];
                
                monoid_morphism := MorphismDatum( ComonMonB, comonoid_on_monoid_morphism );
                
                morphism := MorphismDatum( MonB, monoid_morphism );
                
                dual_morphism := DualOnMorphismsWithGivenDuals( B,
                                         source_object,
                                         morphism,
                                         target_object );
                
                dual_monoid_morphism := MorphismConstructor( MonB,
                                                source_monoid,
                                                dual_morphism,
                                                target_monoid );
                
                return MorphismConstructor( ComonMonB,
                               source,
                               dual_monoid_morphism,
                               target );
                
            end );
            
            ##
            AddEvaluationForDualWithGivenTensorProduct( ComonMonB,
              function( ComonMonB, source, comonoid_on_monoid, target )
                local MonB, B, source_monoid, target_monoid, source_object, target_object, monoid, object,
                      evaluation, monoid_evaluation;
                
                MonB := UnderlyingCategory( ComonMonB );
                
                B := UnderlyingCategory( MonB );
                
                source_monoid := ObjectDatum( ComonMonB, source )[1];
                target_monoid := ObjectDatum( ComonMonB, target )[1];
                
                source_object := ObjectDatum( MonB, source_monoid )[1];
                target_object := ObjectDatum( MonB, target_monoid )[1];
                
                monoid := ObjectDatum( ComonMonB, comonoid_on_monoid )[1];
                
                object := ObjectDatum( MonB, monoid )[1];
                
                evaluation := EvaluationForDualWithGivenTensorProduct( B,
                                      source_object,
                                      object,
                                      target_object );
                
                monoid_evaluation := MorphismConstructor( MonB,
                                             source_monoid,
                                             evaluation,
                                             target_monoid );
                
                return MorphismConstructor( ComonMonB,
                               source,
                               monoid_evaluation,
                               target );
                
            end );
            
            ##
            AddCoevaluationForDualWithGivenTensorProduct( ComonMonB,
              function( ComonMonB, source, comonoid_on_monoid, target )
                local MonB, B, source_monoid, target_monoid, source_object, target_object, monoid, object,
                      coevaluation, monoid_coevaluation;
                
                MonB := UnderlyingCategory( ComonMonB );
                
                B := UnderlyingCategory( MonB );
                
                source_monoid := ObjectDatum( ComonMonB, source )[1];
                target_monoid := ObjectDatum( ComonMonB, target )[1];
                
                source_object := ObjectDatum( MonB, source_monoid )[1];
                target_object := ObjectDatum( MonB, target_monoid )[1];
                
                monoid := ObjectDatum( ComonMonB, comonoid_on_monoid )[1];
                
                object := ObjectDatum( MonB, monoid )[1];
                
                coevaluation := CoevaluationForDualWithGivenTensorProduct( B,
                                        source_object,
                                        object,
                                        target_object );
                
                monoid_coevaluation := MorphismConstructor( MonB,
                                               source_monoid,
                                               coevaluation,
                                               target_monoid );
                
                return MorphismConstructor( ComonMonB,
                               source,
                               monoid_coevaluation,
                               target );
                
            end );
            
        fi;
        
    fi;
    
    Finalize( ComonMonB : FinalizeCategory := true );
    
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
      function( BimonB, comonoid_on_monoid )
        local ComonMonB, MonB, triple_of_monoid_counit_comultiplication, triple_of_object_unit_multiplication, object, unit, mult, counit, comult;
        
        ComonMonB := ModelingCategory( BimonB );
        
        MonB := UnderlyingCategory( ComonMonB );
        
        triple_of_monoid_counit_comultiplication := ObjectDatum( ComonMonB, comonoid_on_monoid );
        
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
    
    if ValueOption( "no_precompiled_code" ) <> true then
        ADD_FUNCTIONS_FOR_CategoryOfBimonoidsAsComonoidsOfMonoidsPrecompiled( BimonB );
    fi;
    
    Finalize( BimonB );
    
    return BimonB;
    
end );

##
InstallMethod( CategoryOfBimonoidsAsComonoidsOfMonoids,
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    
    return CATEGORY_OF_BIMONOIDS_AS_COMONOIDS_OF_MONOIDS( B );
    
end );

##
InstallMethod( CATEGORY_OF_BIMONOIDS_AS_MONOIDS_OF_COMONOIDS,
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
    
    ComonB := CATEGORY_OF_COMONOIDS( B : FinalizeCategory := true );
    MonComonB := CATEGORY_OF_MONOIDS( ComonB : FinalizeCategory := false );
    
    if HasIsRigidSymmetricClosedMonoidalCategory( B ) and IsRigidSymmetricClosedMonoidalCategory( B ) then
        
        SetIsRigidSymmetricClosedMonoidalCategory( MonComonB, true );
        
        if CanCompute( B, "DualOnMorphisms" ) then
            
            ##
            AddDualOnObjects( MonComonB,
              function( MonComonB, monoid_on_comonoid )
                local ComonB, B, triple_of_comonoid_unit_multiplication, triple_of_object_counit_comultiplication, dual_object, counit, comult, comonoid, unit, mult;
                
               ComonB := UnderlyingCategory( MonComonB );
                
                B := UnderlyingCategory( ComonB );
                
                triple_of_comonoid_unit_multiplication := ObjectDatum( MonComonB, monoid_on_comonoid );
                
                triple_of_object_counit_comultiplication := ObjectDatum( ComonB, triple_of_comonoid_unit_multiplication[1] );
                
                dual_object := DualOnObjects( B, triple_of_object_counit_comultiplication[1] );
                
                counit := DualOnMorphismsWithGivenDuals( B,
                                  dual_object,
                                  MorphismDatum( ComonB, triple_of_comonoid_unit_multiplication[2] ),
                                  TensorUnit( B ) );
                
                comult := DualOnMorphismsWithGivenDuals( B,
                                  dual_object,
                                  MorphismDatum( ComonB, triple_of_comonoid_unit_multiplication[3] ),
                                  TensorProductOnObjects( B,
                                          dual_object,
                                          dual_object ) );
                
                comonoid := ObjectConstructor( ComonB,
                                    Triple( dual_object,
                                            counit,
                                            comult ) );
                
                unit := MorphismConstructor( ComonB,
                                TensorUnit( ComonB ),
                                DualOnMorphismsWithGivenDuals( B,
                                        Target( counit ),
                                        triple_of_object_counit_comultiplication[2],
                                        Source( counit ) ),
                                comonoid );
                
                mult := MorphismConstructor( ComonB,
                                comonoid,
                                DualOnMorphismsWithGivenDuals( B,
                                        Target( comult ),
                                        triple_of_object_counit_comultiplication[3],
                                        Source( comult ) ),
                                TensorProductOnObjects( ComonB,
                                        comonoid,
                                        comonoid ) );
                
                return ObjectConstructor( MonComonB,
                               Triple( comonoid,
                                       unit,
                                       mult ) );
                
            end );
            
        fi;
        
    fi;
    
    Finalize( MonComonB : FinalizeCategory := true );
    
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
      function( BimonB, monoid_on_comonoid )
        local MonComonB, ComonB, triple_of_comonoid_unit_multiplication, triple_of_object_counit_comultiplication, object, counit, comult, unit, mult;
        
        MonComonB := ModelingCategory( BimonB );
        
        ComonB := UnderlyingCategory( MonComonB );
        
        triple_of_comonoid_unit_multiplication := ObjectDatum( MonComonB, monoid_on_comonoid );
        
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
              rec( name := Concatenation( "CategoryOfBimonoidsAsMonoidsOfComonoids( ", Name( B ), " )" ),
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
InstallMethod( CategoryOfBimonoidsAsMonoidsOfComonoids,
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    
    return CATEGORY_OF_BIMONOIDS_AS_MONOIDS_OF_COMONOIDS( B );
    
end );

##
InstallMethod( CategoryOfBimonoids,
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    
    if ValueOption( "reverse" ) = true then
        return CategoryOfBimonoidsAsMonoidsOfComonoids( B );
    else
        return CategoryOfBimonoidsAsComonoidsOfMonoids( B );
    fi;
    
end );

##
InstallMethod( UnderlyingObject,
        "for an internal bimonoid",
        [ IsInternalBimonoid ],

  function( bimonoid )
    
    return ObjectDatum( bimonoid )[1];
    
end );

##
InstallMethod( \.,
        "for an internal bimonoid",
        [ IsInternalBimonoid, IsPosInt ],
        
  function ( bimonoid, string_as_int )
    local name, datum;
    
    name := NameRNam( string_as_int );
    
    datum := ObjectDatum( bimonoid );
    
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
    else
        Error( "the bimonoid only has the componenets `object`, `unit`, `mult` (or `multiplication`), `counit`, `comult` (or `comultiplication`)" );
    fi;
    
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
InstallMethod( UnderlyingMonoid,
        [ IsInternalBimonoid ],
        
  function( bimonoid )
    
    return UnderlyingMonoid( CapCategory( bimonoid ), bimonoid );
    
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
InstallMethod( UnderlyingMonoidMorphism,
        [ IsInternalBimonoidMorphism ],
        
  function( bimonoid_morphism )
    
    return UnderlyingMonoidMorphism( CapCategory( bimonoid_morphism ), bimonoid_morphism );
    
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
InstallMethod( UnderlyingComonoid,
        [ IsInternalBimonoid ],
        
  function( bimonoid )
    
    return UnderlyingComonoid( CapCategory( bimonoid ), bimonoid );
    
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
InstallMethod( UnderlyingComonoidMorphism,
        [ IsInternalBimonoidMorphism ],
        
  function( bimonoid_morphism )
    
    return UnderlyingComonoidMorphism( CapCategory( bimonoid_morphism ), bimonoid_morphism );
    
end );

##
InstallMethod( IsCommutative,
        "for an internal bimonoid",
        [ IsInternalBimonoid ],
        
  function( bimonoid )
    
    return IsCommutative( UnderlyingMonoid( bimonoid ) );
    
end );

##
InstallMethod( IsCocommutative,
        "for an internal bimonoid",
        [ IsInternalBimonoid ],
        
  function( bimonoid )
    
    return IsCocommutative( UnderlyingComonoid( bimonoid ) );
    
end );

##
InstallMethod( OppositeBimonoid,
        "for an internal bimonoid",
        [ IsInternalBimonoid ],
        
  function( bimonoid )
    local BimonB, B, quintuple, object;
    
    BimonB := CapCategory( bimonoid );
    
    B := UnderlyingCategory( BimonB );
    
    quintuple := ObjectDatum( BimonB, bimonoid );
    
    object := quintuple[1];
    
    return ObjectConstructor( BimonB,
                   NTuple( 5,
                           quintuple[1],
                           quintuple[2],
                           PreCompose( B,
                                   Braiding( B,
                                           object,
                                           object ),
                                   quintuple[3] ),
                           quintuple[4],
                           quintuple[5] ) );
    
end );

##
InstallMethod( CoOppositeBimonoid,
        "for an internal bimonoid",
        [ IsInternalBimonoid ],
        
  function( bimonoid )
    local BimonB, B, quintuple, object;
    
    BimonB := CapCategory( bimonoid );
    
    B := UnderlyingCategory( BimonB );
    
    quintuple := ObjectDatum( BimonB, bimonoid );
    
    object := quintuple[1];
    
    return ObjectConstructor( BimonB,
                   NTuple( 5,
                           quintuple[1],
                           quintuple[2],
                           quintuple[3],
                           quintuple[4],
                           PreCompose( B,
                                   quintuple[5],
                                   Braiding( B,
                                           object,
                                           object ) ) ) );
    
end );

##
InstallMethod( OppositeCoOppositeBimonoid,
        "for an internal bimonoid",
        [ IsInternalBimonoid ],
        
  function( bimonoid )
    
    return CoOppositeBimonoid( OppositeBimonoid( bimonoid ) );
    
end );

##
InstallMethod( OppositeBimonoid,
        "for an internal bimonoid",
        [ IsInternalBimonoid ],
        
  function( bimonoid )
    local BimonB, B, quintuple, dual;
    
    BimonB := CapCategory( bimonoid );
    
    B := UnderlyingCategory( BimonB );
    
    quintuple := ObjectDatum( BimonB, bimonoid );
    
    return ObjectConstructor( BimonB,
                   NTuple( 5,
                           quintuple[1],
                           quintuple[2],
                           quintuple[3],
                           quintuple[4],
                           quintuple[5] ) );
    
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
    
    bimonoid := ObjectConstructor( CategoryOfBimonoidsAsComonoidsOfMonoids( B ),
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
        "for a morphism and an internal bimonoid",
        [ IsCapCategoryMorphism, IsInternalBimonoid ],
        
  function( iso, bimonoid )
    local BimonB, B, quintuple, object, unit, mult, counit, comult, inv;
    
    BimonB := CapCategory( bimonoid );
    
    B := UnderlyingCategory( BimonB );
    
    quintuple := ObjectDatum( BimonB, bimonoid );
    
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
    
    return ObjectConstructor( BimonB,
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

##
InstallMethod( Bimonoid,
        "for an internal monoid",
        [ IsInternalMonoid and HasUnderlyingAlgebra, IsList, IsList ],
        
  function( monoid, counit_list, comult_list )
    local MonB, B, k, A, o, basis, decompose, basis_decomp, object, unit, mult, id, monoid2, unit2, mult2, counit, comult, bimonoid;
    
    MonB := CapCategory( monoid );
    
    B := UnderlyingCategory( MonB );
    
    k := CommutativeRingOfLinearCategory( B );
    
    A := UnderlyingAlgebra( monoid );
    
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
    
    object := monoid.object;
    unit := monoid.unit;
    mult := monoid.mult;
    
    id := IdentityMorphism( TensorUnit( B ) );
    
    monoid2 := TensorProduct( monoid, monoid );
    
    unit2 := monoid2.unit;
    mult2 := monoid2.mult;
    
    counit := List( counit_list, r -> ( r / k ) * id );
    counit := List( basis_decomp, indices -> List( indices, i -> counit[i] ) );
    counit := List( counit, images -> Iterated( images, { a, b } -> TensorProduct( a, b ), id ) );
    counit := UniversalMorphismFromDirectSum( counit );
    
    comult := List( comult_list, gen -> Sum( gen, summand -> ( summand[1] / k ) * ( k * MorphismDatum( TensorProduct( HomStructure( summand[2][1] ), HomStructure( summand[2][2] ) ) ) / B ) ) );
    comult := List( basis_decomp, indices -> List( indices, i -> comult[i] ) );
    comult := List( comult, images -> Iterated( images, { a, b } -> PreCompose( TensorProduct( a, b ), mult2 ), unit2 ) );
    comult := UniversalMorphismFromDirectSum( comult );
    
    bimonoid := ObjectConstructor( CategoryOfBimonoids( B ),
                        NTuple( 5,
                                object,
                                unit,
                                mult,
                                counit,
                                comult ) );
    
    SetUnderlyingAlgebra( bimonoid, A );
    
    return bimonoid;
    
end );

##
InstallMethod( Bimonoid,
        "for an internal monoid",
        [ IsInternalMonoid and HasUnderlyingAlgebra, IsRecord, IsRecord ],
        
  function( monoid, counit_record, comult_record )
    local MonB, B, A, gens, g, counit_gen_names, comult_gen_names, counit_unknown, comult_unknown,
          o, basis, dim, counit_vars, comult_vars, k, vars, R, counit_func, comult_func, counit, comult;
    
    MonB := CapCategory( monoid );
    
    B := UnderlyingCategory( MonB );
    
    A := UnderlyingAlgebra( monoid );
    
    gens := SetOfGeneratingMorphisms( A );
    
    g := Length( gens );
    
    counit_gen_names := RecNames( counit_record );
    comult_gen_names := RecNames( comult_record );
    
    Assert( 0, Length( counit_gen_names ) = g );
    Assert( 0, Length( comult_gen_names ) = g );
    
    counit_unknown := Filtered( counit_gen_names, k -> counit_record.(k) = fail );
    comult_unknown := Filtered( comult_gen_names, k -> comult_record.(k) = fail );
    
    if IsEmpty( counit_unknown ) and IsEmpty( comult_unknown ) then
        
        counit_func := k -> [ A.(k), counit_record.(k) ];
        comult_func := k -> [ A.(k), comult_record.(k) ];
        
    else
        
        Assert( 0, HasCommutativeRingOfLinearCategory( B ) );
        
        o := SetOfObjects( A );
        
        Assert( 0, Length( o ) = 1 );
        
        o := o[1];
        
        basis := BasisOfExternalHom( o, o );
        
        dim := Length( basis );
        
        counit_vars := List( [ 1 .. Length( counit_unknown ) ], i -> Concatenation( "e_", counit_unknown[i], "_", String( i ) ) );
        comult_vars := List( [ 1 .. Length( comult_unknown ) ], i -> List( [ 1 .. dim^2 ], j -> Concatenation( "c_", comult_unknown[i], "_", String( j ) ) ) );
        
        k := CommutativeRingOfLinearCategory( B );
        
        vars := Concatenation( counit_vars, Concatenation( comult_vars ) );
        
        if IsEmpty( vars ) then
            R := k;
        else
            R := k * vars;
            if Length( vars ) > 3 then
                SetName( R, Concatenation( RingName( k ), "[", vars[1], ",...,", vars[Length( vars )], "]" ) );
            fi;
        fi;
        
        counit_func :=
          function( k )
            local pos;
            
            pos := Position( counit_unknown, k );
            
            if IsInt( pos ) then
                return [ A.(k), counit_vars[pos] / R ];
            else
                return [ A.(k), counit_record.(k) / R ];
            fi;
            
        end;
        
        B := CategoryOfRows( R );
        
        comult_func :=
          function( k )
            local pos, coeffs;
            
            pos := Position( comult_unknown, k );
            
            if IsInt( pos ) then
                coeffs := comult_vars[pos];
                return [ A.(k), Concatenation( List( [ 1 .. dim ], i -> List( [ 1 .. dim ], j -> [ coeffs[j + (i-1) * dim] / R, [ basis[i], basis[j] ] ] ) ) ) ];
            else
                return [ A.(k), comult_record.(k) ];
            fi;
            
        end;
        
        monoid := ObjectConstructor( CategoryOfMonoids( B ),
                          Triple( ObjectDatum( monoid.object ) / B,
                                  R * MorphismDatum( monoid.unit ) / B,
                                  R * MorphismDatum( monoid.mult ) / B ) );
        
        SetUnderlyingAlgebra( monoid, A );
        
    fi;
    
    counit := List( counit_gen_names, counit_func );
    counit := List( gens, gen -> counit[PositionProperty( counit, a -> a[1] = gen )][2] );
    
    comult := List( comult_gen_names, comult_func );
    comult := List( gens, gen -> comult[PositionProperty( comult, a -> a[1] = gen )][2] );
    
    return Bimonoid( monoid, counit, comult );
    
end );

##
InstallMethod( AffineVarietyOfBimonoids,
        "for an internal monoid",
        [ IsInternalMonoid ],
        
  function( monoid )
    local B, k, triple, object, unit, mult, dim, counit, comult, R, rows, bimonoid,
          obstruction, extract_matrix, relations, bimonoid_variety;
    
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
    
    R := k * Concatenation( counit, comult );
    SetName( R, Concatenation( RingName( k ), "[e1..", String( dim ), ",d1..", String( dim^3 ), "]" ) );
    
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
    
    bimonoid := ObjectConstructor( CategoryOfBimonoids( rows ),
                        NTuple( 5,
                                object,
                                unit,
                                mult,
                                counit,
                                comult ) );
    
    obstruction := [ ];
    
    IsWellDefined( bimonoid : obstruction := obstruction );
    
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
    
    bimonoid_variety := ClosedSubsetOfSpec( relations );
    SetParametrizedObject( bimonoid_variety, bimonoid );
    
    return bimonoid_variety;
    
end );

##
InstallMethod( AffineVarietyOfBimonoids,
        "for an internal comonoid",
        [ IsInternalComonoid ],
        
  function( comonoid )
    local B, k, triple, object, counit, comult, dim, unit, mult, R, rows, bimonoid,
          obstruction, extract_matrix, relations, bimonoid_variety;
    
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
    
    R := k * Concatenation( unit, mult );
    SetName( R, Concatenation( RingName( k ), "[u1..", String( dim ), ",m1..", String( dim^3 ), "]" ) );
    
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
    
    bimonoid := ObjectConstructor( CategoryOfBimonoids( rows : reverse := true ),
                           NTuple( 6,
                                   object,
                                   unit,
                                   mult,
                                   counit,
                                   comult ) );
    
    obstruction := [ ];
    
    IsWellDefined( bimonoid : obstruction := obstruction );
    
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
    
    bimonoid_variety := ClosedSubsetOfSpec( relations );
    SetParametrizedObject( bimonoid_variety, bimonoid );
    
    return bimonoid_variety;
    
end );

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
InstallMethod( DisplayString,
        "for an internal bimonoid",
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
        "for a morphism of internal bimonoids",
        [ IsInternalBimonoidMorphism ],
        
  function( bimonoid_morphism )
    
    return Concatenation(
                   StringDisplay( MorphismDatum( bimonoid_morphism ) ),
                   "\nA bimonoid morphism given by the above data" );
    
end );
