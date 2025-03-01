# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForCategoricalTowers: Tools for CategoricalTowers
#
# Implementations
#

##
InstallMethod( IsEqualForSyntacticCells,
        "for two syntactic categories",
        [ IsSyntacticCategory, IsSyntacticCategory ],

  IsIdenticalObj );

##
InstallMethod( IsEqualForSyntacticCells,
        "for two CAP objects",
        [ IsCapCategoryObject, IsCapCategoryObject ],

  function( obj1, obj2 )
    
    return IsIdenticalObj( obj1, obj2 ) or IsEqualForSyntacticCells( ObjectDatum( obj1 ), ObjectDatum( obj2 ) );
    
end );

##
InstallMethod( IsEqualForSyntacticCells,
        "for two CAP morphisms",
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

  function( obj1, obj2 )
    
    return IsIdenticalObj( obj1, obj2 ) or IsEqualForSyntacticCells( MorphismDatum( obj1 ), MorphismDatum( obj2 ) );
    
end );

##
InstallMethod( IsEqualForSyntacticCells,
        "for two lists",
        [ IsList, IsList ],

  function( L1, L2 )
    local l;

    l := Length( L1 );
    
    return l = Length( L2 ) and
           ForAll( [ 1 .. l ], i -> IsEqualForSyntacticCells( L1[i], L2[i] ) );
    
end );

##
InstallMethod( IsEqualForSyntacticCells,
        "for two strings",
        [ IsStringRep, IsStringRep ],

  \= );

##
InstallMethod( IsEqualForSyntacticCells,
        "for two ring elements",
        [ IsRingElement, IsRingElement ],
        
  \= );

##
InstallGlobalFunction( AreEqualForSyntacticCells,
  function( a, b )
    local length;
    
    if IsList( a ) and not IsList( b ) then
        return false;
    elif not IsList( a ) and IsList( b ) then
        return false;
    elif IsList( a ) and IsList( b ) then
        length := Length( a );
        if not length = Length( b ) then
            return false;
        fi;
        return ForAll( [ 1 .. length ], i -> AreEqualForSyntacticCells( a[i], b[i] ) );
    elif not IsIdenticalObj( CapCategory( a ), CapCategory( b ) ) then
        return false;
    elif not ( ( IsCapCategoryObject( a ) and IsCapCategoryObject( b ) ) or ( IsCapCategoryMorphism( a ) and IsCapCategoryMorphism( b ) ) ) then
        return false;
    fi;
    
    return IsEqualForSyntacticCells( a, b );
    
end );

##
InstallMethod( SyntacticCategory,
        "for a record of options",
        [ IsRecord ],
        
  FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, options )
    local list_of_operations_to_install, skip, operation_name, pos, category_constructor_options, C;
    
    list_of_operations_to_install := ShallowCopy( options.list_of_operations_to_install );
    
    skip := [ "IsEqualForObjects",
              "IsEqualForMorphisms" ];
    
    for operation_name in skip do
        pos := Position( list_of_operations_to_install, operation_name );
        if IsInt( pos ) then
            Remove( list_of_operations_to_install, pos );
        fi;
    od;
    
    options.list_of_operations_to_install := list_of_operations_to_install;
    
    category_constructor_options := ShallowCopy( options );
    category_constructor_options.category_filter := IsSyntacticCategory;
    category_constructor_options.category_object_filter := IsObjectInSyntacticCategory;
    category_constructor_options.category_morphism_filter := IsMorphismInSyntacticCategory;
    category_constructor_options.is_computable := "IsCongruentForMorphisms" in options.list_of_operations_to_install;
    category_constructor_options.supports_empty_limits := true;
    
    if "ObjectConstructor" in options.list_of_operations_to_install then
        
        category_constructor_options.object_constructor := function ( cat, object_datum )
            
            Assert( 0, IsList( object_datum ) and Length( object_datum ) = 2 and IsStringRep( object_datum[1] ) and IsList( object_datum[2] ) );
            
            return CreateCapCategoryObjectWithAttributes( cat,
                           PairOfOperationNameAndArguments, object_datum );
            
        end;
        
    fi;
    
    if "MorphismConstructor" in options.list_of_operations_to_install then
        
        category_constructor_options.morphism_constructor := function ( cat, source, morphism_datum, range )
            
            Assert( 0, IsList( morphism_datum ) and Length( morphism_datum ) = 2 and IsStringRep( morphism_datum[1] ) and IsList( morphism_datum[2] ) );
            
            return CreateCapCategoryMorphismWithAttributes( cat,
                           source,
                           range,
                           PairOfOperationNameAndArguments, morphism_datum );
            
        end;
        
    fi;
    
    if "ObjectDatum" in options.list_of_operations_to_install then
        
        category_constructor_options.object_datum := function ( cat, object )
            
            return PairOfOperationNameAndArguments( object );
            
        end;
        
    fi;
    
    if "MorphismDatum" in options.list_of_operations_to_install then
        
        category_constructor_options.morphism_datum := function ( cat, morphism )
            
            return PairOfOperationNameAndArguments( morphism );
            
        end;
        
    fi;
    
    category_constructor_options.create_func_bool :=
      function( name, cat )
        
        return Pair( """
          function ( input_arguments... )
            
            Error( "this is a syntactic category without actual implementation for boolean operations" );
            
          end
          """, 1 );
          
        end;
    
    category_constructor_options.create_func_object :=
      function( name, cat )
            
            return Pair( """
                function( input_arguments... )
                  local args, pair_of_op_name_and_args;
                  
                  args := [ input_arguments... ];
                  
                  pair_of_op_name_and_args := Pair( "operation_name", args{[ 2 .. Length( args ) ]} );
                  
                  return top_object_getter( cat, pair_of_op_name_and_args );
                  
                end
            """, 1 );
            
        end;
    
    category_constructor_options.create_func_morphism :=
      function( name, cat )
            
            return Pair( """
                function( input_arguments... )
                  local args, pair_of_op_name_and_args;
                  
                  args := [ input_arguments... ];
                  
                  pair_of_op_name_and_args := Pair( "operation_name", args{[ 2 .. Length( args ) ]} );
                  
                  return top_morphism_getter( cat, top_source, pair_of_op_name_and_args, top_range );
                  
                end
            """, 1 );
            
        end;
    
    category_constructor_options.top_object_getter_string := "ObjectConstructor";
    category_constructor_options.top_morphism_getter_string := "MorphismConstructor";
    
    C := CategoryConstructor( category_constructor_options );
    
    AddIsEqualForObjects( C,
      function( cat, obj1, obj2 )
        
        return AreEqualForSyntacticCells( obj1, obj2 );
        
    end );
    
    AddIsEqualForMorphisms( C,
      function( cat, mor1, mor2 )
        
        return AreEqualForSyntacticCells( mor1, mor2 );
        
    end );
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        Finalize( C );
        
    fi;
    
    for operation_name in options.list_of_operations_to_install do
        
        if not CanCompute( C, operation_name ) then
            
            Print( "WARNING: The synactic category cannot compute ", operation_name, ", probably because the operation is not supported by CategoryConstructor yet.\n" );
            
        fi;
        
    od;
    
    return C;
    
end ) );

##
InstallMethod( \/,
        "for a string and a syntactic category",
        [ IsStringRep, IsSyntacticCategory ],
        
  function( object_name, syntactic_cat )
    
    return Pair( "ObjectConstructor", [ object_name ] ) / syntactic_cat;
    
end );

##
InstallMethod( \.,
        "for a syntactic category and a positive integer",
        [ IsSyntacticCategory, IsPosInt ],
        
  function( syntactic_cat, string_as_int )
    local name, q, cell;
    
    name := NameRNam( string_as_int );
    
    q := syntactic_cat!.underlying_quiver;
    
    cell := q.(name);
    
    if IsCapCategoryMorphism( cell ) then
        
        return MorphismConstructor( syntactic_cat,
                       syntactic_cat.(ValueGlobal( "ObjectLabel" )( Source( cell ) )),
                       Pair( "MorphismConstructor", [ name ] ),
                       syntactic_cat.(ValueGlobal( "ObjectLabel" )( Target( cell ) )) );
        
    fi;
    
    return name / syntactic_cat;
    
end );

##
InstallMethod( PositionsOfParentsOfASyntacticCell,
        [ IsList, IsCellInSyntacticCategory ],
        
  function( nodes, node )
    local parents;
    
    if PairOfOperationNameAndArguments( node )[1] in [ "ObjectConstructor", "MorphismConstructor" ] then
        return [ ];
    fi;
    
    parents := PairOfOperationNameAndArguments( node )[2];
    
    parents := Filtered( parents, parent -> IsCellInSyntacticCategory( parent ) or IsList( parent ) );
    
    return List( parents, parent -> PositionProperty( nodes, a -> AreEqualForSyntacticCells( parent, a ) ) );
    
end );

##
InstallMethod( PositionsOfParentsOfASyntacticCell,
        [ IsList, IsList ],
        
  function( nodes, node )
    
    return List( node, parent -> PositionProperty( nodes, a -> AreEqualForSyntacticCells( parent, a ) ) );
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( String,
        "for an object in a syntactic category",
        [ IsObjectInSyntacticCategory ],
        
  function( a )
    local cat_name, datum;
    
    cat_name := Name( CapCategory( a ) );
    
    datum := ObjectDatum( a );
    
    if datum[1] = "ObjectConstructor" then
        
        return Concatenation( datum[1], "( ",
                       cat_name, ", Pair( \"ObjectConstructor\", [ \"", datum[2][1], "\" ] ) )" );
        
    elif IsEmpty( datum[2] ) then
        
        return Concatenation( datum[1], "( ", cat_name, " )" );
        
    fi;
    
    return Concatenation( datum[1], "( ", cat_name, ", ", JoinStringsWithSeparator( List( datum[2], String ), ", " ), " )" );
    
end );

##
InstallMethod( String,
        "for an morphism in a syntactic category",
        [ IsMorphismInSyntacticCategory ],
        
  function( phi )
    local cat_name, datum;
    
    cat_name := Name( CapCategory( phi ) );
    
    datum := MorphismDatum( phi );
    
    if datum[1] = "MorphismConstructor" then
        
        return Concatenation( datum[1], "( ",
                       cat_name, ", ",
                       String( Source( phi ) ), ", Pair( \"MorphismConstructor\", [ \"",
                       datum[2][1], "\" ] ), ",
                       String( Target( phi ) ), " )" );
        
    fi;
    
    return Concatenation( datum[1], "( ",
                   cat_name, ", ",
                   JoinStringsWithSeparator( List( datum[2], String ), ", " ), " )" );
    
end );

##
InstallMethod( DisplayString,
        "for an object in a syntactic category",
        [ IsObjectInSyntacticCategory ],
        
  function( a )
    
    return Concatenation( String( a ), "\n" );
    
end );

##
InstallMethod( DisplayString,
        "for a morphism in a syntactic category",
        [ IsMorphismInSyntacticCategory ],
        
  function( phi )
    
    return Concatenation( String( phi ), "\n" );
    
end );
