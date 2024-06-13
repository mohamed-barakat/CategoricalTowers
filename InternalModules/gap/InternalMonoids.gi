# Spdx-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Implementations
#

##
InstallMethod( CATEGORY_OF_MONOIDS,
        "for a monoidal category",
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    local name, object_datum_type, morphism_datum_type, MonB, add, sym;
    
    ##
    name := Concatenation( "CategoryOfMonoids( ", Name( B ), " )" );
    
    ##
    object_datum_type :=
      CapJitDataTypeOfNTupleOf( 3,
              CapJitDataTypeOfObjectOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ),
              CapJitDataTypeOfMorphismOfCategory( B ) );
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfMorphismOfCategory( B );
    
    ##
    MonB :=
      CreateCapCategoryWithDataTypes( name,
              IsCategoryOfInternalMonoids,
              IsInternalMonoid,
              IsInternalMonoidMorphism,
              IsCapCategoryTwoCell,
              object_datum_type,
              morphism_datum_type,
              fail );
    
    if IsBound( B!.supports_empty_limits ) and B!.supports_empty_limits = true then
        MonB!.supports_empty_limits := true;
    fi;
    
    SetUnderlyingCategory( MonB, B );
    
    MonB!.compiler_hints :=
      rec( category_attribute_names :=
           [ "UnderlyingCategory",
             ] );
    
    add := HasIsAdditiveCategory( B ) and IsAdditiveCategory( B );
    
    if add then
        SetIsCartesianCategory( MonB, true );
    fi;
    
    sym := HasIsSymmetricMonoidalCategory( B ) and IsSymmetricMonoidalCategory( B );
    
    if sym then
        SetIsCategoryWithInitialObject( MonB, true );
        SetIsSymmetricMonoidalCategory( MonB, true );
    fi;
    
    ##
    AddObjectConstructor( MonB,
      function( MonB, triple_of_object_unit_multiplication )
        local B;
        
        B := UnderlyingCategory( MonB );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsList( triple_of_object_unit_multiplication ) and
                Length( triple_of_object_unit_multiplication ) = 3 and
                IsCapCategoryObject( triple_of_object_unit_multiplication[1] ) and
                ForAll( triple_of_object_unit_multiplication{[ 2 .. 3 ]}, IsCapCategoryMorphism ) and
                ForAll( triple_of_object_unit_multiplication, cell -> IsIdenticalObj( B, CapCategory( cell ) ) ) );
        
        return CreateCapCategoryObjectWithAttributes( MonB,
                       DefiningTripleOfInternalMonoid, triple_of_object_unit_multiplication );
        
    end );
    
    ##
    AddObjectDatum( MonB,
      function( MonB, monoid )
        
        return DefiningTripleOfInternalMonoid( monoid );
        
    end );
    
    ##
    AddMorphismConstructor( MonB,
      function( MonB, source, morphism, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsCapCategoryMorphism( morphism ) and
                IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( MonB ) ) );
        
        return CreateCapCategoryMorphismWithAttributes( MonB,
                       source,
                       target,
                       UnderlyingMorphism, morphism );
        
    end );
    
    ##
    AddMorphismDatum( MonB,
      function( MonB, monoid_morphism )
        
        return UnderlyingMorphism( monoid_morphism );
        
    end );
    
    ##
    AddIsEqualForObjects( MonB,
      function( MonB, object1, object2 )
        local B, triple1, triple2;
        
        B := UnderlyingCategory( MonB );
        
        triple1 := ObjectDatum( MonB, object1 );
        triple2 := ObjectDatum( MonB, object2 );
        
        return IsEqualForObjects( B, triple1[1], triple2[1] ) and
               IsCongruentForMorphisms( B, triple1[2], triple2[2] ) and
               IsCongruentForMorphisms( B, triple1[3], triple2[3] );
        
    end );
    
    ##
    AddIsEqualForMorphisms( MonB,
      function( MonB, morphism1, morphism2 )
        
        return IsEqualForMorphisms( UnderlyingCategory( MonB ),
                       MorphismDatum( MonB, morphism1 ),
                       MorphismDatum( MonB, morphism2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( MonB,
      function( MonB, morphism1, morphism2 )
        
        return IsCongruentForMorphisms( UnderlyingCategory( MonB ),
                       MorphismDatum( MonB, morphism1 ),
                       MorphismDatum( MonB, morphism2 ) );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( MonB,
      function( MonB, monoid )
        local B, triple, object, unit, mult, id_object, extract_datum, obstruction,
              lhs_left_unit, rhs_left_unit, lhs_right_unit, rhs_right_unit,
              lhs_associativity, rhs_associativity;
        
        B := UnderlyingCategory( MonB );
        
        triple := ObjectDatum( MonB, monoid );
        
        if not IsList( triple ) then
            return false;
        elif not Length( triple ) = 3 then
            return false;
        elif not IsCapCategoryObject( triple[1] ) then
            return false;
        elif not ForAll( triple{[ 2 .. 3 ]}, IsCapCategoryMorphism ) then
            return false;
        elif not ForAll( triple, cell -> IsIdenticalObj( B, CapCategory( cell ) ) ) then
            return false;
        fi;
        
        object := triple[1];
        unit := triple[2];
        mult := triple[3];
        
        if not IsWellDefinedForObjects( B, object ) then
            return false;
        elif not IsEqualForObjects( B, Source( unit ), TensorUnit( B ) ) then
            return false;
        elif not IsEqualForObjects( B, Target( unit ), object ) then
            return false;
        elif not IsEqualForObjects( B, Target( mult ), object ) then
            return false;
        elif not IsEqualForObjects( B, Source( mult ), TensorProductOnObjects( B, object, object ) ) then
            return false;
        elif not IsWellDefinedForMorphisms( B, unit ) then
            return false;
        elif not IsWellDefinedForMorphisms( B, mult ) then
            return false;
        fi;
        
        extract_datum :=
          function( mor )
            while IsCapCategoryMorphism( mor ) do
                mor := MorphismDatum( mor );
            od;
            return mor;
        end;
        
        obstruction := ValueOption( "obstruction" );
        
        id_object := IdentityMorphism( B, object );
        
        lhs_left_unit := PreCompose( B,
                                 TensorProductOnMorphisms( B,
                                         unit, id_object ),
                                 mult );
        
        rhs_left_unit := LeftUnitor( B, object );
        
        if not IsCongruentForMorphisms( B, lhs_left_unit, rhs_left_unit ) then
            if not obstruction = fail then
                Add( obstruction, Pair( extract_datum( lhs_left_unit ), extract_datum( rhs_left_unit ) ) );
            else
                return false;
            fi;
        fi;
        
        lhs_right_unit := PreCompose( B,
                                  TensorProductOnMorphisms( B,
                                          id_object, unit ),
                                  mult );
        
        rhs_right_unit := RightUnitor( B, object );
        
        if not IsCongruentForMorphisms( B, lhs_right_unit, rhs_right_unit ) then
            if not obstruction = fail then
                Add( obstruction, Pair( extract_datum( lhs_right_unit ), extract_datum( rhs_right_unit ) ) );
            else
                return false;
            fi;
        fi;
        
        lhs_associativity := PreComposeList( B,
                                     [ AssociatorLeftToRight( B, object, object, object ),
                                       TensorProductOnMorphisms( B, id_object, mult ),
                                       mult ] );
        
        rhs_associativity := PreCompose( B,
                                     TensorProductOnMorphisms( B, mult, id_object ),
                                     mult );
        
        if not IsCongruentForMorphisms( B, lhs_associativity, rhs_associativity ) then
            if not obstruction = fail then
                Add( obstruction, Pair( extract_datum( lhs_associativity ), extract_datum( rhs_associativity ) ) );
            else
                return false;
            fi;
        fi;
        
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( MonB,
      function( MonB, monoid_morphism )
        local B, morphism, triple_source, triple_target,
              object_source, unit_source, mult_source, object_target, unit_target, mult_target,
              extract_datum, obstruction, lhs_preserves_unit, rhs_preserves_unit, lhs_preserves_mult, rhs_preserves_mult;
        
        B := UnderlyingCategory( MonB );
        
        morphism := MorphismDatum( MonB, monoid_morphism );
        
        if not IsCapCategoryMorphism( morphism ) then
            return false;
        elif not IsIdenticalObj( B, CapCategory( morphism ) ) then
            return false;
        elif not IsWellDefinedForMorphisms( B, morphism ) then
            return false;
        fi;
        
        triple_source := ObjectDatum( MonB, Source( monoid_morphism ) );
        triple_target := ObjectDatum( MonB, Target( monoid_morphism ) );
        
        object_source := triple_source[1];
        unit_source := triple_source[2];
        mult_source := triple_source[3];
        
        object_target := triple_target[1];
        unit_target := triple_target[2];
        mult_target := triple_target[3];
        
        if not IsEqualForObjects( B, Source( morphism ), object_source ) then
            return false;
        elif not IsEqualForObjects( B, Target( morphism ), object_target ) then
            return false;
        fi;
        
        extract_datum :=
          function( mor )
            while IsCapCategoryMorphism( mor ) do
                mor := MorphismDatum( mor );
            od;
            return mor;
        end;
        
        obstruction := ValueOption( "obstruction" );
        
        lhs_preserves_unit := PreCompose( B,
                                      unit_source,
                                      morphism );
        
        rhs_preserves_unit := unit_target;
        
        if not IsCongruentForMorphisms( B, lhs_preserves_unit, rhs_preserves_unit ) then
            if not obstruction = fail then
                Add( obstruction, Pair( extract_datum( lhs_preserves_unit ), extract_datum( rhs_preserves_unit ) ) );
            else
                return false;
            fi;
        fi;
        
        lhs_preserves_mult := PreCompose( B,
                                      TensorProductOnMorphisms( B, morphism, morphism ),
                                      mult_target );
        
        rhs_preserves_mult := PreCompose( B,
                                      mult_source,
                                      morphism );
        
        if not IsCongruentForMorphisms( B, lhs_preserves_mult, rhs_preserves_mult ) then
            if not obstruction = fail then
                Add( obstruction, Pair( extract_datum( lhs_preserves_mult ), extract_datum( rhs_preserves_mult ) ) );
            else
                return false;
            fi;
        fi;
        
        return true;
        
    end );
    
    ##
    AddIdentityMorphism( MonB,
      function( MonB, object )
        local B;
        
        B := UnderlyingCategory( MonB );
        
        return MorphismConstructor( MonB,
                       object,
                       IdentityMorphism( B,
                               ObjectDatum( MonB, object )[1] ),
                       object );
        
    end );
    
    ##
    AddPreCompose( MonB,
      function( MonB, pre_morphism, post_morphism )
        local B;
        
        B := UnderlyingCategory( MonB );
        
        return MorphismConstructor( MonB,
                       Source( pre_morphism ),
                       PreCompose( B,
                               MorphismDatum( MonB, pre_morphism ),
                               MorphismDatum( MonB, post_morphism ) ),
                       Target( post_morphism ) );
        
    end );
    
    ##
    AddIsIsomorphism( MonB,
      function( MonB, monoid_morphism )
        local B;
        
        B := UnderlyingCategory( MonB );
        
        return IsIsomorphism( B,
                       MorphismDatum( MonB,
                               monoid_morphism ) );
        
    end );
    
    ##
    AddInverseForMorphisms( MonB,
      function( MonB, monoid_morphism )
        local B;
        
        B := UnderlyingCategory( MonB );
        
        return MorphismConstructor( MonB,
                       Target( monoid_morphism ),
                       InverseForMorphisms( B,
                               MorphismDatum( MonB,
                                       monoid_morphism ) ),
                       Source( monoid_morphism ) );
        
    end );
    
    if add and
       MissingOperationsForConstructivenessOfCategory( B, "IsAdditiveCategory" ) = [ ] and
       CanCompute( B, "LeftDistributivityExpanding" ) and
       CanCompute( B, "RightDistributivityExpanding" ) then
        
        ##
        AddDirectProduct( MonB,
          function( MonB, factors )
            local B, U, l, summands, units, mults, unit, sum, sum2,
                  right_expand, left_summands, left_projections, left_expands, all, projections, mult;
            
            B := UnderlyingCategory( MonB );
            
            U := TensorUnit( B );
            
            l := Length( factors );
            
            summands := List( [ 1 .. l ], i -> ObjectDatum( MonB, factors[i] )[1] );
            units := List( [ 1 .. l ], i -> ObjectDatum( MonB, factors[i] )[2] );
            mults := List( [ 1 .. l ], i -> ObjectDatum( MonB, factors[i] )[3] );
            
            unit := PreCompose( B,
                            CartesianDiagonal( B,
                                    U,
                                    l ),
                            DirectProductFunctorial( B,
                                    units ) );
            
            sum := DirectSum( B,
                           summands );
            
            right_expand := RightDistributivityExpanding( B,
                                    summands,
                                    sum );
            
            left_summands := List( [ 1 .. l ], i ->
                                   TensorProductOnObjects( B,
                                           summands[i],
                                           sum ) );
            
            left_projections := List( [ 1 .. l ], i ->
                                      ProjectionInFactorOfDirectSum( B,
                                              left_summands,
                                              i ) );
            
            left_expands := List( [ 1 .. l ], i ->
                                  LeftDistributivityExpanding( B,
                                          summands[i],
                                          summands ) );
            
            all := List( [ 1 .. l ], i ->
                         List( [ 1 .. l ], j ->
                               TensorProductOnObjects( B,
                                       summands[i],
                                       summands[j] ) ) );
            
            projections := List( [ 1 .. l ], i ->
                                 ProjectionInFactorOfDirectSum( B,
                                         all[i],
                                         i ) );
            
            mult := UniversalMorphismIntoDirectSum( B,
                            TensorProductOnObjects( B,
                                    sum,
                                    sum ),
                            List( [ 1 .. l ], i ->
                                  PreComposeList( B,
                                          [ right_expand,
                                            left_projections[i],
                                            left_expands[i],
                                            projections[i],
                                            mults[i] ] ) ) );
            
            return ObjectConstructor( MonB,
                           Triple( sum,
                                   unit,
                                   mult ) );
            
        end );
        
        ##
        AddProjectionInFactorOfDirectProductWithGivenDirectProduct( MonB,
          function( MonB, factors, k, P )
            local B, l, summands, sum;
            
            B := UnderlyingCategory( MonB );
            
            l := Length( factors );
            
            summands := List( [ 1 .. l ], i -> ObjectDatum( MonB, factors[i] )[1] );
            sum := ObjectDatum( MonB, P )[1];
            
            return MorphismConstructor( MonB,
                           P,
                           ProjectionInFactorOfDirectSumWithGivenDirectSum( B,
                                   summands,
                                   k,
                                   sum ),
                           factors[k] );
            
        end );
        
        ##
        AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( MonB,
          function( MonB, factors, source, tau, P )
            local B, l, summands, s, sum, morphisms;
            
            B := UnderlyingCategory( MonB );
            
            l := Length( factors );
            
            summands := List( [ 1 .. l ], i -> ObjectDatum( MonB, factors[i] )[1] );
            s := ObjectDatum( MonB, source )[1];
            sum := ObjectDatum( MonB, P )[1];
            
            morphisms := List( [ 1 .. l ], i -> MorphismDatum( MonB, tau[i] ) );
            
            return MorphismConstructor( MonB,
                           source,
                           UniversalMorphismIntoDirectSumWithGivenDirectSum( B,
                                   summands,
                                   s,
                                   morphisms,
                                   sum ),
                           P );
            
        end );
        
    fi;
    
    if sym then
        
        ##
        AddTensorUnit( MonB,
          function( MonB )
            local B, U;
            
            B := UnderlyingCategory( MonB );
            
            U := TensorUnit( B );
            
            return ObjectConstructor( MonB,
                           Triple( U,
                                   IdentityMorphism( B, U ),
                                   LeftUnitor( B, U ) ) );
            
        end );
        
        ##
        AddTensorProductOnObjects( MonB,
          function( MonB, monoid1, monoid2 )
            local B, U, triple1, triple2, object1, object2, object, unit, mult;
            
            B := UnderlyingCategory( MonB );
            
            U := TensorUnit( B );
            
            triple1 := ObjectDatum( MonB, monoid1 );
            triple2 := ObjectDatum( MonB, monoid2 );
            
            object1 := triple1[1];
            object2 := triple2[1];
            
            object := TensorProductOnObjects( B,
                              object1,
                              object2 );
            
            unit := PreCompose( B,
                            LeftUnitorInverse( B, U ),
                            TensorProductOnMorphisms( B,
                                    triple1[2],
                                    triple2[2] ) );
            
            mult := PreComposeList( B,
                            TensorProductOnObjects( B, object, object ),
                            [ AssociatorRightToLeft( B,
                                    TensorProductOnObjects( B,
                                            object1,
                                            object2 ),
                                    object1,
                                    object2 ),
                              TensorProductOnMorphisms( B,
                                      AssociatorLeftToRight( B,
                                              object1,
                                              object2,
                                              object1 ),
                                      IdentityMorphism( B,
                                              object2 ) ),
                              TensorProductOnMorphisms( B,
                                    TensorProductOnMorphisms( B,
                                            IdentityMorphism( B,
                                                    object1 ),
                                            Braiding( B,
                                                    object2,
                                                    object1 ) ),
                                    IdentityMorphism( B,
                                            object2 ) ),
                              TensorProductOnMorphisms( B,
                                      AssociatorRightToLeft( B,
                                              object1,
                                              object1,
                                              object2 ),
                                      IdentityMorphism( B,
                                              object2 ) ),
                              AssociatorLeftToRight( B,
                                      TensorProductOnObjects( B,
                                              object1,
                                              object1 ),
                                      object2,
                                      object2 ),
                              TensorProductOnMorphisms( B,
                                      triple1[3],
                                      triple2[3] ) ],
                            object );
            
            return ObjectConstructor( MonB,
                           Triple( object, unit, mult ) );
            
        end );
        
        ##
        AddTensorProductOnMorphismsWithGivenTensorProducts( MonB,
          function( MonB, source, monoid_morphism1, monoid_morphism2, target )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           source,
                           TensorProductOnMorphisms( B,
                                   MorphismDatum( MonB, monoid_morphism1 ),
                                   MorphismDatum( MonB, monoid_morphism2 ) ),
                           target );
            
        end );
        
        ##
        AddLeftUnitorWithGivenTensorProduct( MonB,
          function( MonB, object, source )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           source,
                           LeftUnitorWithGivenTensorProduct( B,
                                   ObjectDatum( MonB, object )[1],
                                   ObjectDatum( MonB, source )[1] ),
                           object );
            
        end );
        
        ##
        AddLeftUnitorInverseWithGivenTensorProduct( MonB,
          function( MonB, object, target )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           object,
                           LeftUnitorInverseWithGivenTensorProduct( B,
                                   ObjectDatum( MonB, object )[1],
                                   ObjectDatum( MonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddRightUnitorWithGivenTensorProduct( MonB,
          function( MonB, object, source )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           source,
                           RightUnitorWithGivenTensorProduct( B,
                                   ObjectDatum( MonB, object )[1],
                                   ObjectDatum( MonB, source )[1] ),
                           object );
            
        end );
        
        ##
        AddRightUnitorInverseWithGivenTensorProduct( MonB,
          function( MonB, object, target )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           object,
                           RightUnitorInverseWithGivenTensorProduct( B,
                                   ObjectDatum( MonB, object )[1],
                                   ObjectDatum( MonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddAssociatorLeftToRightWithGivenTensorProducts( MonB,
          function( MonB, source, object1, object2, object3, target )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           source,
                           AssociatorLeftToRightWithGivenTensorProducts( B,
                                   ObjectDatum( MonB, source )[1],
                                   ObjectDatum( MonB, object1 )[1],
                                   ObjectDatum( MonB, object2 )[1],
                                   ObjectDatum( MonB, object3 )[1],
                                   ObjectDatum( MonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddAssociatorRightToLeftWithGivenTensorProducts( MonB,
          function( MonB, source, object1, object2, object3, target )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           source,
                           AssociatorRightToLeftWithGivenTensorProducts( B,
                                   ObjectDatum( MonB, source )[1],
                                   ObjectDatum( MonB, object1 )[1],
                                   ObjectDatum( MonB, object2 )[1],
                                   ObjectDatum( MonB, object3 )[1],
                                   ObjectDatum( MonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddBraidingWithGivenTensorProducts( MonB,
          function( MonB, source, object1, object2, target )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           source,
                           BraidingWithGivenTensorProducts( B,
                                   ObjectDatum( MonB, source )[1],
                                   ObjectDatum( MonB, object1 )[1],
                                   ObjectDatum( MonB, object2 )[1],
                                   ObjectDatum( MonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddBraidingInverseWithGivenTensorProducts( MonB,
          function( MonB, source, object1, object2, target )
            local B;
            
            B := UnderlyingCategory( MonB );
            
            return MorphismConstructor( MonB,
                           source,
                           BraidingInverseWithGivenTensorProducts( B,
                                   ObjectDatum( MonB, source )[1],
                                   ObjectDatum( MonB, object1 )[1],
                                   ObjectDatum( MonB, object2 )[1],
                                   ObjectDatum( MonB, target )[1] ),
                           target );
            
        end );
        
        ##
        AddInitialObject( MonB,
          function( MonB )
            
            return TensorUnit( MonB );
            
        end );
        
        ##
        AddUniversalMorphismFromInitialObjectWithGivenInitialObject( MonB,
          function( MonB, object, unit )
            
            return MorphismConstructor( MonB,
                           unit,
                           ObjectDatum( MonB, object )[2],
                           object );
            
        end );
        
    fi;
    
    Finalize( MonB );
    
    return MonB;
    
end );

##
InstallMethod( CategoryOfMonoids,
        "for a monoidal category",
        [ IsCapCategory and IsMonoidalCategory ],
        
  function( B )
    
    return CATEGORY_OF_MONOIDS( B );
    
end );

##
InstallMethod( UnderlyingObject,
        "for an internal monoid",
        [ IsInternalMonoid ],
        
  function( monoid )
    
    return ObjectDatum( monoid )[1];
    
end );

##
InstallMethod( \.,
        "for an internal monoid",
        [ IsInternalMonoid, IsPosInt ],
        
  function ( monoid, string_as_int )
    local name, datum;
    
    name := NameRNam( string_as_int );
    
    datum := ObjectDatum( monoid );
    
    if name = "object" then
        return datum[1];
    elif name = "unit" then
        return datum[2];
    elif name = "mult" or name = "multiplication" then
        return datum[3];
    else
        Error( "the monoid only has the componenets `object`, `unit`, `mult` (or `multiplication`)" );
    fi;
    
end );

##
InstallMethod( AssociatedCategoryOfComonoids,
        "for a category of internal monoids",
        [ IsCategoryOfInternalMonoids ],
        
  function( MonB )
    
    return CategoryOfComonoids( UnderlyingCategory( MonB ) );
    
end );

##
InstallMethod( OppositeMonoid,
        "for an internal monoid",
        [ IsInternalMonoid ],
        
  function( monoid )
    local MonB, B, triple, object;
    
    MonB := CapCategory( monoid );
    
    B := UnderlyingCategory( MonB );
    
    triple := ObjectDatum( MonB, monoid );
    
    object := triple[1];
    
    return ObjectConstructor( MonB,
                   Triple( object,
                           triple[2],
                           PreCompose( B,
                                   Braiding( B,
                                           object,
                                           object ),
                                   triple[3] ) ) );
    
end );

##
InstallMethod( IsCommutative,
        "for an internal monoid",
        [ IsInternalMonoid ],
        
  function( monoid )
    
    return OppositeMonoid( monoid ) = monoid;
    
end );

##
InstallMethod( DualComonoid,
        "for an internal monoid",
        [ IsInternalMonoid ],
        
  function( monoid )
    local MonB, B, ComonB, triple, dual;
    
    MonB := CapCategory( monoid );
    
    B := UnderlyingCategory( MonB );
    
    if not CanCompute( B, "DualOnMorphisms" ) then
        TryNextMethod( );
    fi;
    
    ComonB := CategoryOfComonoids( B );
    
    triple := ObjectDatum( MonB, monoid );
    
    dual := DualOnObjects( B, triple[1] );
    
    return ObjectConstructor( ComonB,
                   Triple( dual,
                           DualOnMorphismsWithGivenDuals( B,
                                   dual,
                                   triple[2],
                                   TensorUnit( B ) ),
                           DualOnMorphismsWithGivenDuals( B,
                                   dual,
                                   triple[3],
                                   TensorProductOnObjects( B,
                                           dual,
                                           dual ) ) ) );
    
end );

##
InstallMethod( TransformedMonoid,
        "for a morphism and an internal monoid",
        [ IsCapCategoryMorphism, IsInternalMonoid ],
        
  function( iso, monoid )
    local MonB, B, triple, object, unit, mult, inv;
    
    MonB := CapCategory( monoid );
    
    B := UnderlyingCategory( MonB );
    
    triple := ObjectDatum( MonB, monoid );
    
    object := triple[1];
    unit := triple[2];
    mult := triple[3];
    
    if not IsIdenticalObj( B, CapCategory( iso ) ) then
        Error( "the category of the isomorphism `iso` and the underlying category `B` do not coincide\n" );
    fi;
    
    Assert( 0, IsEndomorphism( iso ) and IsEqualForObjects( B, Source( iso ), object ) );
    Assert( 0, IsIsomorphism( iso ) );
    
    inv := InverseForMorphisms( B, iso );
    
    return ObjectConstructor( MonB,
                   Triple( object,
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
                                   Target( mult ) ) ) );
    
end );

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
InstallMethod( DisplayString,
        "for an internal monoid",
        [ IsInternalMonoid ],
        
  function( monoid )
    local triple;

    triple := ObjectDatum( monoid );
    
    return Concatenation(
                   "Multiplication of monoid:\n\n",
                   StringDisplay( triple[3] ),
                   "\nUnit of monoid:\n\n",
                   StringDisplay( triple[2] ),
                   "\nObject of monoid:\n\n",
                   StringDisplay( triple[1] ),
                   "\nA monoid given by the above data" );
    
end );

##
InstallMethod( DisplayString,
        "for a morphism of internal monoids",
        [ IsInternalMonoidMorphism ],
        
  function( monoid_morphism )
    
    return Concatenation(
                   StringDisplay( MorphismDatum( monoid_morphism ) ),
                   "\nA monoid morphism given by the above data" );
    
end );
