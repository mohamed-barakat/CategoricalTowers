#
# Bialgebroids: Bialgebroids as preadditive categories generated by enhanced quivers
#
# Implementations
#

####################################
#
# representations:
#
####################################

DeclareRepresentation( "IsCapCategoryObjectInAlgebroidRep",
        IsCapCategoryObjectInAlgebroid and
        IsAttributeStoringRep,
        [ ] );

DeclareRepresentation( "IsCapCategoryMorphismInAlgebroidRep",
        IsCapCategoryMorphismInAlgebroid and
        IsAttributeStoringRep,
        [ ] );

####################################
#
# families and types:
#
####################################

# new families:
BindGlobal( "TheFamilyOfObjectsInAlgebroids",
        NewFamily( "TheFamilyOfObjectsInAlgebroids" ) );

BindGlobal( "TheFamilyOfMorphismsInAlgebroids",
        NewFamily( "TheFamilyOfMorphismsInAlgebroids" ) );

# new types:
BindGlobal( "TheTypeObjectInAlgebroid",
        NewType( TheFamilyOfObjectsInAlgebroids,
                IsCapCategoryObjectInAlgebroidRep ) );

BindGlobal( "TheTypeMorphismInAlgebroid",
        NewType( TheFamilyOfMorphismsInAlgebroids,
                IsCapCategoryMorphismInAlgebroidRep ) );

####################################
#
# methods for attributes:
#
####################################

####################################
#
# methods for operations:
#
####################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ALGEBROID,
  
  function( category )
    
    ##
    AddIsWellDefinedForObjects( category,
      function( o )
        
        o := UnderlyingVertex( o );
        
        return IsVertex( o ) and IsIdenticalObj( QuiverOfPath( o ), UnderlyingQuiver( category ) );
        
      end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( m )
        
        m := UnderlyingQuiverAlgebraElement( m );
        
        return IsPath( m ) and IsIdenticalObj( QuiverOfPath( m ), UnderlyingQuiver( category ) );
        
      end );
    
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
        
        return UnderlyingVertex( object_1 ) = UnderlyingVertex( object_2 );
        
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return UnderlyingQuiverAlgebraElement( morphism_1 ) = UnderlyingQuiverAlgebraElement( morphism_2 );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( object )
        local A;
        
        A := UnderlyingQuiverAlgebra( CapCategory( object ) );
        
        return MorphismInAlgebroid(
                       object,
                       A.(String( UnderlyingVertex( object ) ) ),
                       object );
        
    end );
    
    ##
    AddPreCompose( category,
      function( morphism_1, morphism_2 )
        local B, quiver;
        
        B := CapCategory( morphism_1 );
        
        quiver := UnderlyingQuiver( B );
        
        if IsRightQuiver( quiver ) then
            return MorphismInAlgebroid(
                           Source( morphism_1 ),
                           UnderlyingQuiverAlgebraElement( morphism_1 ) * UnderlyingQuiverAlgebraElement( morphism_2 ),
                           Range( morphism_2 ) );
        else
            return MorphismInAlgebroid(
                           Source( morphism_1 ),
                           UnderlyingQuiverAlgebraElement( morphism_2 ) * UnderlyingQuiverAlgebraElement( morphism_1 ),
                           Range( morphism_2 ) );
        fi;
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return MorphismInAlgebroid(
                       Source( morphism_1 ),
                       UnderlyingQuiverAlgebraElement( morphism_1 ) + UnderlyingQuiverAlgebraElement( morphism_2 ),
                       Range( morphism_1 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return MorphismInAlgebroid(
                       Source( morphism ),
                       -UnderlyingQuiverAlgebraElement( morphism ),
                       Range( morphism ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( S, T )
        
        return MorphismInAlgebroid(
                       S,
                       Zero( UnderlyingQuiverAlgebra( CapCategory( S ) ) ),
                       T );
        
    end );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( Algebroid,
        "for a QPA quiver algebra",
        [ IsQuiverAlgebra ],
        
  function( Rq )
    local parity, quiver, A;
    
    if IsRightQuiverAlgebra( Rq ) then
        parity := "right";
    else
        parity := "left";
    fi;
    
    quiver := QuiverOfAlgebra( Rq );
    
    A := Concatenation( "Algebroid generated by the ", parity, " quiver ", String( quiver ) );
    
    A := CreateCapCategory( A );
    
    SetUnderlyingQuiver( A, quiver );
    SetUnderlyingQuiverAlgebra( A, Rq );
    
    A!.Vertices := rec( );
    A!.Arrows := rec( );
    
    return ADD_FUNCTIONS_FOR_ALGEBROID( A );
    
end );

##
InstallMethod( Algebroid,
        "for a homalg ring and a QPA quiver",
        [ IsHomalgRing, IsQuiver ],
        
  function( R, quiver )
    
    return Algebroid( PathAlgebra( R, quiver ) );
    
end );

##
InstallMethod( \.,
        "for an algebroid and a positive integer",
        [ IsCapCategory, IsPosInt ],
        
  function( B, string_as_int )
    local q, name, a, b;
    
    q := UnderlyingQuiver( B );
    
    name := NameRNam( string_as_int );
    
    a := q.(name);
    
    b := rec( );
    
    if IsVertex( a ) then
        if IsBound( B!.Vertices.(name) ) then
            return B!.Vertices.(name);
        fi;
        ObjectifyWithAttributes( b, TheTypeObjectInAlgebroid,
                UnderlyingVertex, a
                );
        B!.Vertices.(name) := b;
    elif IsArrow( a ) then
        if IsBound( B!.Arrows.(name) ) then
            return B!.Arrows.(name);
        fi;
        b := MorphismInAlgebroid(
                     B.(String( Source( a ) ) ),
                     PathAsAlgebraElement( UnderlyingQuiverAlgebra( B ), a ),
                     B.(String( Target( a ) ) ) );
        B!.Arrows.(name) := b;
    else
        Error( "the given component ", name, " is neither a vertex nor an arrow of the quiver q = ", q, "\n" );
    fi;
    
    Add( B, b );
    
    return b;
    
end );

##
InstallMethod( MorphismInAlgebroid,
        "for two objects in an algebroid and an element of the quiver algebra",
        [ IsCapCategoryObjectInAlgebroidRep, IsQuiverAlgebraElement, IsCapCategoryObjectInAlgebroidRep ],
        
  function( S, path, T )
    local l, mor, A;
    
    if not IsZero( path ) then
        
        if not IsUniform( path ) then
            Error( "the path ", path, " is neither zero nor uniform\n" );
        fi;
        
        ## TODO: we are avoiding for the moment the sanity test for
        ## elements of path algebras with relations, this should be
        ## reintroduced in the future
        if IsPathAlgebraElement( path ) then
            l := LeadingPath( path );
            
            if not ( Source( l ) = UnderlyingVertex( S ) and
                     Target( l ) = UnderlyingVertex( T ) ) then
                Error( "the path ", path, " is neither zero nor does it match the given source S or target T\n" );
            fi;
        fi;
        
    fi;
    
    mor := rec( );
    
    A := CapCategory( S );
    
    ObjectifyWithAttributes( mor, TheTypeMorphismInAlgebroid,
            Source, S,
            Range, T,
            UnderlyingQuiverAlgebraElement, path
            );
    
    return mor;
    
end );

##
InstallMethod( Bialgebroid,
        "for a QPA quiver algebra and two records",
        [ IsQuiverAlgebra, IsRecord, IsRecord ],
        
  function( Rq, comult, counit )
    local B, trivial_quiver, R, B0, names_counit, counit_functor,
          names_comult, Rqq, B2, comult_functor;
    
    B := Algebroid( Rq );
    
    B!.Name := Concatenation( "Bia", B!.Name{[ 2 .. Length( B!.Name ) ]} );
    
    if IsRightQuiverAlgebra( Rq ) then
        trivial_quiver := RightQuiver( "*(1)[]" );
    else
        trivial_quiver := LeftQuiver( "*(1)[]" );
    fi;
    
    R := LeftActingDomain( Rq );
    
    B0 := Algebroid( PathAlgebra( R, trivial_quiver ) );
    
    names_counit := NamesOfComponents( counit );
    
    if names_counit = [ ] then
        Error( "the counit record is empty\n" );
    fi;
    
    counit_functor := Concatenation( "counit functor for the ", Name( B ) );
    counit_functor := CapFunctor( counit_functor, B, B0 );
    
    AddObjectFunction( counit_functor,
            function( obj )
              return B0.("1");
            end );
    
    AddMorphismFunction( counit_functor,
            function( new_source, mor, new_range )
              local one;
              one := One( UnderlyingQuiverAlgebra( CapCategory( new_source ) ) );
              mor := UnderlyingQuiverAlgebraElement( mor );
              mor := Paths( mor )[1];
              return MorphismInAlgebroid( new_source, counit.(String( mor )) * one, new_range );
            end );
    
    SetCounit( B, counit_functor );
    
    names_comult := NamesOfComponents( comult );
    
    if names_comult = [ ] then
        Error( "the comultiplication record is empty\n" );
    fi;
    
    Rqq := AlgebraOfElement( comult.(names_comult[1]) );
    
    B2 := Algebroid( Rqq );
    
    comult_functor := Concatenation( "comultiplication functor for the ", Name( B ) );
    comult_functor := CapFunctor( comult_functor, B, B2 );
    
    AddObjectFunction( comult_functor,
            function( obj )
              local name;
              
              name := String( UnderlyingVertex( obj ) );
              return B2.(Concatenation( name, name ));
            end );
    
    AddMorphismFunction( comult_functor,
            function( new_source, mor, new_range )
              mor := UnderlyingQuiverAlgebraElement( mor );
              mor := Paths( mor )[1];
              return MorphismInAlgebroid( new_source, comult.(String( mor )), new_range );
            end );
    
    SetComultiplication( B, comult_functor );
    
    return B;
    
end );

##
InstallMethod( Bialgebroid,
        "for a homalg ring, a QPA quiver, and two records",
        [ IsHomalgRing, IsQuiver, IsRecord, IsRecord ],
        
  function( R, quiver, comult, counit )
    
    return Bialgebroid( PathAlgebra( R, quiver ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for an object in an algebroid",
        [ IsCapCategoryObjectInAlgebroidRep ],

  function( o )
    
    ViewObj( UnderlyingVertex( o ) );
    
end );

##
InstallMethod( ViewObj,
        "for a morphism in an algebroid",
        [ IsCapCategoryMorphismInAlgebroidRep ],

  function( o )
    
    if IsRightQuiverAlgebra( UnderlyingQuiverAlgebra( CapCategory( o ) ) ) then
        ViewObj( Source( o ) );
        Print( "-[" );
        ViewObj( UnderlyingQuiverAlgebraElement( o ) );
        Print( "]->" );
        ViewObj( Range( o ) );
    else
        ViewObj( Range( o ) );
        Print( "<-[" );
        ViewObj( UnderlyingQuiverAlgebraElement( o ) );
        Print( "]-" );
        ViewObj( Source( o ) );
    fi;
    
end );
