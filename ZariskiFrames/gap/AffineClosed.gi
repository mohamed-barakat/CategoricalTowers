# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#

##
InstallMethod( BaseOfFibration,
        "for a Zariski coframe of an affine variety",
        [ IsZariskiCoframeOfAnAffineVariety ],
        
  function( ZC )
    
    return TerminalObject( ZC );
    
end );

##
InstallMethod( ClosedSubsetOfSpec,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( I )
    local R, R_elim, ZC, A;
    
    R := HomalgRing( I );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := R_elim * I;
        R := R_elim;
    fi;
    
    ZC := ZariskiCoframeOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframe( ZC, I );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpec,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return ClosedSubsetOfSpec( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );

##
InstallMethod( ClosedSubsetOfSpecByRadicalColumn,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( I )
    local R, R_elim, ZC, A;
    
    R := HomalgRing( I );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := R_elim * I;
        R := R_elim;
    fi;
    
    ZC := ZariskiCoframeOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframeByRadicalColumn( ZC, I );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByRadicalColumn,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return ClosedSubsetOfSpecByRadicalColumn( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( ClosedSubsetOfSpecByListOfColumns,
        "for a list",
        [ IsList ],
        
  function( L )
    local R, R_elim, ZC, A;
    
    R := HomalgRing( L[1] );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        L := List( L, I -> R_elim * I );
        R := R_elim;
    fi;
    
    ZC := ZariskiCoframeOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframeByListOfColumns( ZC, L );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByListOfRadicalColumns,
        "for a list",
        [ IsList ],
        
  function( L )
    local R, R_elim, ZC, A;
    
    R := HomalgRing( L[1] );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        L := List( L, I -> R_elim * I );
        R := R_elim;
    fi;
    
    ZC := ZariskiCoframeOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframeByListOfRadicalColumns( ZC, L );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardColumn,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( I )
    local R, R_elim, ZC, A;
    
    R := HomalgRing( I );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := R_elim * I;
        R := R_elim;
    fi;
    
    ZC := ZariskiCoframeOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframeByStandardColumn( ZC, I );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardColumn,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return ClosedSubsetOfSpecByStandardColumn( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( ClosedSubsetOfSpec,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],
        
  function( str, R )
    
    return ClosedSubsetOfSpec( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByRadicalColumn,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],
        
  function( str, R )
    
    return ClosedSubsetOfSpecByRadicalColumn( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardColumn,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],
        
  function( str, R )
    
    return ClosedSubsetOfSpecByStandardColumn( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ZariskiCoframeOfAffineSpectrum,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    local name, ZariskiCoframe, B;
    
    R := PolynomialRingWithProductOrdering( R );
    
    name := "The coframe of Zariski closed subsets of the affine spectrum of ";
    
    name := Concatenation( name, RingName( R ) );
    
    ZariskiCoframe := CreateCapCategory( name,
                              IsZariskiCoframeOfAnAffineVariety,
                              IsObjectInZariskiCoframeOfAnAffineVariety,
                              IsMorphismInZariskiCoframeOfAnAffineVariety,
                              IsCapCategoryTwoCell );
    
    ZariskiCoframe!.category_as_first_argument := true;
    
    SetIsCoHeytingAlgebra( ZariskiCoframe, true );
    
    ZariskiCoframe!.Constructor := ClosedSubsetOfSpec;
    ZariskiCoframe!.ConstructorByListOfColumns := ClosedSubsetOfSpecByListOfColumns;
    ZariskiCoframe!.ConstructorByRadicalColumn := ClosedSubsetOfSpecByRadicalColumn;
    ZariskiCoframe!.ConstructorByStandardColumn := ClosedSubsetOfSpecByStandardColumn;
    
    SetUnderlyingRing( ZariskiCoframe, R );
    
    ADD_COMMON_METHODS_FOR_FRAMES_AND_COFRAMES( ZariskiCoframe );
    
    ##
    AddIsHomSetInhabited( ZariskiCoframe,
      { cat, S, T } -> IsHomSetInhabitedForCoframes( cat, S, T ) );
    
    ##
    if IsBound( homalgTable( R )!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        ##
        AddIsEqualForObjectsIfIsHomSetInhabited( ZariskiCoframe,
          { cat, A, B } -> IsEqualForObjectsIfIsHomSetInhabitedForCoframes( cat, A, B ) );
        
    fi;
    
    ##
    AddIsEqualForObjects( ZariskiCoframe,
      function( cat, A, B )
        
        if not Dimension( A ) = Dimension( B ) then
            return false;
        fi;
        
        return IsHomSetInhabited( cat, A, B ) and IsEqualForObjectsIfIsHomSetInhabited( cat, A, B );
        
    end );
    
    ##
    AddTerminalObject( ZariskiCoframe,
      function( cat )
        local T;
        
        T := ClosedSubsetOfSpecByStandardColumn( HomalgZeroMatrix( 0, 1, R ) );
        
        SetIsTerminal( T, true );
        
        return T;
        
    end );
    
    ##
    AddInitialObject( ZariskiCoframe,
      function( cat )
        local I;
        
        I := ClosedSubsetOfSpecByStandardColumn( HomalgIdentityMatrix( 1, R ) );
        
        SetIsInitial( I, true );
        
        return I;
        
    end );
    
    ##
    AddIsTerminal( ZariskiCoframe,
      function( cat, A )
        
        return IsZero( UnderlyingColumn( A ) );
        
    end );
    
    ##
    AddIsInitial( ZariskiCoframe,
      function( cat, A )
        local R, id, mats;
        
        R := UnderlyingRing( cat );
        
        id := HomalgIdentityMatrix( 1, R );
        
        mats := UnderlyingListOfColumns( A );
        
        return ForAll( mats, mat -> IsZero( DecideZeroRows( id, mat ) ) );
        
    end );
    
    ##
    AddCoproduct( ZariskiCoframe,
      function( cat, L )
        local l;
        
        l := L[1];
        
        if ForAny( L, IsTerminal ) then
            return TerminalObject( CapCategory( l ) );
        fi;
        
        L := Filtered( L, A -> not IsInitial( A ) );
        
        if L = [ ] then
            return InitialObject( CapCategory( l ) );
        elif Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, UnderlyingListOfColumns );
        
        L := Concatenation( L );
        
        l := ClosedSubsetOfSpecByListOfColumns( L );
        
        SetIsInitial( l, false );
        
        return l;
        
    end );
    
    ##
    AddDirectProduct( ZariskiCoframe,
      function( cat, L )
        local l;
        
        ## triggers radical computations which we want to avoid by all means
        #L := MaximalObjects( L, IsSubset );
        ## instead:
        
        l := L[1];

        ## testing the membership of 1 might be very expensive for some ideals in the sum
        if ForAny( L, a -> HasIsInitial( a ) and IsInitial( a ) ) then
            return InitialObject( CapCategory( l ) );
        fi;
        
        L := Filtered( L, A -> not IsTerminal( A ) );
        
        if L = [ ] then
            return TerminalObject( CapCategory( l ) );
        elif Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, UnderlyingColumn );
        
        L := DuplicateFreeList( L );
        
        ## examples show that the GB computations of the entries of L
        ## (needed to check IsZero @ DecideZeroRows) might be immensely more expensive
        ## than the GB of the resulting UnionOfRows( L ),
        ## so never execute the next line:
        #L := MaximalObjects( L, { a, b } -> IsZero( DecideZeroRows( a, b ) ) );
        
        l := UnionOfRows( L );
        
        l := ClosedSubsetOfSpec( l );
        
        SetIsTerminal( l, false );
        
        return l;
        
    end );
    
    ## the closure of the set theortic difference
    AddCoexponentialOnObjects( ZariskiCoframe,
      function( cat, A, B )
        local L;
        
        B := BestUnderlyingColumn( B );
        
        if IsZero( B ) then
            return InitialObject( CapCategory( A ) );
        fi;
        
        A := BestUnderlyingColumn( A );
        
        L := List( [ 1 .. NrRows( B ) ], r -> SyzygiesGeneratorsOfRows( CertainRows( B, [ r ] ), A ) );
        
        L := List( L, ClosedSubsetOfSpecByRadicalColumn );
        
        return Coproduct( L );
        
    end );
    
    Finalize( ZariskiCoframe );
    
    SetZariskiCoframeOfAffineSpectrum( R, ZariskiCoframe );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        SetBaseOfFibration( ZariskiCoframe, TerminalObject( ZariskiCoframeOfAffineSpectrum( B ) ) );
    fi;
    
    return ZariskiCoframe;
    
end );

InstallGlobalFunction( ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows,
  function( R )
    local object_constructor, object_datum,
          morphism_constructor, morphism_datum,
          F, S, P, T, O,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          ZC, B;
    
    ##
    object_constructor :=
      function( ZC, column_matrix )
        
        #return ObjectInZariskiFrameOrCoframe( ZC, RadicalSubobjectOp( column_matrix ) );
        return ObjectInZariskiFrameOrCoframe( ZC, column_matrix );
        
    end;
    
    ##
    object_datum :=
      function( ZC, A )
        
        return UnderlyingColumn( A );
        
    end;
    
    ##
    morphism_constructor :=
      function( ZC, source, dummy, range )
        
        return CreateCapCategoryMorphismWithAttributes( ZC, source, range );
        
    end;
    
    ##
    morphism_datum :=
      function( ZC, phi )
        
        return fail;
        
    end;
    
    ## modifing the lowest level category of the tower
    if not IsBound( R!.CategoryOfRows ) then
        R!.CategoryOfRows := CategoryOfRows( R : overhead := false, FinalizeCategory := false );
        
        ##
        AddProjectionOfBiasedWeakFiberProduct( R!.CategoryOfRows,
          function( cat, morphism_1, morphism_2 )
            local homalg_matrix;
            
            homalg_matrix := SyzygiesOfRows( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) );
            
            return CategoryOfRowsMorphism( cat, CategoryOfRowsObject( cat, NrRows( homalg_matrix ) ), homalg_matrix, Source( morphism_1 ) ); # taking NrRows could be avoided by using a WithGiven version
            
        end );
        
        Finalize( R!.CategoryOfRows : FinalizeCategory := true );
        
    fi;
    
    ## building the tower
    
    ## semantic: the additive monoidal category of free R-modules
    F := R!.CategoryOfRows;
    
    ## semantic: the monoidal category of ideals with generators
    S := SliceCategoryOverTensorUnit( F : overhead := false, FinalizeCategory := true );
    
    ## semantic: the closed monoidal lattice of ideals (without generators)
    P := PosetOfCategory( S : overhead := false, FinalizeCategory := true );
    
    ## semantic1: the Heyting algebra of radical ideals
    ## semantic2: the Heyting algebra of Zariski-open subsets
    T := StablePosetOfCategory( P : overhead := false, FinalizeCategory := true );
    
    ## semantic1: th opposite of the Heyting algebra of radical ideals
    ## semantic2: the co-Heyting algebra of Zariski-closed subsets
    O := Opposite( T : only_primitive_operations := true, overhead := false, FinalizeCategory := true );
    
    ##
    modeling_tower_object_constructor :=
      function( ZC, column_matrix )
        local O, T, P, S, F;
        
        O := ModelingCategory( ZC );
        T := OppositeCategory( O );
        P := AmbientCategory( T );
        S := AmbientCategory( P );
        F := AmbientCategory( S );
        
        return ObjectConstructor( O,
                       ObjectConstructor( T,
                               ObjectConstructor( P,
                                       ObjectConstructor( S,
                                               MorphismConstructor( F,
                                                       ObjectConstructor( F, NrRows( column_matrix ) ),
                                                       column_matrix,
                                                       ObjectConstructor( F, 1 ) ) ) ) ) );
        
    end;
    
    ##
    modeling_tower_object_datum :=
      function( ZC, objO )
        local O, T, P, S, F;
        
        O := ModelingCategory( ZC );
        T := OppositeCategory( O );
        P := AmbientCategory( T );
        S := AmbientCategory( P );
        F := AmbientCategory( S );
        
        return MorphismDatum( F,
                       ObjectDatum( S,
                               ObjectDatum( P,
                                       ObjectDatum( T,
                                               ObjectDatum( O,
                                                       objO ) ) ) ) );
        
    end;
    
    ##
    modeling_tower_morphism_constructor :=
      function( ZC, sourceO, dummy, rangeO )
        local O;
        
        O := ModelingCategory( ZC );
        
        return MorphismConstructor( O, sourceO, rangeO );
        
    end;
    
    ##
    modeling_tower_morphism_datum :=
      function( ZC, morO )
        
        return fail;
        
    end;
    
    ## semantic: the co-Heyting algebra of Zariski closed subsets
    ZC := ReinterpretationOfCategory( O,
                  rec( name := Concatenation( "The coframe of Zariski closed subsets of the affine spectrum of ", RingName( R ) ),
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
    
    ZC!.compiler_hints.category_attribute_names :=
      [ "UnderlyingRing",
        "BaseObject",
        ];
    
    ZC!.compiler_hints.precompiled_towers :=
      [ rec(
            remaining_constructors_in_tower := [ "MeetSemilatticeOfDifferences" ],
            precompiled_functions_adder := ValueGlobal( "ADD_FUNCTIONS_FOR_MeetSemilatticeOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled" ),
            ),
        rec(
            remaining_constructors_in_tower := [ "MeetSemilatticeOfMultipleDifferences" ],
            precompiled_functions_adder := ValueGlobal( "ADD_FUNCTIONS_FOR_MeetSemilatticeOfMultipleDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled" ),
            ),
        rec(
            remaining_constructors_in_tower := [ "BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences" ],
            precompiled_functions_adder := ValueGlobal( "ADD_FUNCTIONS_FOR_BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled" ),
            ),
        ];
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        SetBaseOfFibration( ZC, TerminalObject( ZariskiCoframeOfAffineSpectrum( B : FinalizeCategory := true ) ) );
    fi;
    
    if ValueOption( "no_precompiled_code" ) <> true then
        ADD_FUNCTIONS_FOR_ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled( ZC );
    fi;
    
    Finalize( ZC );
    
    return ZC;
    
end );

##
InstallMethod( ZariskiCoframeOfAffineSpectrum,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    local ZC;
    
    ZC := ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows( R : FinalizeCategory := false );
    
    ##
    AddIsHomSetInhabited( ZC,
      { cat, S, T } -> IsHomSetInhabitedForCoframes( cat, S, T ) );
    
    ##
    if IsBound( homalgTable( R )!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        ##
        AddIsEqualForObjectsIfIsHomSetInhabited( ZC,
          { cat, A, B } -> IsEqualForObjectsIfIsHomSetInhabitedForCoframes( cat, A, B ) );
        
    fi;
    
    ##
    AddIsEqualForObjects( ZC,
      function( cat, A, B )
        
        if not Dimension( A ) = Dimension( B ) then
            return false;
        fi;
        
        return IsHomSetInhabited( cat, A, B ) and IsEqualForObjectsIfIsHomSetInhabited( cat, A, B );
        
    end );
    
    Finalize( ZC );
    
    return ZC;
    
end );

##
InstallOtherMethod( IsOpen,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],
        
  function( A )
    
    return IsClosed( -A );
    
end );

##
InstallOtherMethod( Dimension,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],
        
  function( A )
    
    A := UnderlyingListOfColumns( A );
    
    return Maximum( List( A, AffineDimension ) );
    
end );

##
InstallOtherMethod( DegreeAttr,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],
        
  function( A )
    
    return AffineDegree( BestUnderlyingColumn( A ) );
    
end );

##
InstallMethod( AClosedSingleton,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframe and IsObjectInZariskiFrameOrCoframeOfAnAffineVariety ],
        
  function( A )
    local C;
    
    if IsInitial( A ) then
        Error( "the input A is empty\n" );
    fi;
    
    C := CapCategory( A );
    
    A := UnderlyingStandardColumn( A );
    
    A := AMaximalIdealContaining( A );
    
    A := C!.ConstructorByRadicalColumn( A );
    
    return A;
    
end );

## the second argument is for the method selection
InstallMethod( RabinowitschCover,
        "for an object in a meet-semilattice of formal single differences and an object in a Zariski coframe of an affine variety",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInZariskiCoframeOfAnAffineVariety ],
        
  function( A, Ac )
    local Ap, R, indets, B, S, t;
    
    A := StandardizeObject( A );
    
    Ap := A.J;
    Ap := BestUnderlyingColumn( Ap );
    
    A := A.I;
    
    A := BestUnderlyingColumn( A );
    
    R := HomalgRing( A );
    
    Ap := DecideZeroRows( Ap, A );
    Ap := CertainRows( Ap, NonZeroRows( Ap ) );
    
    indets := List( RelativeIndeterminatesOfPolynomialRing( R ), String );
    
    B := BaseRing( R );
    
    S := B * Concatenation( indets, [ "t_Rabinowitsch" ] );
    
    t := RelativeIndeterminatesOfPolynomialRing( S )[Length( indets) + 1];
    
    A := S * A;
    Ap := S * Ap;
    
    Ap := EntriesOfHomalgMatrix( Ap );
    Ap := DuplicateFreeList( Ap );
    Ap := List( Ap, a -> t * a - 1 );
    
    Ap := List( Ap, p -> HomalgMatrix( [ p ], 1, 1, S ) );
    A := List( Ap, p -> UnionOfRows( A, p ) );
    
    A := List( A, ClosedSubsetOfSpecByRadicalColumn );
    
    return Sum( A );
    
end );

##
InstallMethod( TangentSpaceAtPoint,
        "for an object in a Zariski coframe of an affine variety and a homalg matrix",
        [ IsObjectInZariskiCoframeOfAnAffineVariety, IsHomalgMatrix ],
        
  function( gamma, point )
    local R, T, var;
    
    R := UnderlyingRing( gamma );
    
    gamma := BestUnderlyingColumn( gamma );
    
    T := TangentSpaceByEquationsAtPoint( gamma, point );
    
    var := Indeterminates( R );
    
    T := ( R * T ) * HomalgMatrix( var, Length( var ), 1, R );
    
    return ClosedSubsetOfSpecByRadicalColumn( T );
    
end );

##
InstallMethod( TangentSpaceAtPoint,
        "for an object in a Zariski coframe of an affine variety and a list",
        [ IsObjectInZariskiCoframeOfAnAffineVariety, IsList ],
        
  function( gamma, point )
    local R, k;
    
    R := UnderlyingRing( gamma );
    
    k := CoefficientsRing( R );
    
    point := HomalgMatrix( point, Length( point ), 1, k );
    
    return TangentSpaceAtPoint( gamma, point );
    
end );

##
InstallMethod( ComplementOfTangentSpaceAtPoint,
        "for an object in a Zariski coframe of an affine variety and a homalg matrix",
        [ IsObjectInZariskiCoframeOfAnAffineVariety, IsHomalgMatrix ],
        
  function( gamma, point )
    local R, T;
    
    R := UnderlyingRing( gamma );
    
    gamma := BestUnderlyingColumn( gamma );
    
    T := TangentSpaceByEquationsAtPoint( gamma, point );
    
    return MatrixOfGenerators( ByASmallerPresentation( LeftPresentation( T ) ) );
    
end );

##
InstallMethod( ComplementOfTangentSpaceAtPoint,
        "for an object in a Zariski coframe of an affine variety and a list",
        [ IsObjectInZariskiCoframeOfAnAffineVariety, IsList ],
        
  function( gamma, point )
    local R, k;
    
    R := UnderlyingRing( gamma );
    
    k := CoefficientsRing( R );
    
    point := HomalgMatrix( point, Length( point ), 1, k );
    
    return ComplementOfTangentSpaceAtPoint( gamma, point );
    
end );
