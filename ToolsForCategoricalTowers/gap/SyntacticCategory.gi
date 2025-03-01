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
    elif ( IsCapCategoryCell( a ) and not IsCapCategoryCell( b ) ) or ( not IsCapCategoryCell( a ) and IsCapCategoryCell( b ) ) then
        return false;
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
  [ [ "FinalizeCategory", true ],
    [ "quiver", fail, ],
    [ "category", fail, ],
    [ "optimize", 1 ],
  ],
  function( CAP_NAMED_ARGUMENTS, options )
    local list_of_operations_to_install, operation_name, category_constructor_options, syntactic_cat;
    
    list_of_operations_to_install := ShallowCopy( options.list_of_operations_to_install );
    
    options.list_of_operations_to_install := list_of_operations_to_install;
    
    category_constructor_options := ShallowCopy( options );
    category_constructor_options.category_filter := IsSyntacticCategory;
    category_constructor_options.category_object_filter := IsObjectInSyntacticCategory;
    category_constructor_options.category_morphism_filter := IsMorphismInSyntacticCategory;
    category_constructor_options.is_computable := true;
    category_constructor_options.supports_empty_limits := true;
    
    if "ObjectConstructor" in options.list_of_operations_to_install then
        
        category_constructor_options.object_constructor := function ( cat, object_datum )
            
            Assert( 0,
                    IsList( object_datum ) and Length( object_datum ) = 2 and IsStringRep( object_datum[1] ) and
                    IsList( object_datum[2] ) and not IsEmpty( object_datum[2] ) and IsSyntacticCategory(  object_datum[2][1] ) );
            
            return CreateCapCategoryObjectWithAttributes( cat,
                           PairOfOperationNameAndArguments, object_datum );
            
        end;
        
    fi;
    
    if "MorphismConstructor" in options.list_of_operations_to_install then
        
        category_constructor_options.morphism_constructor := function ( cat, source, morphism_datum, target )
            
            Assert( 0, IsList( morphism_datum ) and Length( morphism_datum ) = 2 and IsStringRep( morphism_datum[1] ) and IsList( morphism_datum[2] ) );
            
            return CreateCapCategoryMorphismWithAttributes( cat,
                           source,
                           target,
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
            
            Error( "this is a syntactic category without actual implementation for boolean operations\n" );
            
          end
          """, 100 );
          
        end;
    
    category_constructor_options.create_func_object :=
      function( name, cat )
            
            return Pair( """
                function( input_arguments... )
                  local args, pair_of_op_name_and_args;
                  
                  args := [ input_arguments... ];
                  
                  pair_of_op_name_and_args := Pair( "operation_name", args );
                  
                  return top_object_getter( cat, pair_of_op_name_and_args );
                  
                end
            """, 100 );
            
        end;
    
    category_constructor_options.create_func_morphism :=
      function( name, cat )
            
            return Pair( """
                function( input_arguments... )
                  local args, pair_of_op_name_and_args;
                  
                  args := [ input_arguments... ];
                  
                  pair_of_op_name_and_args := Pair( "operation_name", args );
                  
                  return top_morphism_getter( cat, top_source, pair_of_op_name_and_args, top_range );
                  
                end
            """, 100 );
            
        end;
    
    category_constructor_options.top_object_getter_string := "ObjectConstructor";
    category_constructor_options.top_morphism_getter_string := "MorphismConstructor";
    
    syntactic_cat := CategoryConstructor( category_constructor_options );
    
    if not CAP_NAMED_ARGUMENTS.quiver = fail then
        SetUnderlyingQuiver( syntactic_cat, CAP_NAMED_ARGUMENTS.quiver );
    fi;
    
    if not CAP_NAMED_ARGUMENTS.category = fail then
        SetUnderlyingCategory( syntactic_cat, CAP_NAMED_ARGUMENTS.category );
        if HasUnderlyingQuiver( CAP_NAMED_ARGUMENTS.category ) then
            SetUnderlyingQuiver( syntactic_cat, UnderlyingQuiver( CAP_NAMED_ARGUMENTS.category ) );
            Assert( 0, IsIdenticalObj( UnderlyingQuiver( syntactic_cat ), UnderlyingQuiver( CAP_NAMED_ARGUMENTS.category ) ) );
        fi;
    fi;
    
    AddIsEqualForObjects( syntactic_cat,
      function( syntactic_cat, obj1, obj2 )
        
        return AreEqualForSyntacticCells( obj1, obj2 );
        
    end, 50 );
    
    AddIsEqualForMorphisms( syntactic_cat,
      function( syntactic_cat, mor1, mor2 )
        
        return AreEqualForSyntacticCells( mor1, mor2 );
        
    end, 50 );
    
    AddIsCongruentForMorphisms( syntactic_cat,
      function( syntactic_cat, mor1, mor2 )
        local bool;
        
        bool := IsEqualForMorphisms( syntactic_cat, mor1, mor2 );
        
        if bool then
            return true;
        fi;
        
        Error( "this is a syntactic category without actual implementation for boolean operations\n" );
        
    end, OperationWeight( syntactic_cat, "IsEqualForMorphisms" ) );
    
    if CAP_NAMED_ARGUMENTS.optimize >= 1 then
        
        if "PreCompose" in list_of_operations_to_install then
            
            AddPreCompose( syntactic_cat,
              function( syntactic_cat, pre_mor, post_mor )
                local l, pre_datum, post_datum, k;
                
                if CanCompute( syntactic_cat, "IsEqualToIdentityMorphism" ) then
                    
                    if IsEqualToIdentityMorphism( syntactic_cat, pre_mor ) then
                        
                        return post_mor;
                        
                    elif IsEqualToIdentityMorphism( syntactic_cat, post_mor ) then
                        
                        return pre_mor;
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, pre_mor ) or IsEqualToZeroMorphism( syntactic_cat, post_mor ) then
                        
                        return ZeroMorphism( syntactic_cat, Source( pre_mor ), Target( post_mor ) );
                        
                    fi;
                    
                fi;
                
                if PairOfOperationNameAndArguments( pre_mor )[1] = "UniversalMorphismIntoDirectSumWithGivenDirectSum" and
                   PairOfOperationNameAndArguments( post_mor )[1] = "UniversalMorphismFromDirectSumWithGivenDirectSum" and
                   AreEqualForSyntacticCells( PairOfOperationNameAndArguments( pre_mor )[2][2], PairOfOperationNameAndArguments( post_mor )[2][2] ) and
                   CanCompute( syntactic_cat, "SumOfMorphisms" ) then
                    
                    pre_datum := PairOfOperationNameAndArguments( pre_mor )[2];
                    post_datum := PairOfOperationNameAndArguments( post_mor )[2];
                    
                    l := Length( pre_datum[4] );
                    
                    Assert( 0, l = Length( post_datum[4] ) );
                    
                    return SumOfMorphisms( syntactic_cat,
                                   pre_datum[3],
                                   ListN( pre_datum[4], post_datum[4], { pre, post } -> PreCompose( syntactic_cat, pre, post ) ),
                                   post_datum[3] );
                    
                fi;
                
                if PairOfOperationNameAndArguments( pre_mor )[1] = "InjectionOfCofactorOfDirectSumWithGivenDirectSum" and
                   PairOfOperationNameAndArguments( post_mor )[1] = "UniversalMorphismFromDirectSumWithGivenDirectSum" and
                   AreEqualForSyntacticCells( PairOfOperationNameAndArguments( pre_mor )[2][2], PairOfOperationNameAndArguments( post_mor )[2][2] ) then
                    
                    k := PairOfOperationNameAndArguments( pre_mor )[2][3];
                    
                    return PairOfOperationNameAndArguments( post_mor )[2][4][k];
                    
                fi;
                
                if PairOfOperationNameAndArguments( pre_mor )[1] = "UniversalMorphismIntoDirectSumWithGivenDirectSum" and
                   PairOfOperationNameAndArguments( post_mor )[1] = "ProjectionInFactorOfDirectSumWithGivenDirectSum" and
                   AreEqualForSyntacticCells( PairOfOperationNameAndArguments( pre_mor )[2][2], PairOfOperationNameAndArguments( post_mor )[2][2] ) then
                    
                    k := PairOfOperationNameAndArguments( post_mor )[2][3];
                    
                    return PairOfOperationNameAndArguments( pre_mor )[2][4][k];
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               Source( pre_mor ),
                               Pair( "PreCompose", [ syntactic_cat, pre_mor, post_mor ] ),
                               Target( post_mor ) );
                
            end, 50 );
            
        fi;
        
        if "AdditionForMorphisms" in list_of_operations_to_install then
            
            AddAdditionForMorphisms( syntactic_cat,
              function( syntactic_cat, mor1, mor2 )
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, mor1 ) then
                        
                        return mor2;
                        
                    elif IsEqualToZeroMorphism( syntactic_cat, mor2 ) then
                        
                        return mor1;
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               Source( mor1 ),
                               Pair( "AdditionForMorphisms", [ syntactic_cat, mor1, mor2 ] ),
                               Target( mor1 ) );
                
            end, 50 );
            
        fi;
        
        if "MultiplyWithElementOfCommutativeRingForMorphisms" in list_of_operations_to_install then
            
            AddMultiplyWithElementOfCommutativeRingForMorphisms( syntactic_cat,
              function( syntactic_cat, r, mor )
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, mor ) then
                        
                        return mor;
                        
                    fi;
                    
                fi;
                
                if IsOne( r ) then
                    
                    return mor;
                    
                elif IsBound( IsMinusOne ) and ValueGlobal( "IsMinusOne" )( r ) then
                    
                    return AdditiveInverseForMorphisms( mor );
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               Source( mor ),
                               Pair( "MultiplyWithElementOfCommutativeRingForMorphisms", [ syntactic_cat, r, mor ] ),
                               Target( mor ) );
                
            end, 50 );
            
        fi;
        
        if "DirectSum" in list_of_operations_to_install then
            
            AddDirectSum( syntactic_cat,
              function( syntactic_cat, D )
                local l, zero, nonzero;
                
                l := Length( D );
                
                if l = 0 and CanCompute( syntactic_cat, "ZeroObject" ) then
                    
                    return ZeroObject( syntactic_cat );
                    
                elif l = 1 then
                    
                    return D[1];
                    
                elif CanCompute( syntactic_cat, "ZeroObject" ) then
                    
                    zero := ZeroObject( syntactic_cat );
                    
                    ## do not use IsZeroForObjects since it delegates to IsCongruentForMorphisms, and hence nonsyntactic
                    nonzero := PositionsProperty( D, obj -> not IsEqualForObjects( syntactic_cat, obj, zero ) );
                    
                    if Length( nonzero ) < l then
                        
                        return DirectSum( syntactic_cat, D{nonzero} );
                        
                    fi;
                    
                fi;
                
                return ObjectConstructor( syntactic_cat,
                               Pair( "DirectSum", [ syntactic_cat, D ] ) );
                
            end, 50 );
            
        fi;
        
        if "ProjectionInFactorOfDirectSumWithGivenDirectSum" in list_of_operations_to_install then
            
            AddProjectionInFactorOfDirectSumWithGivenDirectSum( syntactic_cat,
              function( syntactic_cat, D, k, S )
                local l, zero, nonzero, p;
                
                l := Length( D );
                
                if l = 1 and CanCompute( syntactic_cat, "IdentityMorphism" ) then
                    
                    Assert( 0, k = 1 );
                    
                    return IdentityMorphism( syntactic_cat, S );
                    
                elif l > 1 and CanCompute( syntactic_cat, "ZeroObject" ) and CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    zero := ZeroObject( syntactic_cat );
                    
                    ## do not use IsZeroForObjects since it delegates to IsCongruentForMorphisms, and hence nonsyntactic
                    nonzero := PositionsProperty( D, obj -> not IsEqualForObjects( syntactic_cat, obj, zero ) );
                    
                    if Length( nonzero ) < l then
                        
                        p := Position( nonzero, k );
                        
                        if IsInt( p ) then
                            
                            return ProjectionInFactorOfDirectSumWithGivenDirectSum( syntactic_cat,
                                           D{nonzero},
                                           p,
                                           S );
                            
                        fi;
                        
                        return ZeroMorphism( syntactic_cat, S, D[k] );
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               S,
                               Pair( "ProjectionInFactorOfDirectSumWithGivenDirectSum", [ syntactic_cat, D, k, S ] ),
                               D[k] );
                
            end, 50 );
            
        fi;
        
        if "InjectionOfCofactorOfDirectSumWithGivenDirectSum" in list_of_operations_to_install then
            
            AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( syntactic_cat,
              function( syntactic_cat, D, k, S )
                local l, zero, nonzero, p;
                
                l := Length( D );
                
                if l = 1 and CanCompute( syntactic_cat, "IdentityMorphism" ) then
                    
                    Assert( 0, k = 1 );
                    
                    return IdentityMorphism( syntactic_cat, S );
                    
                elif l > 1 and CanCompute( syntactic_cat, "ZeroObject" ) and CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    zero := ZeroObject( syntactic_cat );
                    
                    ## do not use IsZeroForObjects since it delegates to IsCongruentForMorphisms, and hence nonsyntactic
                    nonzero := PositionsProperty( D, obj -> not IsEqualForObjects( syntactic_cat, obj, zero ) );
                    
                    if Length( nonzero ) < l then
                        
                        p := Position( nonzero, k );
                        
                        if IsInt( p ) then
                            
                            return InjectionOfCofactorOfDirectSumWithGivenDirectSum( syntactic_cat,
                                           D{nonzero},
                                           p,
                                           S );
                            
                        fi;
                        
                        return ZeroMorphism( syntactic_cat, D[k], S );
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               D[k],
                               Pair( "InjectionOfCofactorOfDirectSumWithGivenDirectSum", [ syntactic_cat, D, k, S ] ),
                               S );
                
            end, 50 );
            
        fi;
        
        if "UniversalMorphismIntoDirectSumWithGivenDirectSum" in list_of_operations_to_install then
            
            AddUniversalMorphismIntoDirectSumWithGivenDirectSum( syntactic_cat,
              function( syntactic_cat, D, T, tau, S )
                local l, zero, nonzero;
                
                l := Length( D );
                
                if l = 0 and CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    return ZeroMorphism( syntactic_cat, T, S );
                    
                elif l = 1 then
                    
                    Assert( 0, Length( tau ) = 1 );
                    
                    return tau[1];
                    
                elif CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) and ForAll( tau, mor -> IsEqualToZeroMorphism( syntactic_cat, mor ) ) and
                  CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    return ZeroMorphism( syntactic_cat, T, S );
                    
                elif CanCompute( syntactic_cat, "ZeroObject" ) and CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    zero := ZeroObject( syntactic_cat );
                    
                    ## do not use IsZeroForObjects since it delegates to IsCongruentForMorphisms, and hence nonsyntactic
                    nonzero := PositionsProperty( D, obj -> not IsEqualForObjects( syntactic_cat, obj, zero ) );
                    
                    if Length( nonzero ) < l then
                        
                        return UniversalMorphismIntoDirectSumWithGivenDirectSum( syntactic_cat,
                                       D{nonzero},
                                       T,
                                       tau{nonzero},
                                       S );
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               T,
                               Pair( "UniversalMorphismIntoDirectSumWithGivenDirectSum", [ syntactic_cat, D, T, tau, S ] ),
                               S );
                
            end, 50 );
            
        fi;
        
        if "UniversalMorphismFromDirectSumWithGivenDirectSum" in list_of_operations_to_install then
            
            AddUniversalMorphismFromDirectSumWithGivenDirectSum( syntactic_cat,
              function( syntactic_cat, D, T, tau, S )
                local l, zero, nonzero;
                
                l := Length( D );
                
                if l = 0 and CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    return ZeroMorphism( syntactic_cat, S, T );
                    
                elif l = 1 then
                    
                    Assert( 0, Length( tau ) = 1 );
                    
                    return tau[1];
                    
                elif CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) and ForAll( tau, mor -> IsEqualToZeroMorphism( syntactic_cat, mor ) ) and
                  CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    return ZeroMorphism( syntactic_cat, S, T );
                    
                elif CanCompute( syntactic_cat, "ZeroObject" ) and CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    zero := ZeroObject( syntactic_cat );
                    
                    ## do not use IsZeroForObjects since it delegates to IsCongruentForMorphisms, and hence nonsyntactic
                    nonzero := PositionsProperty( D, obj -> not IsEqualForObjects( syntactic_cat, obj, zero ) );
                    
                    if Length( nonzero ) < l then
                        
                        return UniversalMorphismFromDirectSumWithGivenDirectSum( syntactic_cat,
                                       D{nonzero},
                                       T,
                                       tau{nonzero},
                                       S );
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               S,
                               Pair( "UniversalMorphismFromDirectSumWithGivenDirectSum", [ syntactic_cat, D, T, tau, S ] ),
                               T );
                
            end, 50 );
            
        fi;
        
        if "KernelObject" in list_of_operations_to_install then
            
            AddKernelObject( syntactic_cat,
              function( syntactic_cat, mor )
                
                if CanCompute( syntactic_cat, "IsEqualToIdentityMorphism" ) and CanCompute( syntactic_cat, "ZeroObject" ) then
                    
                    if IsEqualToIdentityMorphism( syntactic_cat, mor ) then
                        
                        return ZeroObject( syntactic_cat );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismIntoDirectSumWithGivenDirectSum" and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToIdentityMorphism( syntactic_cat, entry ) ) then
                        
                        return ZeroObject( syntactic_cat );
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, mor ) then
                        
                        return Source( mor );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismFromDirectSumWithGivenDirectSum" and
                      Length( PairOfOperationNameAndArguments( mor )[2][4] ) = 2 and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToZeroMorphism( syntactic_cat, entry ) ) and
                      CanCompute( syntactic_cat, "DirectSum" ) then
                        
                        return DirectSum( syntactic_cat,
                                       [ KernelObject( syntactic_cat, PairOfOperationNameAndArguments( mor )[2][4][1] ),
                                         KernelObject( syntactic_cat, PairOfOperationNameAndArguments( mor )[2][4][2] ) ] );
                        
                    fi;
                    
                fi;
                
                return ObjectConstructor( syntactic_cat,
                               Pair( "KernelObject", [ syntactic_cat, mor ] ) );
                
            end, 50 );
            
        fi;
        
        if "KernelEmbeddingWithGivenKernelObject" in list_of_operations_to_install then
            
            AddKernelEmbeddingWithGivenKernelObject( syntactic_cat,
              function( syntactic_cat, mor, ker )
                local zero;
                
                if CanCompute( syntactic_cat, "IsEqualToIdentityMorphism" ) and CanCompute( syntactic_cat, "ZeroObject" ) and
                   CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    if IsEqualToIdentityMorphism( syntactic_cat, mor ) then
                        
                        return ZeroMorphism( syntactic_cat, ker, Source( mor ) );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismIntoDirectSumWithGivenDirectSum" and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToIdentityMorphism( syntactic_cat, entry ) ) then
                        
                        return ZeroMorphism( syntactic_cat, ker, Source( mor ) );
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, mor ) and CanCompute( syntactic_cat, "IdentityMorphism" ) then
                        
                        Assert( 0, IsEqualForObjects( syntactic_cat, ker, Source( mor ) ) );
                        
                        return IdentityMorphism( syntactic_cat, Source( mor ) );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismFromDirectSumWithGivenDirectSum" and
                      Length( PairOfOperationNameAndArguments( mor )[2][4] ) = 2 and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToZeroMorphism( syntactic_cat, entry ) ) then
                        
                        if PairOfOperationNameAndArguments( ker )[1] = "DirectSum" then
                            
                            Assert( 0, CanCompute( syntactic_cat, "DirectSumFunctorialWithGivenDirectSums" ) );
                            
                            return DirectSumFunctorialWithGivenDirectSums( syntactic_cat,
                                           ker,
                                           PairOfOperationNameAndArguments( ker )[2][2],
                                           [ KernelEmbeddingWithGivenKernelObject( syntactic_cat,
                                                   PairOfOperationNameAndArguments( mor )[2][4][1],
                                                   PairOfOperationNameAndArguments( ker )[2][2][1] ),
                                             KernelEmbeddingWithGivenKernelObject( syntactic_cat,
                                                   PairOfOperationNameAndArguments( mor )[2][4][2],
                                                   PairOfOperationNameAndArguments( ker )[2][2][2] ) ],
                                           PairOfOperationNameAndArguments( mor )[2][2],
                                           Source( mor ) );
                            
                        else
                            
                            zero := SafeUniquePositionProperty( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToZeroMorphism( syntactic_cat, entry ) );
                            
                            Assert( 0, IsEqualForObjects( syntactic_cat, ker, PairOfOperationNameAndArguments( mor )[2][2][zero] ) );
                            
                            return InjectionOfCofactorOfDirectSumWithGivenDirectSum( syntactic_cat,
                                           PairOfOperationNameAndArguments( mor )[2][2],
                                           zero,
                                           Source( mor ) );
                            
                        fi;
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               ker,
                               Pair( "KernelEmbeddingWithGivenKernelObject", [ syntactic_cat, mor, ker ] ),
                               Source( mor ) );
                
            end, 50 );
            
        fi;
        
        if "KernelLiftWithGivenKernelObject" in list_of_operations_to_install then
            
            AddKernelLiftWithGivenKernelObject( syntactic_cat,
              function( syntactic_cat, mor, T, tau, ker )
                
                if CanCompute( syntactic_cat, "IsEqualToIdentityMorphism" ) and CanCompute( syntactic_cat, "ZeroObject" ) and
                   CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    if IsEqualToIdentityMorphism( syntactic_cat, mor ) then
                        
                        return ZeroMorphism( syntactic_cat, T, ker );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismIntoDirectSumWithGivenDirectSum" and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToIdentityMorphism( syntactic_cat, entry ) ) then
                        
                        return ZeroMorphism( syntactic_cat, T, ker );
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, mor ) then
                        
                        return tau;
                        
                    elif IsEqualToZeroMorphism( syntactic_cat, tau ) and CanCompute( syntactic_cat, "ZeroMorphism" ) then
                        
                        return ZeroMorphism( syntactic_cat, T, ker );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismFromDirectSumWithGivenDirectSum" and
                      Length( PairOfOperationNameAndArguments( mor )[2][4] ) = 2 and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToZeroMorphism( syntactic_cat, entry ) ) then
                        
                        Assert( 0, PairOfOperationNameAndArguments( ker )[1] = "DirectSum" );
                        
                        Error( "not implemented yet\n" );
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IdentityMorphism" ) then
                    
                    if PairOfOperationNameAndArguments( tau )[1] = "KernelEmbeddingWithGivenKernelObject" and
                       IsEqualForMorphisms( syntactic_cat, PairOfOperationNameAndArguments( tau )[2][2], mor ) then
                        
                        Assert( 0, IsEqualForObjects( syntactic_cat, T, ker ) );
                        
                        return IdentityMorphism( syntactic_cat, ker );
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               T,
                               Pair( "KernelLiftWithGivenKernelObject", [ syntactic_cat, mor, T, tau, ker ] ),
                               ker );
                
            end, 50 );
            
        fi;
        
        if "CokernelObject" in list_of_operations_to_install then
            
            AddCokernelObject( syntactic_cat,
              function( syntactic_cat, mor )
                
                if CanCompute( syntactic_cat, "IsEqualToIdentityMorphism" ) and CanCompute( syntactic_cat, "ZeroObject" ) then
                    
                    if IsEqualToIdentityMorphism( syntactic_cat, mor ) then
                        
                        return ZeroObject( syntactic_cat );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismFromDirectSumWithGivenDirectSum" and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToIdentityMorphism( syntactic_cat, entry ) ) then
                        
                        return ZeroObject( syntactic_cat );
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, mor ) then
                        
                        return Target( mor );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismIntoDirectSumWithGivenDirectSum" and
                      Length( PairOfOperationNameAndArguments( mor )[2][4] ) = 2 and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToZeroMorphism( syntactic_cat, entry ) ) and
                      CanCompute( syntactic_cat, "DirectSum" ) then
                        
                        return DirectSum( syntactic_cat,
                                       [ CokernelObject( syntactic_cat, PairOfOperationNameAndArguments( mor )[2][4][1] ),
                                         CokernelObject( syntactic_cat, PairOfOperationNameAndArguments( mor )[2][4][2] ) ] );
                        
                    fi;
                    
                fi;
                
                return ObjectConstructor( syntactic_cat,
                               Pair( "CokernelObject", [ syntactic_cat, mor ] ) );
                
            end, 50 );
            
        fi;
        
        if "CokernelProjectionWithGivenCokernelObject" in list_of_operations_to_install then
            
            AddCokernelProjectionWithGivenCokernelObject( syntactic_cat,
              function( syntactic_cat, mor, coker )
                local zero;
                
                if CanCompute( syntactic_cat, "IsEqualToIdentityMorphism" ) and CanCompute( syntactic_cat, "ZeroObject" ) and
                   CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    if IsEqualToIdentityMorphism( syntactic_cat, mor ) then
                        
                        return ZeroMorphism( syntactic_cat, Target( mor ), coker );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismFromDirectSumWithGivenDirectSum" and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToIdentityMorphism( syntactic_cat, entry ) ) then
                        
                        return ZeroMorphism( syntactic_cat, Target( mor ), coker );
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, mor ) and CanCompute( syntactic_cat, "IdentityMorphism" ) then
                        
                        Assert( 0, IsEqualForObjects( syntactic_cat, Target( mor ), coker ) );
                        
                        return IdentityMorphism( syntactic_cat, Target( mor ) );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismIntoDirectSumWithGivenDirectSum" and
                      Length( PairOfOperationNameAndArguments( mor )[2][4] ) = 2 and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToZeroMorphism( syntactic_cat, entry ) ) then
                        
                        if PairOfOperationNameAndArguments( coker )[1] = "DirectSum" then
                            
                            Assert( 0, CanCompute( syntactic_cat, "DirectSumFunctorialWithGivenDirectSums" ) );
                            
                            return DirectSumFunctorialWithGivenDirectSums( syntactic_cat,
                                           Target( mor ),
                                           PairOfOperationNameAndArguments( mor )[2][2],
                                           [ CokernelProjectionWithGivenCokernelObject( syntactic_cat,
                                                   PairOfOperationNameAndArguments( mor )[2][4][1],
                                                   PairOfOperationNameAndArguments( coker )[2][2][1] ),
                                             CokernelProjectionWithGivenCokernelObject( syntactic_cat,
                                                   PairOfOperationNameAndArguments( mor )[2][4][2],
                                                   PairOfOperationNameAndArguments( coker )[2][2][2] ) ],
                                           PairOfOperationNameAndArguments( coker )[2][2],
                                           coker );
                            
                        else
                            
                            zero := SafeUniquePositionProperty( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToZeroMorphism( syntactic_cat, entry ) );
                            
                            Assert( 0, IsEqualForObjects( syntactic_cat, coker, PairOfOperationNameAndArguments( mor )[2][2][zero] ) );
                            
                            return ProjectionInFactorOfDirectSumWithGivenDirectSum( syntactic_cat,
                                           PairOfOperationNameAndArguments( mor )[2][2],
                                           zero,
                                           Target( mor ) );
                            
                        fi;
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               Target( mor ),
                               Pair( "CokernelProjectionWithGivenCokernelObject", [ syntactic_cat, mor, coker ] ),
                               coker );
                
            end, 50 );
            
        fi;
        
        if "CokernelColiftWithGivenCokernelObject" in list_of_operations_to_install then
            
            AddCokernelColiftWithGivenCokernelObject( syntactic_cat,
              function( syntactic_cat, mor, T, tau, coker )
                
                if CanCompute( syntactic_cat, "IsEqualToIdentityMorphism" ) and CanCompute( syntactic_cat, "ZeroObject" ) and
                   CanCompute( syntactic_cat, "ZeroMorphism" ) then
                    
                    if IsEqualToIdentityMorphism( syntactic_cat, mor ) then
                        
                        return ZeroMorphism( syntactic_cat, coker, T );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismFromDirectSumWithGivenDirectSum" and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToIdentityMorphism( syntactic_cat, entry ) ) then
                        
                        return ZeroMorphism( syntactic_cat, coker, T );
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IsEqualToZeroMorphism" ) then
                    
                    if IsEqualToZeroMorphism( syntactic_cat, mor ) then
                        
                        return tau;
                        
                    elif IsEqualToZeroMorphism( syntactic_cat, tau ) and CanCompute( syntactic_cat, "ZeroMorphism" ) then
                        
                        return ZeroMorphism( syntactic_cat, coker, T );
                        
                    elif PairOfOperationNameAndArguments( mor )[1] = "UniversalMorphismIntoDirectSumWithGivenDirectSum" and
                      Length( PairOfOperationNameAndArguments( mor )[2][4] ) = 2 and
                      ForAny( PairOfOperationNameAndArguments( mor )[2][4], entry -> IsEqualToZeroMorphism( syntactic_cat, entry ) ) then
                        
                        Assert( 0, PairOfOperationNameAndArguments( coker )[1] = "DirectSum" );
                        
                        Error( "not implemented yet\n" );
                        
                    fi;
                    
                fi;
                
                if CanCompute( syntactic_cat, "IdentityMorphism" ) then
                    
                    if PairOfOperationNameAndArguments( tau )[1] = "CokernelProjectionWithGivenCokernelObject" and
                       IsEqualForMorphisms( syntactic_cat, PairOfOperationNameAndArguments( tau )[2][2], mor ) then
                        
                        Assert( 0, IsEqualForObjects( syntactic_cat, coker, T ) );
                        
                        return IdentityMorphism( syntactic_cat, coker );
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               coker,
                               Pair( "CokernelColiftWithGivenCokernelObject", [ syntactic_cat, mor, T, tau, coker ] ),
                               T );
                
            end, 50 );
            
        fi;
        
    fi;
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        Finalize( syntactic_cat );
        
    fi;
    
    for operation_name in options.list_of_operations_to_install do
        
        if not CanCompute( syntactic_cat, operation_name ) then
            
            Print( "WARNING: The synactic category cannot compute ", operation_name, ", probably because the operation is not supported by CategoryConstructor yet.\n" );
            
        fi;
        
    od;
    
    return syntactic_cat;
    
end ) );

##
InstallMethod( \/,
        "for a string and a syntactic category",
        [ IsStringRep, IsSyntacticCategory ],
        
  function( object_name, syntactic_cat )
    
    return Pair( "ObjectConstructor", [ syntactic_cat, object_name ] ) / syntactic_cat;
    
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

##
InstallMethod( LambdaAbstractionByLines,
        "for a cell in a syntactic category and a list",
        [ IsCellInSyntacticCategory, IsList ],
        
  function( cell, list_of_arguments )
    local variable_name, var, cat, list_of_nodes, pos_in_list_of_nodes, positions_of_arguments, n, d, fixed_length_digit,
          arg_func, positions_of_morphisms, list_of_morphisms, list_of_sources, list_of_targets,
          pos_in_list_of_sources, pos_in_list_of_targets, obj_func, func, program, line;
    
    Assert( 0, Length( list_of_arguments ) > 0 and IsCapCategory( list_of_arguments[1] ) );
    
    variable_name := "node_";
    
    cat := list_of_arguments[1];
    
    list_of_arguments := list_of_arguments{[ 2 .. Length( list_of_arguments ) ]};
    
    list_of_nodes := ListOfEvaluationNodes( cell );
    
    pos_in_list_of_nodes := cell -> PositionProperty( list_of_nodes, node -> AreEqualForSyntacticCells( node, cell ) );
    
    positions_of_arguments := List( list_of_arguments, pos_in_list_of_nodes );
    
    n := Length( list_of_nodes );
    
    d := 1 + Int( Log10( Float( n ) ) );
    
    fixed_length_digit :=
      function( i )
        local l;
        
        l := 1 + Int( Log10( Float( i ) ) );
        
        return Concatenation( List( Concatenation( ListWithIdenticalEntries( d - l, 0 ), [ String( i ) ] ), String ) );
        
    end;
    
    arg_func :=
      function( argument )
        if IsCapCategory( argument ) then
            Assert( 0, IsIdenticalObj( argument, cat ) );
            return "cat";
        elif IsRingElement( argument ) then
            return argument;
        fi;
        return Concatenation( variable_name, fixed_length_digit( pos_in_list_of_nodes( argument ) ) );
    end;
    
    positions_of_morphisms := Filtered( [ 1 .. Length( list_of_arguments ) ], i -> IsMorphismInSyntacticCategory( list_of_arguments[i] ) );
    list_of_morphisms := list_of_arguments{positions_of_morphisms};
    list_of_sources := List( list_of_morphisms, Source );
    list_of_targets := List( list_of_morphisms, Target );
    
    pos_in_list_of_sources := cell -> PositionProperty( list_of_sources, node -> AreEqualForSyntacticCells( node, cell ) );
    pos_in_list_of_targets := cell -> PositionProperty( list_of_targets, node -> AreEqualForSyntacticCells( node, cell ) );
    
    obj_func :=
      function( primitive_node )
        local pos;
        
        pos := pos_in_list_of_sources( primitive_node );
        
        if IsPosInt( pos ) then
            return Concatenation( "Source( ", PairOfOperationNameAndArguments( list_of_morphisms[pos] )[2][2], " )" );
        fi;
        
        pos := pos_in_list_of_targets( primitive_node );
        
        Assert( 0, IsPosInt( pos ) );
        
        return Concatenation( "Target( ", PairOfOperationNameAndArguments( list_of_morphisms[pos] )[2][2], " )" );
        
    end;
    
    func :=
      function( i )
        local node, positions, line, datum;
        
        node := list_of_nodes[i];
        
        if IsList( node ) then
            positions := List( node, pos_in_list_of_nodes );
            line := JoinStringsWithSeparator( List( positions, p -> Concatenation( variable_name, fixed_length_digit( p ) ) ), ", " );
            line := Concatenation( "[ ", line, " ]" );
        else
            datum := PairOfOperationNameAndArguments( node );
            if i in positions_of_arguments then
                line := datum[2][2];
            elif datum[1] = "ObjectConstructor" then
                line := obj_func( node );
            else
                line := List( datum[2], arg_func );
                line := JoinStringsWithSeparator( line, ", " );
                line := Concatenation( datum[1], "( ", line, " )" );
            fi;
        fi;
        
        return Concatenation( "  ", variable_name, fixed_length_digit( i ), " := ", line, ";\n" );
        
    end;
    
    program := List( list_of_arguments, cell -> PairOfOperationNameAndArguments( cell )[2][2] );
    
    program := JoinStringsWithSeparator( program, ", " );
    
    program := [ Concatenation( "function ( cat, ", program, " )\n" ) ];
    
    line := List( [ 1 .. n ], i -> Concatenation( variable_name, fixed_length_digit( i ) ) );
    
    line := JoinStringsWithSeparator( line, ", " );
    
    line := [ Concatenation( "  local ", line, ";\n" ) ];
    
    program := Concatenation( program, line );
    
    program := Concatenation( program, List( [ 1 .. n ], func ) );
    
    program := Concatenation( program, [ Concatenation( "  return ", variable_name, fixed_length_digit( n ), ";\n" ) ] );
    
    program := Concatenation( program, [ "end\n" ] );
    
    return program;
    
end );

##
InstallMethod( LambdaAbstractionAsString,
        "for a cell in a syntactic category and a list",
        [ IsCellInSyntacticCategory, IsList ],
        
  function( cell, list_of_arguments )
    local program;
    
    program := LambdaAbstractionByLines( cell, list_of_arguments );
    
    program := Concatenation( program );
    
    program := EvalString( program );
    
    return DisplayString( program );
    
end );

##
InstallMethod( LambdaAbstraction,
        "for a cell in a syntactic category and a list",
        [ IsCellInSyntacticCategory, IsList ],
        
  function( cell, list_of_arguments )
    
    return EvalString( LambdaAbstractionAsString( cell, list_of_arguments ) );
    
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
        
        return Concatenation( "\"", datum[2][2], "\" / ", cat_name );
        
    fi;
    
    return Concatenation( datum[1], "( ", JoinStringsWithSeparator( List( datum[2], String ), ", " ), " )" );
    
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
                       String( Source( phi ) ), ", Pair( \"MorphismConstructor\", [ ",
                       cat_name, ", \"",
                       datum[2][2], "\" ] ), ",
                       String( Target( phi ) ), " )" );
        
    fi;
    
    return Concatenation( datum[1], "( ",
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
