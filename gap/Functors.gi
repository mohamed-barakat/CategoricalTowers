# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Implementations
#

##
InstallMethod( IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid,
          [ IsQuiverRowsCategory, IsAdditiveClosureCategory ],
  function( QRowsA, additive_closure )
    local ring_QRowsA, ring_additive_closure, is_rationals, is_integers, algebroid, name, F;
      
    ring_QRowsA := CommutativeRingOfLinearCategory( QRowsA );
    
    ring_additive_closure := CommutativeRingOfLinearCategory( additive_closure );
    
    is_rationals := k -> IsRationals( k ) or ( HasIsRationalsForHomalg( k ) and IsRationalsForHomalg( k ) );
    
    is_integers := z -> IsIntegers( z ) or ( HasIsIntegersForHomalg( z ) and IsIntegersForHomalg( z ) );
   
    if not (
             ( is_rationals( ring_QRowsA ) and is_rationals( ring_additive_closure ) )
             or
             ( is_integers( ring_QRowsA ) and is_integers( ring_additive_closure ) )
             or
             IsIdenticalObj( ring_QRowsA, ring_additive_closure )
           ) then
      
      Error( "Both categories should be linear over the same ring!\n" );
      
    fi;
    
    algebroid := UnderlyingCategory( additive_closure );
        
    name := "Isomorphism functor from quiver rows category to additive closure of an algebroid";
    
    F := CapFunctor( name, QRowsA, additive_closure );
    
    AddObjectFunction( F,
      function( a )
        local vertices;
        
        vertices := ListOfQuiverVertices( a );
        
        vertices := List( vertices, v -> [ ObjectInAlgebroid( algebroid, v[ 1 ] ), v[ 2 ] ] );
        
        vertices := Concatenation(
                      List( vertices, v -> ListWithIdenticalEntries( v[ 2 ], v[ 1 ] ) )
                    );
                    
        return AdditiveClosureObject( vertices, additive_closure );
        
    end );
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        local objects, matrix;
        
        objects := List( ObjectList( s ), vertex -> Cartesian( [ vertex ], ObjectList( r ) ) );
        
        matrix := MorphismMatrix( alpha );
        
        if IsEmpty( matrix ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          matrix := ListN( objects, matrix,
                      { o, m } -> ListN( o, m,
                        { v, e } -> MorphismInAlgebroid( v[ 1 ], e, v[ 2 ] ) )
                          );
                          
          return AdditiveClosureMorphism( s, matrix, r );
          
        fi;
        
    end );
    
    return F;
    
end );

##
InstallMethod( IsomorphismFromAdditiveClosureOfAlgebroidIntoQuiverRows,
          [ IsAdditiveClosureCategory, IsQuiverRowsCategory ],
  function( additive_closure, QRowsA )
    local ring_QRowsA, ring_additive_closure, is_rationals, is_integers, algebroid, name, F;
    
    ring_QRowsA := CommutativeRingOfLinearCategory( QRowsA );
    
    ring_additive_closure := CommutativeRingOfLinearCategory( additive_closure );
    
    is_rationals := k -> IsRationals( k ) or ( HasIsRationalsForHomalg( k ) and IsRationalsForHomalg( k ) );
    
    is_integers := z -> IsIntegers( z ) or ( HasIsIntegersForHomalg( z ) and IsIntegersForHomalg( z ) );
    
    if not (
             ( is_rationals( ring_QRowsA ) and is_rationals( ring_additive_closure ) )
             or
             ( is_integers( ring_QRowsA ) and is_integers( ring_additive_closure ) )
             or
             IsIdenticalObj( ring_QRowsA, ring_additive_closure )
           ) then
           
      Error( "Both categories should be linear over the same ring!\n" );
      
    fi;
   
    algebroid := UnderlyingCategory( additive_closure );
     
    name := "Isomorphism functor from additive closure of an algebroid to quiver rows category";
    
    F := CapFunctor( name, additive_closure, QRowsA );
     
    AddObjectFunction( F,
      function( a )
        local vertices;
        
        vertices := List( ObjectList( a ), o -> [ UnderlyingVertex( o ), 1 ] );
        
        return QuiverRowsObject( vertices, QRowsA );
        
    end );
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        local matrix;
        
        matrix := MorphismMatrix( alpha );
        
        matrix := List( matrix, row -> List( row, UnderlyingQuiverAlgebraElement ) );
        
        return QuiverRowsMorphism( s, matrix, r );
        
    end );
    
    return F;

end );

##
InstallMethod( IsomorphismFromQuiverRows,
          [ IsAdditiveClosureCategory ],
  function( additive_closure )
    local algebroid, A, ring, QRowsA;
    
    algebroid := UnderlyingCategory( additive_closure );
    
    if not IsAlgebroid( algebroid ) then
      
      Error( "The argument should be an additive closure of some algebroid!\n" );
      
    fi;
    
    A := UnderlyingQuiverAlgebra( algebroid );
    
    ring := CommutativeRingOfLinearCategory( additive_closure );
    
    if IsIntegers( ring ) or ( HasIsIntegersForHomalg( ring ) and IsIntegersForHomalg( ring ) ) then
      
      QRowsA := QuiverRows( A, true );
      
      return IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( QRowsA, additive_closure );
      
    else
      
      QRowsA := QuiverRows( A );
      
      return IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( QRowsA, additive_closure );
      
    fi;
    
end );

##
InstallMethod( IsomorphismOntoQuiverRows,
          [ IsAdditiveClosureCategory ],
  function( additive_closure )
    local algebroid, A, ring, QRowsA;
    
    algebroid := UnderlyingCategory( additive_closure );
    
    if not IsAlgebroid( algebroid ) then
      
      Error( "The argument should be an additive closure of some algebroid!\n" );
      
    fi;
    
    A := UnderlyingQuiverAlgebra( algebroid );
    
    ring := CommutativeRingOfLinearCategory( additive_closure );
    
    if IsIntegers( ring ) or ( HasIsIntegersForHomalg( ring ) and IsIntegersForHomalg( ring ) ) then
      
      QRowsA := QuiverRows( A, true );
      
      return IsomorphismFromAdditiveClosureOfAlgebroidIntoQuiverRows( additive_closure, QRowsA );
      
    else
      
      QRowsA := QuiverRows( A );
      
      return IsomorphismFromAdditiveClosureOfAlgebroidIntoQuiverRows( additive_closure, QRowsA );
      
    fi;
    
end );

##
InstallMethod( IsomorphismFromAdditiveClosureOfAlgebroid,
          [ IsQuiverRowsCategory ],
  function( QRowsA )
    local A, ring, additive_closure;
    
    A := UnderlyingQuiverAlgebra( QRowsA );
    
    ring := CommutativeRingOfLinearCategory( QRowsA );
    
    if IsIntegers( ring ) or ( HasIsIntegersForHomalg( ring ) and IsIntegersForHomalg( ring ) ) then
      
      additive_closure := AdditiveClosure( Algebroid( A, true ) );
      
      return IsomorphismFromAdditiveClosureOfAlgebroidIntoQuiverRows( additive_closure, QRowsA );
      
    else
      
      additive_closure := AdditiveClosure( Algebroid( A ) );
      
      return IsomorphismFromAdditiveClosureOfAlgebroidIntoQuiverRows( additive_closure, QRowsA );
      
    fi;
    
end );

##
InstallMethod( IsomorphismOntoAdditiveClosureOfAlgebroid,
          [ IsQuiverRowsCategory ],
  function( QRowsA )
    local A, ring, additive_closure;
    
    A := UnderlyingQuiverAlgebra( QRowsA );
    
    ring := CommutativeRingOfLinearCategory( QRowsA );
    
    if IsIntegers( ring ) or ( HasIsIntegersForHomalg( ring ) and IsIntegersForHomalg( ring ) ) then
      
      additive_closure := AdditiveClosure( Algebroid( A, true ) );
      
      return IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( QRowsA, additive_closure );
      
    else
      
      additive_closure := AdditiveClosure( Algebroid( A ) );
      
      return IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( QRowsA, additive_closure );
      
    fi;
    
end );

##
InstallMethod( ProjectionFromAlgebroidOfPathAlgebra,
          [ IsAlgebroid ],
  function( algebroid )
    local A, kQ, path_algebroid, F;
    
    A := UnderlyingQuiverAlgebra( algebroid );
    
    kQ := PathAlgebra( A );
    
    if IsIdenticalObj( A, kQ ) then
      
      return IdentityFunctor( algebroid );
      
    fi;
    
    path_algebroid := Algebroid( kQ );
    
    F := CapFunctor( "Projection functor", path_algebroid, algebroid );
    
    AddObjectFunction( F,
      o -> ObjectInAlgebroid( algebroid, UnderlyingVertex( o ) )
    );
    
    AddMorphismFunction( F,
      { s, m, r } -> MorphismInAlgebroid(
                        s,
                        QuotientOfPathAlgebraElement(
                            A,
                            UnderlyingQuiverAlgebraElement( m )
                          ),
                        r
                      )
    );
    
    return F;
    
end );

