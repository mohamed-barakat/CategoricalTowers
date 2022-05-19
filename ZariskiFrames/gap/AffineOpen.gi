# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#

##
InstallMethod( BaseOfFibration,
        "for a Zariski frame of an affine variety",
        [ IsZariskiFrameOfAnAffineVariety ],
        
  function( ZF )
    
    return TerminalObject( ZF );
    
end );

##
InstallMethod( OpenSubsetOfSpec,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( I )
    local R, R_elim, ZF, A;
    
    R := HomalgRing( I );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := R_elim * I;
        R := R_elim;
    fi;
    
    ZF := ZariskiFrameOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframe( ZF, I );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpecByRadicalColumn,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( I )
    local R, R_elim, ZF, A;
    
    R := HomalgRing( I );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := R_elim * I;
        R := R_elim;
    fi;
    
    ZF := ZariskiFrameOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframeByRadicalColumn( ZF, I );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpecByListOfColumns,
        "for a list",
        [ IsList ],
        
  function( L )
    local R, R_elim, ZF, A;
    
    R := HomalgRing( L[1] );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        L := List( L, I -> R_elim * I );
        R := R_elim;
    fi;
    
    ZF := ZariskiFrameOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframeByListOfColumns( ZF, L );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpecByListOfRadicalColumns,
        "for a list",
        [ IsList ],
        
  function( L )
    local R, R_elim, ZF, A;
    
    R := HomalgRing( L[1] );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        L := List( L, I -> R_elim * I );
        R := R_elim;
    fi;
    
    ZF := ZariskiFrameOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframeByListOfRadicalColumns( ZF, L );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpecByStandardColumn,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( I )
    local R, R_elim, ZF, A;
    
    R := HomalgRing( I );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := R_elim * I;
        R := R_elim;
    fi;
    
    ZF := ZariskiFrameOfAffineSpectrum( R );
    
    A := ObjectInZariskiFrameOrCoframeByStandardColumn( ZF, I );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpec,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return OpenSubsetOfSpec( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );

##
InstallMethod( OpenSubsetOfSpecByRadicalColumn,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return OpenSubsetOfSpecByRadicalColumn( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( OpenSubsetOfSpecByStandardColumn,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return OpenSubsetOfSpecByStandardColumn( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( OpenSubsetOfSpec,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],
        
  function( str, R )
    
    return OpenSubsetOfSpec( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( OpenSubsetOfSpecByRadicalColumn,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],
        
  function( str, R )
    
    return OpenSubsetOfSpecByRadicalColumn( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( OpenSubsetOfSpecByStandardColumn,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],
        
  function( str, R )
    
    return OpenSubsetOfSpecByStandardColumn( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ZariskiFrameOfAffineSpectrum,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    local name, ZariskiFrame, B;
    
    R := PolynomialRingWithProductOrdering( R );
    
    name := "The frame of Zariski open subsets of the affine spectrum of ";
    
    name := Concatenation( name, RingName( R ) );
    
    ZariskiFrame := CreateCapCategory( name,
                            IsZariskiFrameOfAnAffineVariety,
                            IsObjectInZariskiFrameOfAnAffineVariety,
                            IsMorphismInZariskiFrameOfAnAffineVariety,
                            IsCapCategoryTwoCell );
    
    ZariskiFrame!.category_as_first_argument := true;
    
    SetIsHeytingAlgebra( ZariskiFrame, true );
    
    ZariskiFrame!.Constructor := OpenSubsetOfSpec;
    ZariskiFrame!.ConstructorByListOfColumns := OpenSubsetOfSpecByListOfColumns;
    ZariskiFrame!.ConstructorByRadicalColumn := OpenSubsetOfSpecByRadicalColumn;
    ZariskiFrame!.ConstructorByStandardColumn := OpenSubsetOfSpecByStandardColumn;
    
    SetUnderlyingRing( ZariskiFrame, R );
    
    ADD_COMMON_METHODS_FOR_FRAMES_AND_COFRAMES( ZariskiFrame );
    
    ##
    AddIsHomSetInhabited( ZariskiFrame,
      { cat, S, T } -> IsHomSetInhabitedForFrames( cat, S, T ) );
    
    ##
    if IsBound( homalgTable( R )!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        ##
        AddIsEqualForObjectsIfIsHomSetInhabited( ZariskiFrame,
          { cat, A, B } -> IsEqualForObjectsIfIsHomSetInhabitedForFrames( cat, A, B ) );
        
    fi;
    
    ##
    AddIsEqualForObjects( ZariskiFrame,
      function( cat, A, B )
        
        if not DimensionOfComplement( A ) = DimensionOfComplement( B ) then
            return false;
        fi;
        
        return IsHomSetInhabited( cat, A, B ) and IsEqualForObjectsIfIsHomSetInhabited( cat, A, B );
        
    end );
    
    ##
    AddTerminalObject( ZariskiFrame,
      function( cat )
        local T;
        
        T := OpenSubsetOfSpecByStandardColumn( HomalgIdentityMatrix( 1, R ) );
        
        SetIsTerminal( T, true );
        
        return T;
        
    end );
    
    ##
    AddInitialObject( ZariskiFrame,
      function( cat )
        local I;
        
        I := OpenSubsetOfSpecByStandardColumn( HomalgZeroMatrix( 0, 1, R ) );
        
        SetIsInitial( I, true );
        
        return I;
        
    end );
    
    ##
    AddIsTerminal( ZariskiFrame,
      function( cat, A )
        local R, id, mats;
        
        R := UnderlyingRing( cat );
        
        id := HomalgIdentityMatrix( 1, R );
        
        mats := UnderlyingListOfColumns( A );
        
        return ForAll( mats, mat -> IsZero( DecideZeroRows( id, mat ) ) );
        
    end );
    
    ##
    AddIsInitial( ZariskiFrame,
      function( cat, A )
        
        return IsZero( UnderlyingColumn( A ) );
        
    end );
    
    ##
    AddCoproduct( ZariskiFrame,
      function( cat, L )
        local l;
        
        ## triggers radical computations which we want to avoid by all means
        #L := MaximalObjects( L, IsHomSetInhabited );
        ## instead:
        
        l := L[1];
        
        ## testing the membership of 1 might be very expensive for some ideals in the sum
        if ForAny( L, a -> HasIsTerminal( a ) and IsTerminal( a ) ) then
            return TerminalObject( CapCategory( l ) );
        fi;
        
        L := Filtered( L, A -> not IsInitial( A ) );
        
        if L = [ ] then
            return InitialObject( CapCategory( l ) );
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
        
        l := OpenSubsetOfSpec( l );
        
        SetIsInitial( l, false );
        
        return l;
        
    end );
    
    ##
    AddDirectProduct( ZariskiFrame,
      function( cat, L )
        local l;
        
        l := L[1];
        
        if ForAny( L, IsInitial ) then
            return InitialObject( CapCategory( l ) );
        fi;
        
        L := Filtered( L, A -> not IsTerminal( A ) );
        
        if L = [ ] then
            return TerminalObject( CapCategory( l ) );
        elif Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, UnderlyingListOfColumns );
        
        L := Concatenation( L );
        
        l := OpenSubsetOfSpecByListOfColumns( L );
        
        SetIsTerminal( l, false );
        
        return l;
        
    end );
    
    ##
    AddExponentialOnObjects( ZariskiFrame,
      function( cat, A, B )
        local L;
        
        A := BestUnderlyingColumn( A );
        
        if IsZero( A ) then
            return TerminalObject( CapCategory( B ) );
        fi;
        
        B := BestUnderlyingColumn( B );
        
        L := List( [ 1 .. NrRows( A ) ], r -> SyzygiesGeneratorsOfRows( CertainRows( A, [ r ] ), B ) );
        
        L := List( L, OpenSubsetOfSpecByRadicalColumn );
        
        return DirectProduct( L );
        
    end );
    
    Finalize( ZariskiFrame );
    
    SetZariskiFrameOfAffineSpectrum( R, ZariskiFrame );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        SetBaseOfFibration( ZariskiFrame, TerminalObject( ZariskiFrameOfAffineSpectrum( B ) ) );
    fi;
    
    ZariskiFrame!.ZariskiCoframe := ZariskiCoframeOfAffineSpectrum( R );
    
    return ZariskiFrame;
    
end );

InstallGlobalFunction( ZariskiFrameOfAffineSpectrumAsStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows,
  function( R )
    local object_constructor, object_datum,
          morphism_constructor, morphism_datum,
          F, S, P, T,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          ZF, B;
    
    ##
    object_constructor :=
      function( ZF, column_matrix )
        
        return ObjectInZariskiFrameOrCoframe( ZF, column_matrix );
        
    end;
    
    ##
    object_datum :=
      function( ZF, A )
        
        return UnderlyingColumn( A );
        
    end;
    
    ##
    morphism_constructor :=
      function( ZF, source, dummy, range )
        
        return CreateCapCategoryMorphismWithAttributes( ZF, source, range );
        
    end;
    
    ##
    morphism_datum :=
      function( ZF, phi )
        
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
    
    ## semantic: the monoidal cartegory of ideals with generators
    S := SliceCategoryOverTensorUnit( F : overhead := false, FinalizeCategory := true );
    
    ## semantic: the closed monoidal lattice of ideals (without generators)
    P := PosetOfCategory( S : overhead := false, FinalizeCategory := true );
    
    ## semantic1: the Heyting algebra of radical ideals
    ## semantic2: the Heyting algebra of Zariski-open subsets
    T := StablePosetOfCategory( P : overhead := false, FinalizeCategory := true );
    
    ##
    modeling_tower_object_constructor :=
      function( ZF, column_matrix )
        local T, P, S, F;
        
        T := ModelingCategory( ZF );
        P := AmbientCategory( T );
        S := AmbientCategory( P );
        F := AmbientCategory( S );
        
        return ObjectConstructor( T,
                       ObjectConstructor( P,
                               ObjectConstructor( S,
                                       MorphismConstructor( F,
                                               ObjectConstructor( F, NrRows( column_matrix ) ),
                                               column_matrix,
                                               ObjectConstructor( F, 1 ) ) ) ) );
        
    end;
    
    ##
    modeling_tower_object_datum :=
      function( ZF, objT )
        
        return MorphismDatum( F,
                       ObjectDatum( S,
                               ObjectDatum( P,
                                       ObjectDatum( T,
                                               objT ) ) ) );
        
    end;
    
    ##
    modeling_tower_morphism_constructor :=
      function( ZF, sourceT, dummy, rangeT )
        local T;
        
        T := ModelingCategory( ZF );
        
        return MorphismConstructor( T, sourceT, rangeT );
        
    end;
    
    ##
    modeling_tower_morphism_datum :=
      function( ZF, morT )
        
        return fail;
        
    end;
    
    ## semantic: the Heyting algebra of Zariski-open subsets
    ZF := ReinterpretationOfCategory( T,
                  rec( name := Concatenation( "The frame of Zariski open subsets of the affine spectrum of ", RingName( R ) ),
                       category_filter := IsZariskiFrameOfAnAffineVariety,
                       category_object_filter := IsObjectInZariskiFrameOfAnAffineVariety,
                       category_morphism_filter := IsMorphismInZariskiFrameOfAnAffineVariety,
                       object_constructor := object_constructor,
                       object_datum := object_datum,
                       morphism_constructor := morphism_constructor,
                       morphism_datum := morphism_datum,
                       modeling_tower_object_constructor := modeling_tower_object_constructor,
                       modeling_tower_object_datum := modeling_tower_object_datum,
                       modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                       modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                       only_primitive_operations := true ) : FinalizeCategory := false );
    
    SetUnderlyingRing( ZF, R );
    SetBaseObject( ZF, BaseObject( S ) );
    
    SetZariskiFrameOfAffineSpectrum( R, ZF );
    
    ZF!.ZariskiCoframe := ZariskiCoframeOfAffineSpectrum( R : FinalizeCategory := true );
    
    ZF!.Constructor := OpenSubsetOfSpec;
    ZF!.ConstructorByListOfColumns := OpenSubsetOfSpecByListOfColumns;
    ZF!.ConstructorByRadicalColumn := OpenSubsetOfSpecByRadicalColumn;
    ZF!.ConstructorByStandardColumn := OpenSubsetOfSpecByStandardColumn;
    
    ZF!.compiler_hints.category_attribute_names :=
      [ "UnderlyingRing",
        "BaseObject",
        ];
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        SetBaseOfFibration( ZF, TerminalObject( ZariskiFrameOfAffineSpectrum( B : FinalizeCategory := true ) ) );
    fi;
    
    if ValueOption( "no_precompiled_code" ) <> true then
        ADD_FUNCTIONS_FOR_ZariskiFrameOfAffineSpectrumAsStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRowsPrecompiled( ZF );
    fi;
    
    Finalize( ZF );
    
    return ZF;
    
end );

##
InstallMethod( ZariskiFrameOfAffineSpectrum,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    local ZF;
    
    ZF := ZariskiFrameOfAffineSpectrumAsStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows( R : FinalizeCategory := false );
    
    ##
    AddIsHomSetInhabited( ZF,
      { cat, S, T } -> IsHomSetInhabitedForFrames( cat, S, T ) );
    
    ##
    if IsBound( homalgTable( R )!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        ##
        AddIsEqualForObjectsIfIsHomSetInhabited( ZF,
          { cat, A, B } -> IsEqualForObjectsIfIsHomSetInhabitedForFrames( cat, A, B ) );
        
    fi;
    
    ##
    AddIsEqualForObjects( ZF,
      function( cat, A, B )
        
        return IsHomSetInhabited( cat, A, B ) and IsEqualForObjectsIfIsHomSetInhabited( cat, A, B );
        
    end );
    
    Finalize( ZF );
    
    return ZF;
    
end );

##
InstallOtherMethod( IsClosedSubobject,
        "for an object in a Zariski frame of an affine variety",
        [ IsObjectInZariskiFrameOfAnAffineVariety ],
        
  function( A )
    
    return IsClosed( AsDifferenceOfClosed( A ) );
    
end );

##
InstallMethod( DimensionOfComplement,
        "for an object in a Zariski frame of an affine variety",
        [ IsObjectInZariskiFrameOfAnAffineVariety ],
        
  function( A )
    
    A := UnderlyingListOfColumns( A );
    
    return Maximum( List( A, AffineDimension ) );
    
end );

##
InstallMethod( DegreeOfComplement,
        "for an object in a Zariski frame of an affine variety",
        [ IsObjectInZariskiFrameOfAnAffineVariety ],
        
  function( A )
    
    return AffineDegree( BestUnderlyingColumn( A ) );
    
end );
