# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForCategoricalTowers: Tools for CategoricalTowers
#
# Implementations
#

##
InstallGlobalFunction( DigraphOfKnownDoctrines,
  function( )
    local compare, D, doctrines, positions;
    
    compare :=
      function( a, b )
        local bool;
        
        bool := IsSubset( ListOfDefiningOperations( a ), ListOfDefiningOperations( b ) );
        
        if IsBoundGlobal( a ) then
            return ( b in ListImpliedFilters( ValueGlobal( a ) ) ) or bool;
        else
            return bool;
        fi;
        
    end;
    
    D := Digraph( Set( RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD ) ), compare );
    
    doctrines := ShallowCopy( D!.vertexlabels );
    
    positions := List( DigraphStronglyConnectedComponents(D).comps, Last );
    
    D := DigraphReflexiveTransitiveReduction( InducedSubdigraph( D, positions ) );
    
    SetFilterObj( D, IsDigraphOfDoctrines );
    
    return D;
    
end );

##
InstallGlobalFunction( ListKnownDoctrines,
  function( )
    local D;
    
    D := DigraphOfKnownDoctrines( );
    
    return D!.vertexlabels{DigraphTopologicalSort( D )};
    
end );

##
InstallOtherMethod( DotVertexLabelledDigraph,
        "for a digraph of doctirnes",
        [ IsDigraphByOutNeighboursRep and IsDigraphOfDoctrines ],
        
  function( D )
    local str, i, j, out, l;
    
    # Copied from DotVertexLabeledDigraph() at Digraphs/gap/display.gi
    str := "//dot\n";
    
    Append( str, "digraph doctrines{\n" );
    Append( str, "rankdir=LR\n" );
    Append( str, "node [shape=rect fontsize=12]\n" );
    
    for i in DigraphVertices( D ) do
        Append( str, String(i) );
        Append( str, " [label=\"" );
        Append( str, String( DigraphVertexLabel( D, i ) ) );
        Append( str, "\"]\n" );
    od;
    
    out := OutNeighbours(D);
    
    for i in DigraphVertices( D ) do
        l := Length( out[i] );
        for j in [ 1 .. l ] do
            Append( str, Concatenation( String(out[i][j]), " -> ", String(i), "\n" ) );
        od;
    od;
    
    Append( str, "}\n" );
    
    return str;
    
end );

##
InstallMethod( Visualize,
        "for a digraph of doctirnes",
        [ IsDigraphByOutNeighboursRep and IsDigraphOfDoctrines ],
        
  function( D )
    
    Splash( DotVertexLabelledDigraph( D ) );
    
end );

MakeShowable( [ "image/svg+xml" ], IsDigraphByOutNeighboursRep and IsDigraphOfDoctrines );

##
InstallMethod( SvgString,
        "for a digraph of doctirnes",
        [ IsDigraphByOutNeighboursRep and IsDigraphOfDoctrines ],
        
  function( D )
    
    return DotToSVG( DotVertexLabelledDigraph( D ) );
    
end );

##
InstallMethod( ListOfEvaluationNodes,
        "for a cell in a syntactic category",
        [ IsCellInSyntacticCategory ],
        
  function( c )
    local node, nodes, queue, add_to_nodes, add_to_queue, parents, D;
    
    node := c;
    
    nodes := [ ];
    
    queue := [ node ];
    
    add_to_nodes :=
      function( a )
        if PositionProperty( nodes, b -> AreEqualForSyntacticCells( a, b ) ) = fail then
            Add( nodes, a );
        fi;
    end;
    
    add_to_queue :=
      function( a )
        if PositionProperty( Concatenation( nodes, queue ), b -> AreEqualForSyntacticCells( a, b ) ) = fail then
            Add( queue, a );
        fi;
    end;
    
    while not IsEmpty( queue ) do
        
        node := Remove( queue, 1 );
        
        add_to_nodes( node );
        
        if IsList( node ) then
            
            Assert( 0, ForAll( node, IsCellInSyntacticCategory ) );
            
            Perform( node, add_to_queue );
            
        elif not PairOfOperationNameAndArguments( node )[1] in [ "ObjectConstructor", "MorphismConstructor" ] then
            
            parents := PairOfOperationNameAndArguments( node )[2];
            
            parents := Filtered( parents, parent -> IsCellInSyntacticCategory( parent ) or IsList( parent ) );
            
            Perform( parents, add_to_queue );
            
        fi;
        
    od;
    
    nodes := Reversed( nodes );
    
    D := List( nodes, node -> PositionsOfParentsOfASyntacticCell( nodes, node ) );
    
    D := Digraph( D );
    
    return nodes{DigraphTopologicalSort( D )};
    
end );

##
InstallMethod( DigraphOfEvaluation,
        "for a cell in a syntactic category",
        [ IsCellInSyntacticCategory ],

  function( c )
    local nodes, D, func;
    
    nodes := ListOfEvaluationNodes( c );
    
    D := List( nodes, node -> PositionsOfParentsOfASyntacticCell( nodes, node ) );
    
    D := Digraph( D );
    
    D := DigraphReverse( D );
    
    D!.list_of_parents := [ ];
    
    func :=
      function( i )
        local node, datum, l, ints;
        
        node := nodes[i];
        
        if IsList( node ) then
            
            l := Concatenation( String( Length( node ) ), "-[ ... ]" );
            
        else
            
            datum := PairOfOperationNameAndArguments( node );
            
            if not datum[1] in [ "ObjectConstructor", "MorphismConstructor" ] then
                l := datum[1];
                l := CAP_INTERNAL_COMPACT_NAME_OF_CATEGORICAL_OPERATION( l );
                ints := Filtered( datum[2], IsInt );
                if not IsEmpty( ints ) then
                    l := Concatenation( l, "( ", JoinStringsWithSeparator( ints, ", " ), " )" );
                fi;
            elif IsCapCategoryCell( node ) then
                l := "primitive";
                if IsCapCategoryObject( node ) then
                    l := Concatenation( l, "\n", "object" );
                elif IsCapCategoryMorphism( node ) then
                    l := Concatenation( l, "\n", "morphism" );
                fi;
                l := Concatenation( l, "\n<", datum[2][2], ">" );
            fi;
            
        fi;
        
        l := Concatenation( "[", String( i ), "]\n", l );
        
        SetDigraphVertexLabel( D, i, l );
        
        D!.list_of_parents[i] := PositionsOfParentsOfASyntacticCell( nodes, node );
        
    end;
    
    Perform( [ 1 .. Length( nodes ) ], func );
    
    return D;
    
end );

##
InstallOtherMethod( DotVertexLabelledDigraph,
        "for a cell in a syntactic category",
        [ IsCellInSyntacticCategory ],
        
  function( c )
    local D, str, i, j, list_of_parents, parents, l;
    
    D := DigraphOfEvaluation( c );
    
    # Copied from DotVertexLabeledDigraph() at Digraphs/gap/display.gi
    str := "//dot\n";
    
    Append( str, "digraph DigraphOfEvaluation{\n" );
    Append( str, "node [shape=rect]\n" );
    
    for i in DigraphVertices( D ) do
        Append( str, String(i) );
        Append( str, " [label=\"" );
        Append( str, String( DigraphVertexLabel( D, i ) ) );
        Append( str, "\"]\n" );
    od;
    
    list_of_parents := D!.list_of_parents;
    
    for i in DigraphVertices( D ) do
        parents := list_of_parents[i];
        l := Length( parents );
        if l > 1 and Length( Set( parents ) ) > 1 then
            for j in [ 1 .. l ] do
                Append( str, Concatenation( String(parents[j]), " -> ", String(i), " [label=\"", String(j), "\"]\n" ) );
            od;
        else
            for j in [ 1 .. l ] do
                Append( str, Concatenation( String(parents[j]), " -> ", String(i), "\n" ) );
            od;
        fi;
    od;
    
    Append( str, "}\n" );
    
    return str;
    
end );

##
InstallMethod( Visualize,
        "for a cell in a syntactic category",
        [ IsCellInSyntacticCategory ],
        
  function( c )
    
    Splash( DotVertexLabelledDigraph( c ) );
    
end );
