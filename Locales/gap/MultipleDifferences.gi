# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
InstallOtherMethodForCompilerForCAP( MultipleDifference,
        "for a meet semi-lattice of multiple differences and a pair",
        [ IsMeetSemilatticeOfMultipleDifferences, IsList ],
        
  function( D, minuend_subtrahends_pair )
    local A;
    
    A := CreateCapCategoryObjectWithAttributes( D,
                 PreMinuendAndSubtrahendsInUnderlyingLattice, minuend_subtrahends_pair,
                 IsLocallyClosed, true );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( MeetSemilatticeOfMultipleDifferences,
        "for a CAP category",
        [ IsCapCategory and IsThinCategory ],
        
  function( P )
    local name, D;
    
    name := "The meet-semilattice of multiple differences of ";
    
    name := Concatenation( name, Name( P ) );
    
    D := CreateCapCategory( name,
                 IsMeetSemilatticeOfMultipleDifferences,
                 IsObjectInMeetSemilatticeOfMultipleDifferences,
                 IsMorphismInMeetSemilatticeOfMultipleDifferences,
                 IsCapCategoryTwoCell );
    
    D!.category_as_first_argument := true;
    
    SetIsMeetSemiLattice( D, true );
    
    SetUnderlyingCategory( D, P );
    
    SetUnderlyingCategoryOfSingleDifferences( D, MeetSemilatticeOfSingleDifferences( P ) );
    
    D!.compiler_hints :=
      rec(
          category_attribute_names := [
                  "UnderlyingCategory",
                  "UnderlyingCategoryOfSingleDifferences",
                  ],
          );
    
    ADD_COMMON_METHODS_FOR_PREORDERED_SETS( D );
    
    ##
    AddIsWellDefinedForObjects( D,
      function( cat, A )
        local H, ms;
        
        H := UnderlyingCategory( cat );
        
        ms := MinuendAndSubtrahendsInUnderlyingLattice( A );
        
        return IsIdenticalObj( CapCategory( ms[1] ), H ) and ForAll( ms[2], s -> IsIdenticalObj( CapCategory( s ), H ) ) and
               IsWellDefinedForObjects( H, ms[1] ) and ForAll( ms[2], s -> IsWellDefinedForObjects( H, s ) );
        
    end );
    
    ##
    AddTerminalObject( D,
      function( cat )
        local H, T, I;
        
        H := UnderlyingCategory( cat );
        
        T := TerminalObject( H );
        I := InitialObject( H );
        
        return MultipleDifference( cat, Pair( T, [ I ] ) );
        
    end );
    
    ##
    AddInitialObject( D,
      function( cat )
        local I;
        
        I := InitialObject( UnderlyingCategory( cat ) );
        
        return MultipleDifference( cat, Pair( I, [ I ] ) );
        
    end );
    
    ##
    AddIsInitial( D,
      function( cat, A )
        local ms, minuend, subtrahend, SD;
        
        ms := MinuendAndSubtrahendsInUnderlyingLattice( A );
        
        minuend := ms[1];
        
        subtrahend := Coproduct( UnderlyingCategory( cat ), ms[2] );
        
        SD := UnderlyingCategoryOfSingleDifferences( cat );
        
        return IsInitial( SD, SingleDifference( SD, Pair( minuend, subtrahend ) ) );
        
    end );
    
    ##
    AddDirectProduct( D,
      function( cat, L )
        local H, l, A;
        
        H := UnderlyingCategory( cat );
        
        l := List( L, MinuendAndSubtrahendsInUnderlyingLattice );
        
        return MultipleDifference( cat,
                       Pair( DirectProduct( H, List( l, ms -> ms[1] ) ),
                             Concatenation( List( l, ms -> ms[2] ) ) ) );
        
    end );
    
    ##
    AddIsHomSetInhabited( D,
      function( cat, A, B )
        local msB, S, H, complement_of_minuendB, I;
        
        msB := MinuendAndSubtrahendsInUnderlyingLattice( B );
        
        ## the meet semi-lattice of single differences
        S := UnderlyingCategoryOfSingleDifferences( cat );
        
        H := UnderlyingCategory( cat );
        
        ## the complement -minuendB of the minuend of B as a multiple difference
        complement_of_minuendB := MultipleDifference( cat, Pair( TerminalObject( H ), [ msB[1] ] ) );
        
        I := InitialObject( H );
        
        return IsInitial( cat, DirectProduct( cat, [ A, complement_of_minuendB ] ) ) and ## A ∩ ( -minuendB )
               ForAll( msB[2], s ->
                       IsInitial( cat,
                               DirectProduct( cat,  # A ∩ s
                                       [ A,
                                         MultipleDifference( cat, Pair( s, [ I ] ) ) # s - ∅
                                         ] ) ) );
        
    end );
    
    HandlePrecompiledTowers( D, P, "MeetSemilatticeOfMultipleDifferences" );
    
    Finalize( D );
    
    return D;
    
end );

##
InstallGlobalFunction( AsMultipleDifference,
  function( arg )
    local S, D, A_N;
    
    S := CapCategory( arg[1] );
    
    if not ForAll( arg, IsObjectInMeetSemilatticeOfSingleDifferences ) then
        Error( "not all arguments are formal single differences\n" );
    elif not ForAll( arg{[ 2.. Length( arg ) ]}, d -> IsIdenticalObj( CapCategory( d ), S ) ) then
        Error( "not all arguments lie in the same category\n" );
    fi;
    
    D := MeetSemilatticeOfMultipleDifferences( UnderlyingCategory( S ) );
    
    A_N := DirectProduct( D, List( arg, s -> MultipleDifference( D, Pair( MinuendAndSubtrahendInUnderlyingLattice( s )[1], [ MinuendAndSubtrahendInUnderlyingLattice( s )[2] ] ) ) ) );
    
    Assert( 4, IsWellDefined( A_N ) );
    
    return A_N;
    
end );

##
InstallMethod( \-,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    local ms;
    
    if IsObjectInMeetSemilatticeOfSingleDifferences( B ) or
       IsObjectInMeetSemilatticeOfMultipleDifferences( B ) then
        TryNextMethod( );
    fi;
    
    ms := MinuendAndSubtrahendsInUnderlyingLattice( A );
    
    return MultipleDifference( CapCategory( A ), Pair( ms[1], Concatenation( ms[2], [ B ] ) ) );
    
end );

##
#InstallMethod( \-,
#        "for an object in a meet-semilattice of formal single differences and an object in a thin category",
#        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInThinCategory ],
#        
#  function( A, B )
#    local U;
#    
#    if IsObjectInMeetSemilatticeOfSingleDifferences( B ) or
#       IsObjectInMeetSemilatticeOfMultipleDifferences( B ) then
#        TryNextMethod( );
#    fi;
#    
#    return AsMultipleDifference( A ) - B;
#    
#end );

##
InstallMethod( NormalizedMinuendAndSubtrahendsInUnderlyingLattice,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local ms, L, minuend, subtrahends;
    
    ms := MinuendAndSubtrahendsInUnderlyingLattice( A );
    
    L := CapCategory( ms[1] );
    
    minuend := Iterated( ms[2], { m, s } -> NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebra( L, m, s )[1], ms[1] );
    
    subtrahends := List( ms[2], s -> NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebra( L, minuend, s )[2] );
    
    return Pair( minuend, MaximalObjects( subtrahends, IsHomSetInhabited ) );
    
end );

##
InstallMethod( StandardMinuendAndSubtrahendsInUnderlyingLattice,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local ms;
    
    ms := MinuendAndSubtrahendsInUnderlyingLattice( A );
    
    StandardizeObject( ms[1] );
    List( ms[2], StandardizeObject );
    
    return ms;
    
end );

##
InstallMethod( MinuendAndSubtrahendsInUnderlyingLattice,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  PreMinuendAndSubtrahendsInUnderlyingLattice );

##
InstallMethod( MinuendAndSubtrahendsInUnderlyingLattice,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences and HasNormalizedMinuendAndSubtrahendsInUnderlyingLattice ],
        
  NormalizedMinuendAndSubtrahendsInUnderlyingLattice );

##
InstallMethod( MinuendAndSubtrahendsInUnderlyingLattice,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences and HasStandardMinuendAndSubtrahendsInUnderlyingLattice ],
        
  StandardMinuendAndSubtrahendsInUnderlyingLattice );

##
InstallMethod( EquivalenceToMeetSemilatticeOfDifferences,
        "for a CAP category",
        [ IsCapCategory and IsThinCategory ],
        
  function( P )
    local SD, name, squash;
    
    SD := MeetSemilatticeOfSingleDifferences( P );
    
    name := "Equivalence from the meet-semilattice of formal multiple differences to the meet-semilattice of formal single differences";
    
    squash := CapFunctor( name, MeetSemilatticeOfMultipleDifferences( P ), SD );
    
    AddObjectFunction( squash,
      function( obj )
        local ms;
        
        ms := MinuendAndSubtrahendsInUnderlyingLattice( obj );
        
        return SingleDifference( SD, Pair( ms[1], Coproduct( CapCategory( ms[1] ), ms[2] ) ) );
        
    end );
    
    AddMorphismFunction( squash,
      function( new_source, mor, new_range )
        
        return UniqueMorphism( SD, new_source, new_range );
        
    end );
    
    return squash;
    
end );

##
InstallMethod( AsSingleDifference,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local P, F;
    
    P := UnderlyingCategory( CapCategory( A ) );
    
    F := EquivalenceToMeetSemilatticeOfDifferences( P );
    
    return ApplyFunctor( F, A );
    
end );

##
InstallMethod( NormalizeObject,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    
    NormalizedMinuendAndSubtrahendsInUnderlyingLattice( A );
    
    return A;
    
end );

##
InstallMethod( StandardizeObject,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    
    StandardMinuendAndSubtrahendsInUnderlyingLattice( A );
    
    return A;
    
end );

##
InstallMethod( FactorsAttr,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local D, Ac, facAc, facAp;
    
    D := CapCategory( A );
    
    StandardizeObject( A );
    
    Ac := Closure( A );
    
    facAc := Factors( Ac );
    
    facAp := Concatenation( List( MinuendAndSubtrahendsInUnderlyingLattice( A )[2], Factors ) );
    
    if facAp = [ ] then
        facAp := [ InitialObject( CapCategory( Ac ) ) ];
    fi;
    
    A := List( facAc, T -> MultipleDifference( D, Pair( T, facAp ) ) );
    
    List( A, StandardizeObject );
    
    Perform( A, function( a ) SetFactorsAttr( a, [ a ] ); end );
    
    return A;
    
end );

##
InstallMethod( IsClosedSubobject,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local H, ms;
    
    H := UnderlyingCategory( CapCategory( A ) );
    
    if HasIsCocartesianCoclosedCategory( H ) and IsCocartesianCoclosedCategory( H ) then
        ms := NormalizedMinuendAndSubtrahendsInUnderlyingLattice( A );
        return Length( ms[2] ) = 1 and IsInitial( H, ms[2][1] );
    elif HasIsCartesianClosedCategory( H ) and IsCartesianClosedCategory( H ) then
        ms := NormalizedMinuendAndSubtrahendsInUnderlyingLattice( A );
        return Length( ms[2] ) = 1 and IsTerminal( H, ms[1] );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( Closure,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local H;
    
    H := UnderlyingCategory( CapCategory( A ) );
    
    if HasIsCocartesianCoclosedCategory( H ) and IsCocartesianCoclosedCategory( H ) then
        return NormalizedMinuendAndSubtrahendsInUnderlyingLattice( A )[1];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( A ) then
        TryNextMethod( );
    fi;
    
    return AsMultipleDifference( A ) * B;
    
end );

##
InstallMethod( \*,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInMeetSemilatticeOfSingleDifferences ],

  function( A, B )
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( B ) then
        TryNextMethod( );
    fi;
    
    return A * AsMultipleDifference( B );
    
end );

##
InstallMethod( \=,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( A ) then
        TryNextMethod( );
    fi;
    
    return AsMultipleDifference( A ) = B;
    
end );

##
InstallMethod( \=,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInMeetSemilatticeOfSingleDifferences ],

  function( A, B )
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( B ) then
        TryNextMethod( );
    fi;
    
    return A = AsMultipleDifference( B );
    
end );

##
InstallMethod( \*,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( A ) then
        TryNextMethod( );
    fi;
    
    return ( A - 0 ) * B;
    
end );

##
InstallMethod( \*,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInThinCategory ],

  function( A, B )
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( B ) then
        TryNextMethod( );
    fi;
    
    return A * ( B - 0 );
    
end );

##
InstallMethod( \=,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( A ) then
        TryNextMethod( );
    fi;
    
    return ( A - 0 ) = B;
    
end );

##
InstallMethod( \=,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInThinCategory ],

  function( A, B )
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( B ) then
        TryNextMethod( );
    fi;
    
    return A = ( B - 0 );
    
end );

##
InstallMethod( \.,
        "for an object in a meet-semilattice of formal multiple differences and a positive integer",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsPosInt ],
        
  function( A, string_as_int )
    local name, ms, number;
    
    name := NameRNam( string_as_int );
    
    ms := MinuendAndSubtrahendsInUnderlyingLattice( A );
    
    if name[1] = 'I' then
        return ms[1];
    elif name[1] = 'J' then
        number := name{[ 2 .. Length( name ) ]};
        if IsEmpty( number ) then
            Error( "J must be preceded by a positive number" );
        fi;
        return ms[2][EvalString( number )];
    fi;
    
    Error( "no component with this name available\n" );
    
end );

##
InstallMethod( ViewString,
        "for an object in a meet-semilattice of formal mutliple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local ms, n, str, i, j;
    
    ms := MinuendAndSubtrahendsInUnderlyingLattice( A );
    
    n := ValueOption( "Locales_number" );
    
    if n = fail then
        n := "";
    fi;
    
    str := ViewString( ms[1] : Locales_name := "I", Locales_number := n );
    
    Append( str, " \\\ " );
    
    Append( str, ViewString( ms[2][1] : Locales_name := "J", Locales_number := n, Locales_counter := 1 ) );
    
    j := Length( ms[2] );
    
    if j > 1 then
        
        Append( str, " \\\ " );
        
        if j > 2 then
            Append( str, ".. \\\ " );
        fi;
        
        Append( str, ViewString( ms[2][1] : Locales_name := "J", Locales_number := n, Locales_counter := j ) );
        
    fi;
    
    return str;
    
end );

##
InstallMethod( ViewObj,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    
    Print( ViewString( A ) );
    
end );

##
InstallMethod( String,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  ViewString );

##
InstallMethod( DisplayString,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local ms, str, i;
    
    ms := MinuendAndSubtrahendsInUnderlyingLattice( A );
    
    str := DisplayString( ms[1] );
    
    for i in [ 1 .. Length( ms[2] ) ] do
        Append( str, Concatenation( "\n\n\\ ", DisplayString( ms[2][i] ) ) );
    od;
    
    return str;
    
end );

##
InstallMethod( Display,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    
    Display( DisplayString( A ) );
    
end );
