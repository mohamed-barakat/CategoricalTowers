# Spdx-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Implementations
#

##
InstallMethod( CategoryOfDimonoids,
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    local name, object_datum_type, morphism_datum_type, DimonB, sym;
    
    ##
    name := Concatenation( "CategoryOfDimonoids( ", Name( B ), " )" );
    
    ##
    object_datum_type :=
      CapJitDataTypeOfNTupleOf( 5,
              CapJitDataTypeOfObjectOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ) );
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfMorphismOfCategory( B );
    
    ##
    DimonB :=
      CreateCapCategoryWithDataTypes( name,
              IsCategoryOfInternalDimonoids,
              IsInternalDimonoid,
              IsInternalDimonoidMorphism,
              IsCapCategoryTwoCell,
              object_datum_type,
              morphism_datum_type,
              fail );
    
    if IsBound( B!.supports_empty_limits ) and B!.supports_empty_limits = true then
        DimonB!.supports_empty_limits := true;
    fi;
    
    SetUnderlyingCategory( DimonB, B );
    
    SetAssociatedCategoryOfMonoids( DimonB, CategoryOfMonoids( B ) );
    SetAssociatedCategoryOfComonoids( DimonB, CategoryOfComonoids( B ) );
    
    DimonB!.compiler_hints :=
      rec( category_attribute_names :=
           [ "UnderlyingCategory",
             "AssociatedCategoryOfMonoids",
             "AssociatedCategoryOfComonoids",
             ] );
    
    sym := HasIsSymmetricMonoidalCategory( B ) and IsSymmetricMonoidalCategory( B );
    
    if sym then
        SetIsSymmetricMonoidalCategory( DimonB, true );
    fi;
    
    ##
    AddObjectConstructor( DimonB,
      function( DimonB, quintuple_of_object_unit_multiplication_counit_comultiplication )
        local B;
        
        B := UnderlyingCategory( DimonB );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                Length( quintuple_of_object_unit_multiplication_counit_comultiplication ) = 5 and
                IsCapCategoryObject( quintuple_of_object_unit_multiplication_counit_comultiplication[1] ) and
                ForAll( quintuple_of_object_unit_multiplication_counit_comultiplication{[ 2 .. 5 ]}, IsCapCategoryMorphism ) and
                ForAll( quintuple_of_object_unit_multiplication_counit_comultiplication, cell -> IsIdenticalObj( B, CapCategory( cell ) ) ) );
        
        return CreateCapCategoryObjectWithAttributes( DimonB,
                       DefiningQuintupleOfInternalDimonoid, quintuple_of_object_unit_multiplication_counit_comultiplication );
        
    end );
    
    ##
    AddObjectDatum( DimonB,
      function( DimonB, object )
        
        return DefiningQuintupleOfInternalDimonoid( object );
        
    end );
    
    ##
    AddMorphismConstructor( DimonB,
      function( DimonB, source, morphism, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsCapCategoryMorphism( morphism ) and
                IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( DimonB ) ) );
        
        return CreateCapCategoryMorphismWithAttributes( DimonB,
                       source,
                       target,
                       UnderlyingMorphism, morphism );
        
    end );
    
    ##
    AddMorphismDatum( DimonB,
      function( DimonB, morphism )
        
        return UnderlyingMorphism( morphism );
        
    end );
    
    ##
    AddIsEqualForObjects( DimonB,
      function( DimonB, object1, object2 )
        local B, quintuple1, quintuple2;
        
        B := UnderlyingCategory( DimonB );
        
        quintuple1 := ObjectDatum( DimonB, object1 );
        quintuple2 := ObjectDatum( DimonB, object2 );
        
        return IsEqualForObjects( B, quintuple1[1], quintuple2[1] ) and
               IsCongruentForMorphisms( B, quintuple1[2], quintuple2[2] ) and
               IsCongruentForMorphisms( B, quintuple1[3], quintuple2[3] ) and
               IsCongruentForMorphisms( B, quintuple1[4], quintuple2[4] ) and
               IsCongruentForMorphisms( B, quintuple1[5], quintuple2[5] );
        
    end );
    
    ##
    AddIsEqualForMorphisms( DimonB,
      function( DimonB, morphism1, morphism2 )
        
        return IsEqualForMorphisms( UnderlyingCategory( DimonB ),
                       MorphismDatum( DimonB, morphism1 ),
                       MorphismDatum( DimonB, morphism2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( DimonB,
      function( DimonB, morphism1, morphism2 )
        
        return IsCongruentForMorphisms( UnderlyingCategory( DimonB ),
                       MorphismDatum( DimonB, morphism1 ),
                       MorphismDatum( DimonB, morphism2 ) );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( DimonB,
      function( DimonB, dimonoid )
        local B, quintuple;
        
        B := UnderlyingCategory( HmonB );
        
        quintuple := ObjectDatum( HmonB, hopf_monoid );
        
        if not IsList( quintuple ) then
            return false;
        elif not Length( quintuple ) = 5 then
            return false;
        elif not IsCapCategoryObject( quintuple[1] ) then
            return false;
        elif not ForAll( quintuple{[ 2 .. 5 ]}, IsCapCategoryMorphism ) then
            return false;
        elif not ForAll( quintuple, cell -> IsIdenticalObj( B, CapCategory( cell ) ) ) then
            return false;
        fi;
        
        return IsWellDefinedForObjects( AssociatedCategoryOfMonoids( DimonB ),
                       UnderlyingMonoid( DimonB, dimonoid ) ) and
               IsWellDefinedForObjects( ComonB,
                       UnderlyingComonoid( DimonB, dimonoid ) );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( DimonB,
      function( DimonB, dimonoid_morphism )
        local B, morphism;
        
        B := UnderlyingCategory( DimonB );
        
        morphism := MorphismDatum( DimonB, dimonoid_morphism );
        
        if not IsCapCategoryMorphism( morphism ) then
            return false;
        elif not IsIdenticalObj( B, CapCategory( morphism ) ) then
            return false;
        elif not IsWellDefinedForMorphisms( B, morphism ) then
            return false;
        fi;
        
        return IsWellDefinedForMorphisms( AssociatedCategoryOfMonoids( DimonB ),
                       UnderlyingMonoidMorphism( DimonB, dimonoid_morphism ) ) and
               IsWellDefinedForMorphisms( AssociatedCategoryOfComonoids( DimonB ),
                       UnderlyingComonoidMorphism( DimonB, dimonoid_morphism ) );
        
    end );
    
    ##
    AddIdentityMorphism( DimonB,
      function( DimonB, object )
        local B;
        
        B := UnderlyingCategory( DimonB );
        
        return MorphismConstructor( DimonB,
                       object,
                       IdentityMorphism( B,
                               ObjectDatum( DimonB, object )[1] ),
                       object );
        
    end );
    
    ##
    AddPreCompose( DimonB,
      function( DimonB, pre_morphism, post_morphism )
        local B;
        
        B := UnderlyingCategory( DimonB );
        
        return MorphismConstructor( DimonB,
                       Source( pre_morphism ),
                       PreCompose( B,
                               MorphismDatum( DimonB, pre_morphism ),
                               MorphismDatum( DimonB, post_morphism ) ),
                       Target( post_morphism ) );
        
    end );
    
    ##
    AddIsIsomorphism( DimonB,
      function( DimonB, dimonoid_morphism )
        local B;
        
        B := UnderlyingCategory( DimonB );
        
        return IsIsomorphism( B,
                       MorphismDatum( DimonB,
                               dimonoid_morphism ) );
        
    end );
    
    ##
    AddInverseForMorphisms( DimonB,
      function( DimonB, dimonoid_morphism )
        local B;
        
        B := UnderlyingCategory( DimonB );
        
        return MorphismConstructor( DimonB,
                       Target( dimonoid_morphism ),
                       InverseForMorphisms( B,
                               MorphismDatum( DimonB,
                                       dimonoid_morphism ) ),
                       Source( dimonoid_morphism ) );
        
    end );
    
    if sym then
        
        ##
        AddTensorUnit( DimonB,
          function( DimonB )
            local B, U, MonB, ComonB, triple_of_monoid, triple_of_comonoid;
            
            B := UnderlyingCategory( DimonB );
            
            U := TensorUnit( B );
            
            MonB := AssociatedCategoryOfMonoids( DimonB );
            ComonB := AssociatedCategoryOfComonoids( DimonB );
            
            triple_of_monoid := ObjectDatum( MonB,
                                        TensorUnit( MonB ) );
            
            triple_of_comonoid := ObjectDatum( ComonB,
                                          TensorUnit( ComonB ) );
            
            return ObjectConstructor( DimonB,
                           NTuple( 5, U,
                                   triple_of_monoid[2],
                                   triple_of_monoid[3],
                                   triple_of_comonoid[2],
                                   triple_of_comonoid[3] ) );
            
        end );
        
        ##
        AddTensorProductOnObjects( DimonB,
          function( DimonB, dimonoid1, dimonoid2 )
            local B, object, MonB, ComonB, triple_of_monoid, triple_of_comonoid;
            
            B := UnderlyingCategory( DimonB );
            
            object := TensorProductOnObjects( B,
                              ObjectDatum( DimonB, dimonoid1 )[1],
                              ObjectDatum( DimonB, dimonoid2 )[1] );
            
            MonB := AssociatedCategoryOfMonoids( DimonB );
            ComonB := AssociatedCategoryOfComonoids( DimonB );
            
            triple_of_monoid := ObjectDatum( MonB,
                                        TensorProductOnObjects( MonB,
                                                UnderlyingMonoid( DimonB,
                                                        dimonoid1 ),
                                                UnderlyingMonoid( DimonB,
                                                        dimonoid2 ) ) );
            
            triple_of_comonoid := ObjectDatum( ComonB,
                                          TensorProductOnObjects( ComonB,
                                                  UnderlyingComonoid( DimonB,
                                                          dimonoid1 ),
                                                  UnderlyingComonoid( DimonB,
                                                          dimonoid2 ) ) );
            
            return ObjectConstructor( DimonB,
                           NTuple( 5,
                                   object,
                                   triple_of_monoid[2],
                                   triple_of_monoid[3],
                                   triple_of_comonoid[2],
                                   triple_of_comonoid[3] ) );
            
        end );
        
        ##
        AddTensorProductOnMorphismsWithGivenTensorProducts( DimonB,
          function( DimonB, source, dimonoid_morphism1, dimonoid_morphism2, target )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           source,
                           TensorProductOnMorphisms( B,
                                   MorphismDatum( DimonB, dimonoid_morphism1 ),
                                   MorphismDatum( DimonB, dimonoid_morphism2 ) ),
                           target );
            
        end );
        
        ##
        AddLeftUnitorWithGivenTensorProduct( DimonB,
          function( DimonB, object, source )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           source,
                           LeftUnitorWithGivenTensorProduct( B,
                                   ObjectDatum( DimonB, object )[1],
                                   ObjectDatum( DimonB, source )[1] ),
                           object );
            
        end );
        
        ##
        AddLeftUnitorInverseWithGivenTensorProduct( DimonB,
          function( DimonB, object, target )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           object,
                           LeftUnitorInverseWithGivenTensorProduct( B,
                                   ObjectDatum( DimonB, object )[1],
                                   ObjectDatum( DimonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddRightUnitorWithGivenTensorProduct( DimonB,
          function( DimonB, object, source )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           source,
                           RightUnitorWithGivenTensorProduct( B,
                                   ObjectDatum( DimonB, object )[1],
                                   ObjectDatum( DimonB, source )[1] ),
                           object );
            
        end );
        
        ##
        AddRightUnitorInverseWithGivenTensorProduct( DimonB,
          function( DimonB, object, target )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           object,
                           RightUnitorInverseWithGivenTensorProduct( B,
                                   ObjectDatum( DimonB, object )[1],
                                   ObjectDatum( DimonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddAssociatorLeftToRightWithGivenTensorProducts( DimonB,
          function( DimonB, source, object1, object2, object3, target )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           source,
                           AssociatorLeftToRightWithGivenTensorProducts( B,
                                   ObjectDatum( DimonB, source )[1],
                                   ObjectDatum( DimonB, object1 )[1],
                                   ObjectDatum( DimonB, object2 )[1],
                                   ObjectDatum( DimonB, object3 )[1],
                                   ObjectDatum( DimonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddAssociatorRightToLeftWithGivenTensorProducts( DimonB,
          function( DimonB, source, object1, object2, object3, target )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           source,
                           AssociatorRightToLeftWithGivenTensorProducts( B,
                                   ObjectDatum( DimonB, source )[1],
                                   ObjectDatum( DimonB, object1 )[1],
                                   ObjectDatum( DimonB, object2 )[1],
                                   ObjectDatum( DimonB, object3 )[1],
                                   ObjectDatum( DimonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddBraidingWithGivenTensorProducts( DimonB,
          function( DimonB, source, object1, object2, target )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           source,
                           BraidingWithGivenTensorProducts( B,
                                   ObjectDatum( DimonB, source )[1],
                                   ObjectDatum( DimonB, object1 )[1],
                                   ObjectDatum( DimonB, object2 )[1],
                                   ObjectDatum( DimonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddBraidingInverseWithGivenTensorProducts( DimonB,
          function( DimonB, source, object1, object2, target )
            local B;
            
            B := UnderlyingCategory( DimonB );
            
            return MorphismConstructor( DimonB,
                           source,
                           BraidingInverseWithGivenTensorProducts( B,
                                   ObjectDatum( DimonB, source )[1],
                                   ObjectDatum( DimonB, object1 )[1],
                                   ObjectDatum( DimonB, object2 )[1],
                                   ObjectDatum( DimonB, target )[1] ),
                           target );
            
        end );
        
    fi;
    
    Finalize( DimonB );
    
    return DimonB;
    
end );

##
InstallMethod( UnderlyingObject,
        [ IsInternalDimonoid ],
        
  function( dimonoid )
    
    return ObjectDatum( dimonoid )[1];
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingMonoid,
        [ IsCategoryOfInternalDimonoids, IsInternalDimonoid ],
        
  function( DimonB, dimonoid )
    local quintuple;
    
    quintuple := ObjectDatum( DimonB, dimonoid );
    
    return ObjectConstructor( AssociatedCategoryOfMonoids( DimonB ),
                   Triple( quintuple[1],
                           quintuple[2],
                           quintuple[3] ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingComonoid,
        [ IsCategoryOfInternalDimonoids, IsInternalDimonoid ],
        
  function( DimonB, dimonoid )
    local quintuple;
    
    quintuple := ObjectDatum( DimonB, dimonoid );
    
    return ObjectConstructor( AssociatedCategoryOfComonoids( DimonB ),
                   Triple( quintuple[1],
                           quintuple[4],
                           quintuple[5] ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingMonoidMorphism,
        [ IsCategoryOfInternalDimonoids, IsInternalDimonoidMorphism ],
        
  function( DimonB, dimonoid_morphism )
    
    return MorphismConstructor( AssociatedCategoryOfMonoids( DimonB ),
                   UnderlyingMonoid( DimonB, Source( dimonoid_morphism ) ),
                   MorphismDatum( DimonB, dimonoid_morphism ),
                   UnderlyingMonoid( DimonB, Target( dimonoid_morphism ) ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( UnderlyingComonoidMorphism,
        [ IsCategoryOfInternalDimonoids, IsInternalDimonoidMorphism ],
        
  function( DimonB, dimonoid_morphism )
    
    return MorphismConstructor( AssociatedCategoryOfComonoids( DimonB ),
                   UnderlyingComonoid( DimonB, Source( dimonoid_morphism ) ),
                   MorphismDatum( DimonB, dimonoid_morphism ),
                   UnderlyingComonoid( DimonB, Target( dimonoid_morphism ) ) );
    
end );

##
InstallMethod( DualDimonoid,
        [ IsInternalDimonoid ],

  function( dimonoid )
    local DimonB, B, quintuple, dual;
    
    DimonB := CapCategory( dimonoid );
    
    B := UnderlyingCategory( DimonB );
    
    if not CanCompute( B, "DualOnMorphisms" ) then
        TryNextMethod( );
    fi;
    
    quintuple := ObjectDatum( DimonB, dimonoid );
    
    dual := DualOnObjects( B, quintuple[1] );
    
    return ObjectConstructor( DimonB,
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

  function( B, set_monoid )
    local dim, U, object, object2, elements, k, id, o, unit, mult, counit, comult;
    
    dim := Size( set_monoid );
    
    U := TensorUnit( B );
    
    object := ObjectConstructor( B, dim );
    
    object2 := TensorProductOnObjects( B, object, object );
    
    elements := List( set_monoid );
    
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
    
    return ObjectConstructor( CategoryOfDimonoids( B ),
                   NTuple( 5,
                           object,
                           unit,
                           mult,
                           counit,
                           comult ) );
    
end );

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
InstallMethod( DisplayString,
        [ IsInternalDimonoid ],

  function( dimonoid )
    local quintuple;

    quintuple := ObjectDatum( dimonoid );
    
    return Concatenation(
                   "Multiplication of dimonoid:\n\n",
                   StringDisplay( quintuple[3] ),
                   "\nComultiplication of dimonoid:\n\n",
                   StringDisplay( quintuple[5] ),
                   "\nUnit of dimonoid:\n\n",
                   StringDisplay( quintuple[2] ),
                   "\nCounit of dimonoid:\n\n",
                   StringDisplay( quintuple[4] ),
                   "\nObject of dimonoid:\n\n",
                   StringDisplay( quintuple[1] ),
                   "\nA dimonoid given by the above data" );
    
end );

##
InstallMethod( DisplayString,
        [ IsInternalDimonoidMorphism ],

  function( dimonoid_morphism )
    
    return Concatenation(
                   StringDisplay( MorphismDatum( dimonoid_morphism ) ),
                   "\nA dimonoid morphism given by the above data" );
    
end );
