# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForCategoricalTowers: Tools for CategoricalTowers
#
# Implementations
#

SetInfoLevel( InfoSyntacticCategory, 1 );

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
    [ "quiver", fail ],
    [ "category", fail ],
    [ "optimize", 1 ],
    [ "view", fail ],
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
                    IsList( object_datum[2] ) and not IsEmpty( object_datum[2] ) and IsIdenticalObj( object_datum[2][1], cat ) );
            
            return CreateCapCategoryObjectWithAttributes( cat,
                           PairOfOperationNameAndArguments, object_datum );
            
        end;
        
    fi;
    
    if "MorphismConstructor" in options.list_of_operations_to_install then
        
        category_constructor_options.morphism_constructor := function ( cat, source, morphism_datum, target )
            
            Assert( 0,
                    IsList( morphism_datum ) and Length( morphism_datum ) = 2 and IsStringRep( morphism_datum[1] ) and
                    IsList( morphism_datum[2] ) and not IsEmpty( morphism_datum[2] ) and IsIdenticalObj( morphism_datum[2][1], cat ) );
            
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
        
        Error( "the two morphisms are not syntactically equal, however, they might still be equal up to categorical rewriting; to avoid this error message use `IsEqualForMorphisms` instead\n" );
        
    end, OperationWeight( syntactic_cat, "IsEqualForMorphisms" ) );
    
    AddIsWellDefinedForObjects( syntactic_cat,
      function( syntactic_cat, obj )
        
        return true;
        
    end, 50 );
    
    AddIsWellDefinedForMorphisms( syntactic_cat,
      function( syntactic_cat, mor )
        
        return true;
        
    end, 50 );
    
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
        
        if "PreComposeList" in list_of_operations_to_install then
            
            AddPreComposeList( syntactic_cat,
              function( syntactic_cat, source, list_of_mors, target )
                local l, extract_argument, condition, p, objects_pre, objects_pst, i, datum, D, tau, n;
                
                list_of_mors := ShallowCopy( list_of_mors );
                
                l := Length( list_of_mors );

                if l = 1 then

                    Info( InfoSyntacticCategory, 10,
                          "PreComposeList( [ mor ] )  ~>  mor" );
                    
                    return list_of_mors[1];
                    
                fi;
                
                if ForAny( list_of_mors, mor -> PairOfOperationNameAndArguments( mor )[1] = "PreComposeList" ) then
                    
                    extract_argument :=
                      function( mor )
                        local pair;
                        
                        pair := PairOfOperationNameAndArguments( mor );
                        
                        if pair[1] = "PreComposeList" then
                            return pair[2][3];
                        else
                            return [ mor ];
                        fi;
                        
                    end;
                    
                    Info( InfoSyntacticCategory, 10,
                          "PreComposeList( [ …, PreComposeList( [ … ] ), …  ] )  ~>  PreComposeList( [ …, …, … ] )" );
                    
                    return PreComposeList( syntactic_cat,
                                   source,
                                   Concatenation( List( list_of_mors, extract_argument ) ),
                                   target );
                    
                fi;
                
                condition :=
                  function( p )
                    
                    return PairOfOperationNameAndArguments( list_of_mors[p] )[1] = "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject";
                    
                end;
                
                p := PositionProperty( [ 1 .. l - 1 ], p -> condition( l - p + 1 ) );
                
                if IsInt( p ) then
                    
                    list_of_mors := Concatenation(
                                            [ UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( syntactic_cat,
                                                    Source( list_of_mors[1] ),
                                                    Target( list_of_mors[l - p + 1] ) ) ],
                                            list_of_mors{[ ( l - p + 1 ) + 1 .. l ]} );
                    
                    Info( InfoSyntacticCategory, 2,
                          "f ⋅ t(f) → 𝟏  ~>  s(f) → 𝟏",
                          "\t\t\t\t(l = ", String( l ), ")" );
                    
                    return PreComposeList( syntactic_cat, source, list_of_mors, target );
                    
                fi;
                
                ## condition for universal property of direct product
                condition :=
                  function( p )
                    local datum_pre, datum_pst, objects_pre, objects_pst, m;
                    
                    datum_pre := PairOfOperationNameAndArguments( list_of_mors[p] );
                    
                    if not datum_pre[1] = "UniversalMorphismIntoDirectProductWithGivenDirectProduct" then
                        
                        return false;
                        
                    fi;
                    
                    datum_pst := PairOfOperationNameAndArguments( list_of_mors[p + 1] );
                    
                    if not datum_pst[1] = "ProjectionInFactorOfDirectProductWithGivenDirectProduct" then
                        
                        return false;
                        
                    fi;
                    
                    objects_pre := datum_pre[2][2];
                    objects_pst := datum_pst[2][2];
                    
                    m := Length( objects_pre );
                    
                    return m = Length( objects_pst ) and
                           ForAll( [ 1 .. m ], i -> IsEqualForObjects( syntactic_cat, objects_pre[i], objects_pst[i] ) );
                    
                end;
                
                p := PositionProperty( [ 1 .. l - 1 ], condition );
                
                if IsInt( p ) then
                    
                    objects_pre := PairOfOperationNameAndArguments( list_of_mors[p] )[2][2];
                    objects_pst := PairOfOperationNameAndArguments( list_of_mors[p + 1] )[2][2];
                    
                    i := PairOfOperationNameAndArguments( list_of_mors[p+1] )[2][3];
                    
                    list_of_mors[p] := PairOfOperationNameAndArguments( list_of_mors[p] )[2][4][i];
                    Remove( list_of_mors, p + 1 );
                    
                    Info( InfoSyntacticCategory, 2,
                          "⟨ …, τᵢ, … ⟩ ⋅ πᵢ  ~>  τᵢ",
                          "\t\t\t\t(p = ", String( p ), ", i = ", String( i ), ")" );
                    
                    return PreComposeList( syntactic_cat, source, list_of_mors, target );
                    
                fi;
                
                if l > 1 and PairOfOperationNameAndArguments( list_of_mors[l] )[1] = "UniversalMorphismIntoDirectProductWithGivenDirectProduct" then
                    
                    datum := PairOfOperationNameAndArguments( list_of_mors[l] );
                    
                    D := datum[2][2];
                    tau := datum[2][4];
                    
                    n := Length( D );
                    
                    Info( InfoSyntacticCategory, 2,
                          "f ⋅ ⟨ τ₁, …, τₙ ⟩  ~>  ⟨ f ⋅ τ₁, …, f ⋅ τₙ ⟩",
                          "\t(l = ", String( l ), ", n = ", String( n ), ")" );
                    
                    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( syntactic_cat,
                                   D,
                                   source,
                                   List( [ 1 .. n ], i ->
                                         PreComposeList( syntactic_cat,
                                                 source,
                                                 Concatenation( list_of_mors{[ 1 .. l - 1 ]}, [ tau[i] ] ),
                                                 D[i] ) ),
                                   target );
                    
                fi;
                
                ## condition for (A×-)-(-)ᴬ-adjunction
                condition :=
                  function( p )
                    local datum_pst, A, AxB, datum_AxB, B, expA_AxB;
                    
                    datum_pst := PairOfOperationNameAndArguments( list_of_mors[p + 1] );
                    
                    if not datum_pst[1] = "CartesianRightEvaluationMorphismWithGivenSource" then
                        
                        return false;
                        
                    fi;
                    
                    A := datum_pst[2][2];
                    AxB := datum_pst[2][3];
                    
                    datum_AxB := PairOfOperationNameAndArguments( AxB );
                    
                    if not ( datum_AxB[1] = "DirectProduct" and Length( datum_AxB[2][2] ) = 2 and IsEqualForObjects( syntactic_cat, datum_AxB[2][2][1], A ) ) then
                        
                        return false;
                        
                    fi;
                    
                    B := datum_AxB[2][2][2];
                    
                    expA_AxB := PairOfOperationNameAndArguments( datum_pst[2][4] )[2][2][2];
                    
                    return IsEqualForMorphismsOnMor( syntactic_cat,
                                   list_of_mors[p],
                                   DirectProductOnObjectAndMorphism( syntactic_cat,
                                           A,
                                           CartesianRightCoevaluationMorphismWithGivenRange( syntactic_cat,
                                                   A,
                                                   B,
                                                   expA_AxB ) ) );
                    
                end;
                
                p := PositionProperty( [ 1 .. l - 1 ], condition );
                
                if IsInt( p ) then
                    
                    Remove( list_of_mors, p );
                    Remove( list_of_mors, p ); # remove the old p + 1
                    
                    Info( InfoSyntacticCategory, 2,
                          "A×[B → (A×B)ᴬ] ⋅ A×(A×B)ᴬ → A×B  ~>  id_A×B",
                          "\t\t(l = ", String( l ), ", p = ", String( p ), ")" );
                    
                    if IsEmpty( list_of_mors ) then
                        return IdentityMorphism( syntactic_cat, source );
                    else
                        return PreComposeList( syntactic_cat, source, list_of_mors, target );
                    fi;
                    
                fi;
                
                ## condition for (A×-)-(-)ᴬ-adjunction
                condition :=
                  function( p )
                    local datum_pre, A, expA_B, datum_expA_B, B, AxexpA_B;
                    
                    datum_pre := PairOfOperationNameAndArguments( list_of_mors[p] );
                    
                    if not datum_pre[1] = "CartesianRightCoevaluationMorphismWithGivenRange" then
                        
                        return false;
                        
                    fi;
                    
                    A := datum_pre[2][2];
                    expA_B := datum_pre[2][3];
                    
                    datum_expA_B := PairOfOperationNameAndArguments( expA_B );
                    
                    if not ( datum_expA_B[1] = "ExponentialOnObjects" and IsEqualForObjects( syntactic_cat, datum_expA_B[2][2], A ) ) then
                        
                        return false;
                        
                    fi;
                    
                    B := datum_expA_B[2][3];
                    
                    AxexpA_B := PairOfOperationNameAndArguments( datum_pre[2][4] )[2][3];
                    
                    return IsEqualForMorphismsOnMor( syntactic_cat,
                                   list_of_mors[p + 1],
                                   ExponentialOnMorphisms( syntactic_cat,
                                           IdentityMorphism( A ),
                                           CartesianRightEvaluationMorphismWithGivenSource( syntactic_cat,
                                                   A,
                                                   B,
                                                   AxexpA_B ) ) );
                    
                end;
                
                p := PositionProperty( [ 1 .. l - 1 ], condition );
                
                if IsInt( p ) then
                    
                    Remove( list_of_mors, p );
                    Remove( list_of_mors, p ); # remove the old p + 1
                    
                    Info( InfoSyntacticCategory, 2,
                          "Bᴬ → (A×Bᴬ)ᴬ ⋅ (A×Bᴬ → B)ᴬ  ~>  id_Bᴬ",
                          "\t\t(l = ", String( l ), ", p = ", String( p ), ")" );
                    
                    if IsEmpty( list_of_mors ) then
                        return IdentityMorphism( syntactic_cat, source );
                    else
                        return PreComposeList( syntactic_cat, source, list_of_mors, target );
                    fi;
                    
                fi;
                
                ## condition for (-×A)-(-)ᴬ-adjunction
                condition :=
                  function( p )
                    local datum_pst, A, BxA, datum_BxA, B, expA_BxA;
                    
                    datum_pst := PairOfOperationNameAndArguments( list_of_mors[p + 1] );
                    
                    if not datum_pst[1] = "CartesianLeftEvaluationMorphismWithGivenSource" then
                        
                        return false;
                        
                    fi;
                    
                    A := datum_pst[2][2];
                    BxA := datum_pst[2][3];
                    
                    datum_BxA := PairOfOperationNameAndArguments( BxA );
                    
                    if not ( datum_BxA[1] = "DirectProduct" and Length( datum_BxA[2][2] ) = 2 and IsEqualForObjects( syntactic_cat, datum_BxA[2][2][2], A ) ) then
                        
                        return false;
                        
                    fi;
                    
                    B := datum_BxA[2][2][1];
                    
                    expA_BxA := PairOfOperationNameAndArguments( datum_pst[2][4] )[2][2][1];
                    
                    return IsEqualForMorphismsOnMor( syntactic_cat,
                                   list_of_mors[p],
                                   DirectProductOnMorphismAndObject( syntactic_cat,
                                           CartesianLeftCoevaluationMorphismWithGivenRange( syntactic_cat,
                                                   A,
                                                   B,
                                                   expA_BxA ),
                                           A ) );
                    
                end;
                
                p := PositionProperty( [ 1 .. l - 1 ], condition );
                
                if IsInt( p ) then
                    
                    Remove( list_of_mors, p );
                    Remove( list_of_mors, p ); # remove the old p + 1
                    
                    Info( InfoSyntacticCategory, 2,
                          "[B → (B×A)ᴬ]×A ⋅ (B×A)ᴬ×A → B×A  ~>  id_B×A",
                          "\t\t(l = ", String( l ), ", p = ", String( p ), ")" );
                    
                    if IsEmpty( list_of_mors ) then
                        return IdentityMorphism( syntactic_cat, source );
                    else
                        return PreComposeList( syntactic_cat, source, list_of_mors, target );
                    fi;
                    
                fi;
                
                ## condition for (-×A)-(-)ᴬ-adjunction
                condition :=
                  function( p )
                    local datum_pre, A, expA_B, datum_expA_B, B, expA_BxA;
                    
                    datum_pre := PairOfOperationNameAndArguments( list_of_mors[p] );
                    
                    if not datum_pre[1] = "CartesianLeftCoevaluationMorphismWithGivenRange" then
                        
                        return false;
                        
                    fi;
                    
                    A := datum_pre[2][2];
                    expA_B := datum_pre[2][3];
                    
                    datum_expA_B := PairOfOperationNameAndArguments( expA_B );
                    
                    if not ( datum_expA_B[1] = "ExponentialOnObjects" and IsEqualForObjects( syntactic_cat, datum_expA_B[2][2], A ) ) then
                        
                        return false;
                        
                    fi;
                    
                    B := datum_expA_B[2][3];
                    
                    expA_BxA := PairOfOperationNameAndArguments( datum_pre[2][4] )[2][3];
                    
                    return IsEqualForMorphismsOnMor( syntactic_cat,
                                   list_of_mors[p + 1],
                                   ExponentialOnMorphisms( syntactic_cat,
                                           IdentityMorphism( A ),
                                           CartesianLeftEvaluationMorphismWithGivenSource( syntactic_cat,
                                                   A,
                                                   B,
                                                   expA_BxA ) ) );
                    
                end;
                
                p := PositionProperty( [ 1 .. l - 1 ], condition );
                
                if IsInt( p ) then
                    
                    Remove( list_of_mors, p );
                    Remove( list_of_mors, p ); # remove the old p + 1
                    
                    Info( InfoSyntacticCategory, 2,
                          "Bᴬ → (Bᴬ×A)ᴬ ⋅ (Bᴬ×A → B)ᴬ  ~>  id_Bᴬ",
                          "\t\t(l = ", String( l ), ", p = ", String( p ), ")" );
                    
                    if IsEmpty( list_of_mors ) then
                        return IdentityMorphism( syntactic_cat, source );
                    else
                        return PreComposeList( syntactic_cat, source, list_of_mors, target );
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               source,
                               Pair( "PreComposeList", [ syntactic_cat, source, list_of_mors, target ] ),
                               target );
                
            end, 50 );
            
        fi;
        
        if "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" in list_of_operations_to_install then
            
            AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( syntactic_cat,
              function( syntactic_cat, A, T )
                local datum, D, n, i;
                
                if IsEqualForObjects( syntactic_cat, A, T ) then
                    
                    Info( InfoSyntacticCategory, 2,
                          "𝟏 → 𝟏  ~>  id_𝟏" );
                    
                    return IdentityMorphism( syntactic_cat, T );
                    
                fi;
                
                datum := PairOfOperationNameAndArguments( A );

                if datum[1] = "DirectProduct" then
                    
                    D := datum[2][2];
                    
                    n := Length( D );
                    
                    i := PositionsProperty( [ 1 .. n ], i -> PairOfOperationNameAndArguments( D[i] )[1] = "TerminalObject" );
                    
                    if Length( i ) = 1 then
                        
                        i := i[1];
                        
                        Info( InfoSyntacticCategory, 2,
                              "(A₁ × ⋯ × Aᵢ₋₁ × 𝟏 x Aᵢ₊₁ × ⋯ × Aₙ) → 𝟏  ~>  πᵢ",
                              "\t(i = ", String( i ), ", n = ", String( n ), ")" );
                        
                        return ProjectionInFactorOfDirectProductWithGivenDirectProduct( syntactic_cat,
                                       D,
                                       i,
                                       A );
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               A,
                               Pair( "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject", [ syntactic_cat, A, T ] ),
                               T );
                
            end );
            
        fi;
        
        if "UniversalMorphismIntoDirectProductWithGivenDirectProduct" in list_of_operations_to_install then
            
            AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( syntactic_cat,
              function( syntactic_cat, D, T, tau, P )
                local n, data, list_of_mors, lengths, ls, l, tail;
                
                n := Length( tau );
                
                data := List( tau, PairOfOperationNameAndArguments );
                
                if ForAll( [ 1 .. n ], i -> data[i][1] = "ProjectionInFactorOfDirectProductWithGivenDirectProduct" and
                           Length( data[i][2][2] ) = n and
                           ForAll( [ 1 .. n ], j -> IsEqualForObjects( syntactic_cat, D[j], data[i][2][2][j] ) ) and
                           data[i][2][3] = i ) then
                    
                    l := 1;
                    
                    ## for this to be a special case of the rule "⟨ f ⋅ π₁ , …, f ⋅ πₙ ⟩  ~>  f" below
                    ## we would need the normalization rule "f ~> PreComposeList( Source( f ), [ f ] , Target( f ) )"
                    Info( InfoSyntacticCategory, 2,
                          "⟨ f ⋅ π₁ , …, f ⋅ πₙ ⟩  ~>  f",
                          "\t\t\t(l = ", String( l ), ", n = ", String( n ), ") : ⟨ π₁, …, πₙ ⟩  ~>  id" );
                    
                    return IdentityMorphism( syntactic_cat, P );
                    
                fi;
                
                if n > 0 and
                   ForAll( [ 1 .. n ], i -> data[i][1] = "PreComposeList" ) then
                    
                    list_of_mors := List( data, datum -> datum[2][3] );
                    
                    lengths := List( list_of_mors, Length );
                    
                    ls := Set( lengths );
                    
                    if Length( ls ) = 1 then
                        
                        l := ls[1];
                        
                        if l > 1 and
                           ForAll( [ 1 .. n - 1 ], i ->
                                   ForAll( [ 1 .. l - 1 ], j ->
                                           IsEqualForMorphismsOnMor( syntactic_cat, list_of_mors[i][j], list_of_mors[i + 1][j] ) ) ) then
                            
                            tail := List( [ 1 .. n ], i -> PairOfOperationNameAndArguments( list_of_mors[i][l] ) );
                            
                            if ForAll( [ 1 .. n ], i ->
                                       tail[i][1] = "ProjectionInFactorOfDirectProductWithGivenDirectProduct" ) then
                                
                                if n = Length( tail[1][2][2] ) and
                                   ForAll( [ 1 .. n ], i -> i = tail[i][2][3] ) then
                                    
                                    Info( InfoSyntacticCategory, 2,
                                          "⟨ f ⋅ π₁ , …, f ⋅ πₙ ⟩  ~>  f",
                                          "\t\t\t(l = ", String( l ), ", n = ", String( n ), ")" );
                                    
                                    return PreComposeList( syntactic_cat,
                                                   data[1][2][2],
                                                   list_of_mors[1]{[ 1 .. n - 1 ]},
                                                   Target( list_of_mors[1][n - 1] ) );
                                    
                                fi;
                                
                            fi;
                            
                        fi;
                        
                    fi;
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               T,
                               Pair( "UniversalMorphismIntoDirectProductWithGivenDirectProduct", [ syntactic_cat, D, T, tau, P ] ),
                               P );
                
            end );
            
        fi;
        
        if false and "ExponentialOnMorphismsWithGivenExponentials" in list_of_operations_to_install then
            
            AddExponentialOnMorphismsWithGivenExponentials( syntactic_cat,
              function( syntactic_cat, source, mor_pre, mor_pst, target )
                local datum_pst, A;
                
                datum_pst := PairOfOperationNameAndArguments( mor_pst );
                
                if datum_pst[1] = "PreComposeList" and
                   Length( datum_pst[2][3] ) > 1 then
                    
                    A := Source( mor_pre );
                    
                    return PreComposeList( syntactic_cat,
                                   source,
                                   List( datum_pst[2][3], mor ->
                                         ExponentialOnMorphisms( syntactic_cat,
                                                 mor_pre,
                                                 mor ) ),
                                   target );
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               source,
                               Pair( "ExponentialOnMorphismsWithGivenExponentials", [ syntactic_cat, source, mor_pre, mor_pst, target ] ),
                               target );
                
            end );
            
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
        
        if "MultiplyWithElementOfCommutativeSemiringForMorphisms" in list_of_operations_to_install then
            
            AddMultiplyWithElementOfCommutativeSemiringForMorphisms( syntactic_cat,
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
                               Pair( "MultiplyWithElementOfCommutativeSemiringForMorphisms", [ syntactic_cat, r, mor ] ),
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
        
        if "TensorProductOnListOfObjects" in list_of_operations_to_install then
            
            AddTensorProductOnListOfObjects( syntactic_cat,
              function( syntactic_cat, list_of_objs )
                local extract_argument;
                
                if ForAny( list_of_objs, obj -> PairOfOperationNameAndArguments( obj )[1] = "TensorProductOnListOfObjects" ) then
                    
                    extract_argument :=
                      function( obj )
                        local pair;
                        
                        pair := PairOfOperationNameAndArguments( obj );
                        
                        if pair[1] = "TensorProductOnListOfObjects" then
                            return pair[2][2];
                        else
                            return [ obj ];
                        fi;
                        
                    end;
                    
                    return TensorProductOnListOfObjects( syntactic_cat,
                                   Concatenation( List( list_of_objs, extract_argument ) ) );
                    
                fi;
                
                return ObjectConstructor( syntactic_cat,
                               Pair( "TensorProductOnListOfObjects", [ syntactic_cat, list_of_objs ] ) );
                
            end, 50 );
            
        fi;
        
        if "TensorProductOnListOfMorphisms" in list_of_operations_to_install then
            
            AddTensorProductOnListOfMorphisms( syntactic_cat,
              function( syntactic_cat, list_of_mors )
                local source, target, id, extract_argument;
                
                source := TensorProductOnListOfObjects( List( list_of_mors, Source ) );
                target := TensorProductOnListOfObjects( List( list_of_mors, Target ) );
                
                id := IdentityMorphism( syntactic_cat, TensorUnit( syntactic_cat ) );
                
                list_of_mors := Filtered( list_of_mors, mor -> not IsEqualForMorphismsOnMor( syntactic_cat, mor, id ) );
                
                if ForAny( list_of_mors, mor -> PairOfOperationNameAndArguments( mor )[1] = "TensorProductOnListOfMorphisms" ) then
                    
                    extract_argument :=
                      function( mor )
                        local pair;
                        
                        pair := PairOfOperationNameAndArguments( mor );
                        
                        if pair[1] = "TensorProductOnListOfMorphisms" then
                            return pair[2][2];
                        else
                            return [ mor ];
                        fi;
                        
                    end;
                    
                    return TensorProductOnListOfMorphisms( syntactic_cat,
                                   Concatenation( List( list_of_mors, extract_argument ) ) );
                    
                fi;
                
                return MorphismConstructor( syntactic_cat,
                               source,
                               Pair( "TensorProductOnListOfMorphisms", [ syntactic_cat, list_of_mors ] ),
                               target );
                
            end, 50 );
            
        fi;
        
    fi;
    
    if CAP_NAMED_ARGUMENTS.view = "show" then
        
        ##
        InstallMethod( ViewString, [ ObjectFilter( syntactic_cat ) ], ShowString );
        
        ##
        InstallMethod( ViewString, [ MorphismFilter( syntactic_cat ) ], ShowString );
        
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
InstallMethod( ShowString,
        "for an object in a syntactic category",
        [ IsObjectInSyntacticCategory ],
        
  function( a )
    local ShowString_with_brackets, datum;
    
    ShowString_with_brackets :=
      function( a )
        local datum;
        
        datum := PairOfOperationNameAndArguments( a );
        
        if datum[1] = "ObjectConstructor" then
            return datum[2][2];
        elif datum[1] = "TerminalObject" then
            return "𝟏";
        else
            return Concatenation( "(", ShowString( a ), ")" );
        fi;
        
    end;
    
    datum := PairOfOperationNameAndArguments( a );
    
    if datum[1] = "ObjectConstructor" then
        return datum[2][2];
    elif datum[1] = "TerminalObject" then
        return "𝟏";
    elif datum[1] = "DirectProduct" then
        return JoinStringsWithSeparator( List( datum[2][2], ShowString_with_brackets ), "×" );
    elif datum[1] = "ExponentialOnObjects" then
        return Concatenation( ShowString_with_brackets( datum[2][3] ), "^", ShowString_with_brackets( datum[2][2] ) );
    fi;
    
    return Concatenation( datum[1], "( ", JoinStringsWithSeparator( List( datum[2]{[ 2 .. Length( datum[2] ) ]}, ShowString ), ", " ), " )" );
    
end );

##
InstallMethod( ShowString,
        "for an morphism in a syntactic category",
        [ IsMorphismInSyntacticCategory ],
        
  function( phi )
    local ShowString_with_brackets, datum;
    
    ShowString_with_brackets :=
      function( a )
        local datum;
        
        datum := PairOfOperationNameAndArguments( a );
        
        if datum[1] = "ObjectConstructor" then
            return datum[2][2];
        elif datum[1] = "TerminalObject" then
            return "𝟏";
        else
            return Concatenation( "(", ShowString( a ), ")" );
        fi;
        
    end;
    
    datum := PairOfOperationNameAndArguments( phi );
    
    if datum[1] = "MorphismConstructor" then
        return Concatenation( datum[2][2], ":", ShowString( Source( phi ) ), "→", ShowString( Target( phi ) ) );
    elif datum[1] = "PreComposeList" then
        if IsEmpty( datum[2][3] ) then
            return Concatenation( "id_", ShowString( datum[2][2] ) );
        fi;
        return JoinStringsWithSeparator( List( datum[2][3], ShowString ), " ⋅ " );
    elif datum[1] = "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" then
        return Concatenation( ShowString( datum[2][2] ), "→", ShowString( datum[2][3] ) );
    elif datum[1] = "ProjectionInFactorOfDirectProductWithGivenDirectProduct" then
        return Concatenation( "π_", String( datum[2][3] ), ":", ShowString( datum[2][4] ), "→", ShowString( datum[2][2][datum[2][3]] ) );
    elif datum[1] = "UniversalMorphismIntoDirectProductWithGivenDirectProduct" then
        if IsEmpty( datum[2][4] ) then
            return Concatenation( ShowString( datum[2][3] ), "→", ShowString( datum[2][5] ) );
        fi;
        return Concatenation( "⟨ ", JoinStringsWithSeparator( List( datum[2][4], ShowString ), ", " ) ," ⟩" );
    elif datum[1] = "ExponentialOnMorphismsWithGivenExponentials" then
        if IsEqualToIdentityMorphism( datum[2][3] ) then
            return Concatenation( "( ", ShowString( datum[2][4] ), " )^", ShowString_with_brackets( Source( datum[2][3] ) ) );
        fi;
    elif datum[1] = "CartesianRightCoevaluationMorphismWithGivenRange" then
        return Concatenation( "rcoev:", ShowString( datum[2][3] ), "→", ShowString( datum[2][4] ) );
    elif datum[1] = "CartesianRightEvaluationMorphismWithGivenSource" then
        return Concatenation( "rev:", ShowString( datum[2][4] ), "→", ShowString( datum[2][3] ) );
    elif datum[1] = "CartesianLeftCoevaluationMorphismWithGivenRange" then
        return Concatenation( "lcoev:", ShowString( datum[2][3] ), "→", ShowString( datum[2][4] ) );
    elif datum[1] = "CartesianLeftEvaluationMorphismWithGivenSource" then
        return Concatenation( "lev:", ShowString( datum[2][4] ), "→", ShowString( datum[2][3] ) );
    fi;
    
    return Concatenation( datum[1], "( ", JoinStringsWithSeparator( List( datum[2]{[ 2 .. Length( datum[2] ) ]}, ShowString ), ", " ), " )" );
    
end );

##
InstallOtherMethod( ShowString,
        "for a list",
        [ IsList ],
        
  function( L )
    
    return Concatenation( "[ ", JoinStringsWithSeparator( List( L, ShowString ), ", " ), " ]" );
    
end );

##
InstallOtherMethod( ShowString,
        "for an integer",
        [ IsInt ],
        
  function( i )
    
    return String( i );
    
end );

##
InstallMethod( Show,
        "for an object in a syntactic category",
        [ IsCellInSyntacticCategory ],
        
  function( cell )
    
    Display( ShowString( cell ) );
    
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
