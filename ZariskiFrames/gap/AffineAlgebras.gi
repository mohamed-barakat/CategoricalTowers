# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#

##
InstallMethod( CategoryOfAffineAlgebras,
        "for a commutative homalg ring",
        [ IsHomalgRing and IsCommutative ],
        
  function( k )
    local name, AffAlg_k;
    
    ##
    name := Concatenation( "CategoryOfAffineAlgebras( ", RingName( k ), " )" );
    
    ##
    AffAlg_k :=
      CreateCapCategory( name,
              IsCategoryOfAffineAlgebras,
              IsAffineAlgebra,
              IsAffineAlgebraMorphism,
              IsCapCategoryTwoCell );
    
    AffAlg_k!.supports_empty_limits := true;
    
    SetCoefficientsRing( AffAlg_k, k );
    SetIsFiniteCocompleteCategory( AffAlg_k, true );
    SetIsCartesianCategory( AffAlg_k, true );
    
    AffAlg_k!.compiler_hints :=
      rec( category_attribute_names :=
           [ "CoefficientsRing",
             ] );
    
    ##
    AddObjectConstructor( AffAlg_k,
      function( AffAlg_k, quintuple_nrgens_nmgens_ring_gens_rels )
        local nr_of_generators, generators, A, matrix_of_relations;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsList( quintuple_nrgens_nmgens_ring_gens_rels ) and
                Length( quintuple_nrgens_nmgens_ring_gens_rels ) = 5 and
                IsList( quintuple_nrgens_nmgens_ring_gens_rels[2] ) );
        
        nr_of_generators := quintuple_nrgens_nmgens_ring_gens_rels[1];
        generators := quintuple_nrgens_nmgens_ring_gens_rels[4];
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsHomalgMatrix( generators ) and
                NrColumns( generators ) = 1 and
                NrRows( generators ) = nr_of_generators );
        
        A := quintuple_nrgens_nmgens_ring_gens_rels[3];
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsHomalgRing( A ) and
                ( IsIdenticalObj( A, k ) or
                  ( HasIsFreePolynomialRing( A ) and
                    IsFreePolynomialRing( A ) and
                    HasCoefficientsRing( A ) and
                    IsIdenticalObj( k, CoefficientsRing( A ) ) ) ) );
        
        matrix_of_relations := quintuple_nrgens_nmgens_ring_gens_rels[5];
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsHomalgMatrix( matrix_of_relations ) and
                IsIdenticalObj( HomalgRing( matrix_of_relations ), A ) );
        
        return CreateCapCategoryObjectWithAttributes( AffAlg_k,
                       DefiningQuintupleOfAffineAlgebra, quintuple_nrgens_nmgens_ring_gens_rels );
        
    end );
    
    ##
    AddObjectDatum( AffAlg_k,
      function( AffAlg_k, algebra )
        
        return DefiningQuintupleOfAffineAlgebra( algebra );
        
    end );
    
    ##
    AddMorphismConstructor( AffAlg_k,
      function( AffAlg_k, source, matrix_of_images, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0,
                IsHomalgMatrix( matrix_of_images ) and
                NrColumns( matrix_of_images ) = 1 and
                IsIdenticalObj( HomalgRing( matrix_of_images ), ObjectDatum( AffAlg_k, target )[3] ) );
        
        return CreateCapCategoryMorphismWithAttributes( AffAlg_k,
                       source,
                       target,
                       MatrixOfImages, matrix_of_images );
        
    end );
    
    ##
    AddMorphismDatum( AffAlg_k,
      function( AffAlg_k, algebra_morphism )
        
        return MatrixOfImages( algebra_morphism );
        
    end );
    
    ##
    AddIsEqualForObjects( AffAlg_k,
      function( AffAlg_k, algebra1, algebra2 )
        
        return ObjectDatum( AffAlg_k, algebra1 ) = ObjectDatum( AffAlg_k, algebra2 );
        
    end );
    
    ##
    AddIsEqualForMorphisms( AffAlg_k,
      function( AffAlg_k, morphism1, morphism2 )
        
        return MorphismDatum( AffAlg_k, morphism1 ) = MorphismDatum( AffAlg_k, morphism2 );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( AffAlg_k,
      function( AffAlg_k, morphism1, morphism2 )
        
        return IsZero( DecideZeroRows( MorphismDatum( AffAlg_k, morphism1 ) - MorphismDatum( AffAlg_k, morphism2 ), ObjectDatum( AffAlg_k, Target( morphism1 ) )[5] ) );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( AffAlg_k,
      function( AffAlg_k, algebra )
        local k, datum, matrix_of_relations, A;
        
        k := CoefficientsRing( AffAlg_k );
        
        datum := ObjectDatum( AffAlg_k, algebra );
        
        if not IsList( datum ) then
            return false;
        elif not Length( datum ) = 5 then
            return false;
        elif not IsInt( datum[1] ) then
            return false;
        elif not ( IsList( datum[2] ) and Length( datum[2] ) = datum[1] ) then
            return false;
        elif not ForAll( datum[2], IsStringRep ) then
            return false;
        elif not IsHomalgRing( datum[3] ) then
            return false;
        elif not ( IsHomalgMatrix( datum[4] ) and NrColumns( datum[4] ) = 1 and NrRows( datum[4] ) = datum[1] ) then
            return false;
        elif not IsIdenticalObj( HomalgRing( datum[4] ), datum[3] ) then
            return false;
        elif not ( IsHomalgMatrix( datum[5] ) and NrColumns( datum[5] ) = 1 ) then
            return false;
        elif not IsIdenticalObj( HomalgRing( datum[5] ), datum[3] ) then
            return false;
        fi;
        
        A := datum[3];
        
        if not ( IsIdenticalObj( A, k ) or HasCoefficientsRing( A ) ) then
            return false;
        elif not IsIdenticalObj( k, CoefficientsRing( A ) ) then
            return false;
        fi;
        
        matrix_of_relations := datum[5];
        
        if not IsHomalgMatrix( matrix_of_relations ) then
            return false;
        fi;
        
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( AffAlg_k,
      function( AffAlg_k, algebra_morphism )
        local datum, image_of_source_relations;
        
        datum := MorphismDatum( AffAlg_k, algebra_morphism );
        
        if not IsHomalgMatrix( datum ) then
            return false;
        elif not IsIdenticalObj( HomalgRing( datum ), ObjectDatum( AffAlg_k, Target( algebra_morphism ) )[3] ) then
            return false;
        elif not NumberColumns( datum ) = 1 then
            return false;
        elif not NumberRows( datum ) = ObjectDatum( AffAlg_k, Source( algebra_morphism ) )[1] then
            return false;
        fi;
        
        image_of_source_relations := Eval( Pullback( AssociatedHomalgRingMap( AffAlg_k, algebra_morphism ), ObjectDatum( AffAlg_k, Source( algebra_morphism ) )[5] ) );
        
        return IsZero( DecideZeroRows( image_of_source_relations, ObjectDatum( AffAlg_k, Target( algebra_morphism ) )[5] ) );
        
    end );
    
    ##
    AddIdentityMorphism( AffAlg_k,
      function( AffAlg_k, algebra )
        
        return MorphismConstructor( AffAlg_k,
                       algebra,
                       ObjectDatum( AffAlg_k, algebra )[4],
                       algebra );
        
    end );
    
    ##
    AddPreCompose( AffAlg_k,
      function( AffAlg_k, pre_morphism, post_morphism )
        
        return MorphismConstructor( AffAlg_k,
                       Source( pre_morphism ),
                       Eval( Pullback( AssociatedHomalgRingMap( AffAlg_k, post_morphism ), MorphismDatum( AffAlg_k, pre_morphism ) ) ),
                       Target( post_morphism ) );
        
    end );
    
    ##
    AddIsMonomorphism( AffAlg_k,
      function( AffAlg_k, algebra_morphism )
        local datum, standardized_algebra_morphism, ker;
        
        datum := ObjectDatum( AffAlg_k, Source( algebra_morphism ) );
        
        standardized_algebra_morphism := IsomorphismsToStandardizedAlgebraMorphism( AffAlg_k, algebra_morphism );
        
        ker := Eval( GeneratorsOfKernelOfRingMap( AssociatedHomalgRingMap( AffAlg_k, standardized_algebra_morphism[2] ) ) );
        
        ker := Eval( Pullback( AssociatedHomalgRingMap( AffAlg_k, standardized_algebra_morphism[1][2][2] ), ker ) );
        
        return IsZero( DecideZeroRows( ker, datum[5] ) );
        
    end );
    
    ##
    AddIsEpimorphism( AffAlg_k,
      function( AffAlg_k, algebra_morphism )
        local k, graph, source, target, datum_source, s, t, coproduct, vars, rhs, R, inv, S;
        
        k := CoefficientsRing( AffAlg_k );
        
        graph := CoordinateAlgebraOfGraph( AffAlg_k, algebra_morphism );
        
        source := Source( algebra_morphism );
        target := Target( algebra_morphism );
        
        datum_source := ObjectDatum( AffAlg_k, source );
        
        s := datum_source[1];
        t := ObjectDatum( AffAlg_k, target )[1];
        
        coproduct := Coproduct( AffAlg_k, [ source, target ] );
        
        vars := ObjectDatum( AffAlg_k, coproduct )[4];
        
        rhs := CertainRows( vars, [ s + 1 .. s + t ] );
        
        R := PolynomialRingWithProductOrdering( AssociatedHomalgRingOfCoproduct( source, target ) );
        
        inv := DecideZero( R * rhs, R * ObjectDatum( graph )[5] );
        
        S := k * ObjectDatum( AffAlg_k, coproduct )[2]{[ 1 .. s ]};
        
        return R * ( S * inv ) = inv;
        
    end );
    
    ##
    AddIsIsomorphism( AffAlg_k,
      function( AffAlg_k, algebra_morphism )
        
        return IsMonomorphism( AffAlg_k, algebra_morphism ) and IsEpimorphism( AffAlg_k, algebra_morphism );
        
    end );
    
    ##
    AddInverseForMorphisms( AffAlg_k,
      function( AffAlg_k, algebra_morphism )
        local k, graph, source, target, datum_source, s, t, coproduct, vars, rhs, R, inv, S;
        
        k := CoefficientsRing( AffAlg_k );
        
        graph := CoordinateAlgebraOfGraph( AffAlg_k, algebra_morphism );
        
        source := Source( algebra_morphism );
        target := Target( algebra_morphism );
        
        datum_source := ObjectDatum( AffAlg_k, source );
        
        s := datum_source[1];
        t := ObjectDatum( AffAlg_k, target )[1];
        
        coproduct := Coproduct( AffAlg_k, [ source, target ] );
        
        vars := ObjectDatum( AffAlg_k, coproduct )[4];
        
        rhs := CertainRows( vars, [ s + 1 .. s + t ] );
        
        R := PolynomialRingWithProductOrdering( AssociatedHomalgRingOfCoproduct( source, target ) );
        
        inv := DecideZero( R * rhs, R * ObjectDatum( graph )[5] );
        
        S := k * ObjectDatum( AffAlg_k, coproduct )[2]{[ 1 .. s ]};
        
        return MorphismConstructor( AffAlg_k,
                       Target( algebra_morphism ),
                       Pullback( RingMap( datum_source[4], S, datum_source[3] ), S * inv ),
                       Source( algebra_morphism ) );
        
    end );
    
    ##
    AddTerminalObject( AffAlg_k,
      function( AffAlg_k )
        local k;
        
        k := CoefficientsRing( AffAlg_k );
        
        return ObjectConstructor( AffAlg_k,
                       NTuple( 5,
                               0,
                               CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( IsStringRep ) ),
                               k,
                               HomalgZeroMatrix( 0, 1, k ),
                               HomalgIdentityMatrix( 1, k ) ) );
        
    end );
    
    ##
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( AffAlg_k,
      function( AffAlg_k, A, zero_ring )
        
        return MorphismConstructor( AffAlg_k,
                       A,
                       HomalgZeroMatrix( 0, 1, ObjectDatum( zero_ring )[3] ),
                       zero_ring );
        
    end );
    
    ##
    AddCoproduct( AffAlg_k,
      function( AffAlg_k, diagram )
        local k, data, nrgens, var, nmgens, ring, gens, maps, rels;
        
        k := CoefficientsRing( AffAlg_k );
        
        data := List( diagram, algebra -> ObjectDatum( AffAlg_k, algebra ) );
        
        nrgens := Sum( data, datum -> datum[1] );
        
        var := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "variable_name", "c" );
        
        nmgens := ParseListOfIndeterminates( [ Concatenation( var, "1..", String( nrgens ) ) ] );
        
        ring := k * nmgens;
        
        gens := HomalgMatrix( List( nmgens, var -> var / ring ), nrgens, 1, ring );
        
        maps := List( [ 1 .. Length( diagram ) ], i -> nmgens{[ 1 + Sum( [ 1 .. i - 1 ], j -> data[j][1] ) .. Sum( [ 1 .. i ], j -> data[j][1] ) ]} );
        
        maps := List( [ 1 .. Length( diagram ) ], i -> List( maps[i], str -> str / ring ) );
        
        maps := List( [ 1 .. Length( diagram ) ], i -> RingMap( maps[i], data[i][3], ring ) );
        
        rels := List( [ 1 .. Length( diagram ) ], i -> Pullback( maps[i], data[i][5] ) );
        
        return ObjectConstructor( AffAlg_k,
                       NTuple( 5,
                               nrgens,
                               nmgens,
                               ring,
                               gens,
                               UnionOfRows( ring, 1, rels ) ) );
        
    end );
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( AffAlg_k,
      function( AffAlg_k, diagram, i, coproduct )
        local data, range;
        
        data := List( diagram, algebra -> ObjectDatum( AffAlg_k, algebra ) );
        
        range := [ 1 + Sum( [ 1 .. i - 1 ], j -> data[j][1] ) .. Sum( [ 1 .. i ], j -> data[j][1] ) ];
        
        return MorphismConstructor( AffAlg_k,
                       diagram[i],
                       CertainRows( ObjectDatum( AffAlg_k, coproduct )[4], range ),
                       coproduct );
        
    end );
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( AffAlg_k,
      function( AffAlg_k, diagram, T, taus, coproduct )
        
        return MorphismConstructor( AffAlg_k,
                       coproduct,
                       UnionOfRows( ObjectDatum( T )[3], 1, List( taus, tau -> MorphismDatum( AffAlg_k, tau ) ) ),
                       T );
        
    end );
    
    ##
    AddCoequalizer( AffAlg_k,
      function( AffAlg_k, target, diagram )
        local datum, data, rels, ring;
        
        datum := ObjectDatum( AffAlg_k, target );
        
        data := List( diagram, morphism -> MorphismDatum( AffAlg_k, morphism ) );
        
        rels := List( [ 1 .. Length( diagram ) - 1 ], i -> data[i] - data[i + 1] );
        
        ring := datum[3];
        
        return ObjectConstructor( AffAlg_k,
                       NTuple( 5,
                               datum[1],
                               datum[2],
                               ring,
                               datum[4],
                               UnionOfRows( ring, 1, Concatenation( rels, [ datum[5] ] ) ) ) );
        
    end );
    
    ##
    AddProjectionOntoCoequalizerWithGivenCoequalizer( AffAlg_k,
      function( AffAlg_k, target, diagram, coequalizer )
        
        return MorphismConstructor( AffAlg_k,
                       target,
                       ObjectDatum( AffAlg_k, coequalizer )[4],
                       coequalizer );
        
    end );
    
    ##
    AddUniversalMorphismFromCoequalizerWithGivenCoequalizer( AffAlg_k,
      function( AffAlg_k, target, diagram, T, tau, coequalizer )
        
        return MorphismConstructor( AffAlg_k,
                       coequalizer,
                       MorphismDatum( AffAlg_k, tau ),
                       T );
        
    end );
    
    ##
    AddCoimageObject( AffAlg_k,
      function( AffAlg_k, algebra_morphism )
        local datum, ring, standardized_algebra_morphism, ker;
        
        datum := ObjectDatum( AffAlg_k, Source( algebra_morphism ) );
        
        ring := datum[3];
        
        standardized_algebra_morphism := IsomorphismsToStandardizedAlgebraMorphism( AffAlg_k, algebra_morphism );
        
        ker := Eval( GeneratorsOfKernelOfRingMap( AssociatedHomalgRingMap( AffAlg_k, standardized_algebra_morphism[2] ) ) );
        
        ker := Eval( Pullback( AssociatedHomalgRingMap( AffAlg_k, standardized_algebra_morphism[1][2][2] ), ker ) );
        
        return ObjectConstructor( AffAlg_k,
                       NTuple( 5,
                               datum[1],
                               datum[2],
                               ring,
                               datum[4],
                               UnionOfRows( ring, 1, [ ker, datum[5] ] ) ) );
        
    end );
    
    ##
    AddCoimageProjectionWithGivenCoimageObject( AffAlg_k,
      function( AffAlg_k, algebra_morphism, coimage )
        
        return MorphismConstructor( AffAlg_k,
                       Source( algebra_morphism ),
                       ObjectDatum( AffAlg_k, coimage )[4],
                       coimage );
        
    end );
    
    ##
    AddAstrictionToCoimageWithGivenCoimageObject( AffAlg_k,
      function( AffAlg_k, algebra_morphism, coimage )
        
        return MorphismConstructor( AffAlg_k,
                       coimage,
                       MorphismDatum( AffAlg_k, algebra_morphism ),
                       Target( algebra_morphism ) );
        
    end );
    
    Finalize( AffAlg_k );
    
    return AffAlg_k;
    
end );

##
InstallOtherMethod( MorphismConstructor,
        "for an affine algebra",
        [ IsAffineAlgebra, IsList, IsAffineAlgebra ],
        
  function( S, list_of_images, T )
    local matrix_of_images;
    
    matrix_of_images := HomalgMatrix( list_of_images, Length( list_of_images ), 1, AmbientAlgebra( T ) );
    
    return MorphismConstructor( S, matrix_of_images, T );
    
end );

##
InstallMethod( AmbientAlgebra,
        "for an affine algebra",
        [ IsAffineAlgebra ],
        
  function( algebra )
    
    return ObjectDatum( algebra )[3];
    
end );

##
InstallMethod( \/,
        "for a homalg ring and a category of affine algebras",
        [ IsHomalgRing, IsCategoryOfAffineAlgebras ],
        
  function( ring, AffAlg_k )
    local A, relations, generators, n;
    
    if HasAmbientRing( ring ) then
        A := AmbientRing( ring );
        relations := MatrixOfRelations( ring );
    else
        A := ring;
        relations := HomalgZeroMatrix( 0, 1, A );
    fi;
    
    generators := Indeterminates( A );
    
    n := Length( generators );
    
    return ObjectConstructor( AffAlg_k,
                   NTuple( 5,
                           n,
                           List( generators, String ),
                           A,
                           HomalgMatrix( generators, n, 1, A ),
                           relations ) );
    
end );

##
InstallOtherMethodForCompilerForCAP( AssociatedHomalgRing,
        "for a category of affine algebras and an affine algebra therein",
        [ IsCategoryOfAffineAlgebras, IsAffineAlgebra ],
        
  function( AffAlg_k, algebra )
    local datum, homalg_ring;
    
    datum := ObjectDatum( AffAlg_k, algebra );
    
    if HasIsZero( datum[5] ) and IsZero( datum[5] ) then
        homalg_ring := datum[3] / 0;
    else
        homalg_ring := datum[3] / datum[5];
    fi;
    
    Assert( 0, HasAmbientRing( homalg_ring ) and IsIdenticalObj( AmbientRing( homalg_ring ), ObjectDatum( AffAlg_k, algebra )[3] ) );
    
    return homalg_ring;
    
end );

##
InstallMethod( AssociatedHomalgRing,
        "for an affine algebra",
        [ IsAffineAlgebra ],
        
  function( algebra )
    
    return AssociatedHomalgRing( CapCategory( algebra ), algebra );
    
end );

##
InstallOtherMethodForCompilerForCAP( AssociatedHomalgRingMap,
        "for a category of affine algebras and a affine algebra morphism therein",
        [ IsCategoryOfAffineAlgebras, IsAffineAlgebraMorphism ],
        
  function( AffAlg_k, algebra_morphism )
    
    return RingMap( MorphismDatum( AffAlg_k, algebra_morphism ),
                   AssociatedHomalgRing( AffAlg_k, Source( algebra_morphism ) ),
                   AssociatedHomalgRing( AffAlg_k, Target( algebra_morphism ) ) );
    
end );

##
InstallMethod( AssociatedHomalgRingMap,
        "for a affine algebra morphism",
        [ IsAffineAlgebraMorphism ],
        
  function( algebra_morphism )
    
    return AssociatedHomalgRingMap( CapCategory( algebra_morphism ), algebra_morphism );
    
end );

##
InstallMethodForCompilerForCAP( IsomorphismsToStandardizedAlgebra,
        "for a category of affine algebras and an affine algebra therein",
        [ IsCategoryOfAffineAlgebras, IsAffineAlgebra, IsInt ],
        
  function( AffAlg_k, algebra, o )
    local k, datum, n, nmgens, S, vars, standardized_algebra, iso, inv;
    
    k := CoefficientsRing( AffAlg_k );
    
    datum := ObjectDatum( AffAlg_k, algebra );
    
    n := datum[1];
    
    nmgens := List( [ o + 1 .. o + n ], i -> Concatenation( "x", String( i ) ) );
    
    S := k * nmgens;
    
    vars := HomalgMatrix( List( nmgens, str -> str / S ), n, 1, S );
    
    standardized_algebra := ObjectConstructor( AffAlg_k,
                                    NTuple( 5,
                                            n,
                                            nmgens,
                                            S,
                                            vars,
                                            Pullback( RingMap( vars, datum[3], S ), datum[5] ) ) );
    
    iso := MorphismConstructor( AffAlg_k,
                   algebra,
                   vars,
                   standardized_algebra );
    
    inv := MorphismConstructor( AffAlg_k,
                   standardized_algebra,
                   datum[4],
                   algebra );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    SetIsIsomorphism( iso, true );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    SetIsIsomorphism( inv, true );
    
    return Pair( standardized_algebra,
                 Pair( iso, inv ) );
    
end );

##
InstallMethodForCompilerForCAP( IsomorphismsToStandardizedAlgebraMorphism,
        "for a category of affine algebras and an affine algebra morphism therein",
        [ IsCategoryOfAffineAlgebras, IsAffineAlgebraMorphism ],
        
  function( AffAlg_k, algebra_morphism )
    local source, isos_source, isos_target;
    
    source := Source( algebra_morphism );
    
    isos_source := IsomorphismsToStandardizedAlgebra( AffAlg_k, source, 0 );
    isos_target := IsomorphismsToStandardizedAlgebra( AffAlg_k, Target( algebra_morphism ), ObjectDatum( AffAlg_k, source )[1] );
    
    return NTuple( 3,
                   isos_source,
                   PreComposeList( AffAlg_k,
                           isos_source[1],
                           [ isos_source[2][2],
                             algebra_morphism,
                             isos_target[2][1] ],
                           isos_target[1] ),
                   isos_target );
    
end );

##
InstallMethod( AssociatedHomalgRingOfCoproduct,
        "for two affine algebras",
        [ IsAffineAlgebra, IsAffineAlgebra ],
        
  function( algebra1, algebra2 )
    local AffAlg_k, k, coproduct, vars, n;
    
    AffAlg_k := CapCategory( algebra1 );
    
    if not IsIdenticalObj( AffAlg_k, CapCategory( algebra2 ) ) then
        Error( "the two affine algebras lie in different categories\n" );
    fi;
    
    k := CoefficientsRing( AffAlg_k );
    
    coproduct := Coproduct( algebra1, algebra2 );
    
    vars := ObjectDatum( coproduct )[2];
    
    n := ObjectDatum( algebra1 )[1];
    
    return k * vars{[ 1 .. n ]} * vars{[ n + 1 .. ObjectDatum( coproduct )[1] ]};
    
end );

##
InstallOtherMethodForCompilerForCAP( CoordinateAlgebraOfGraph,
        "for a affine algebra morphism",
        [ IsCategoryOfAffineAlgebras, IsAffineAlgebraMorphism ],
        
  function( AffAlg_k, algebra_morphism )
    local source, iota_target, coproduct, datum, s, rhs, lhs, ring;
    
    source := Source( algebra_morphism );
    
    iota_target := InjectionOfCofactorOfCoproduct( AffAlg_k, [ source, Target( algebra_morphism ) ], 2 );
    
    coproduct := Target( iota_target );
    
    datum := ObjectDatum( AffAlg_k, coproduct );
    
    s := ObjectDatum( AffAlg_k, source )[1];
    
    rhs := CertainRows( datum[4], [ 1 .. s ] );
    
    lhs := Eval( Pullback( AssociatedHomalgRingMap( AffAlg_k, iota_target ), MorphismDatum( AffAlg_k, algebra_morphism ) ) );
    
    ring := datum[3];
    
    return ObjectConstructor( AffAlg_k,
                   NTuple( 5,
                           datum[1],
                           datum[2],
                           ring,
                           datum[4],
                           UnionOfRows( ring, 1, [ lhs - rhs, datum[5] ] ) ) );
    
end );

##
InstallMethod( CoordinateAlgebraOfGraph,
        "for a affine algebra morphism",
        [ IsAffineAlgebraMorphism ],
        
  function( algebra_morphism )
    
    return CoordinateAlgebraOfGraph( CapCategory( algebra_morphism ), algebra_morphism );
    
end );

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
InstallMethod( DisplayString,
        "for an affine algebra",
        [ IsAffineAlgebra ],
        
  function( algebra )
    
    return Concatenation( RingName( AssociatedHomalgRing( algebra ) ), "\n" );
    
end );

##
InstallMethod( Display,
        "for a affine algebra morphism",
        [ IsAffineAlgebraMorphism ],
        
  function( algebra_morphism )
    
    Display( AssociatedHomalgRingMap( algebra_morphism ) );
    
end );
