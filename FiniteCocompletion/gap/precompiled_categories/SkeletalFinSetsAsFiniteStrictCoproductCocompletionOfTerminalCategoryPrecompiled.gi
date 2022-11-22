# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletion: Finite (co)product/(co)limit (co)completions
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_SkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategoryPrecompiled", function ( cat )
    
    ##
    AddCoproduct( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Length, Sum( List( arg2_1, Length ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Length, Product( List( arg2_1, Length ) ) );
end
########
        
    , 100 );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Length, 1 );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1;
    deduped_8_1 := Length( Source( alpha_1 ) );
    hoisted_7_1 := [ 0 .. deduped_8_1 - 1 ];
    hoisted_6_1 := Length( Range( beta_1 ) );
    hoisted_5_1 := deduped_8_1;
    hoisted_4_1 := AsLazyArray( beta_1 );
    hoisted_3_1 := AsLazyArray( alpha_1 );
    hoisted_2_1 := Length( Range( alpha_1 ) );
    hoisted_1_1 := Length( Source( beta_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, AsLazyArray, LazyArrayFromList( List( [ 0 .. Length( source_1 ) - 1 ], function ( logic_new_func_x_2 )
                local hoisted_1_2, hoisted_2_2;
                hoisted_1_2 := LazyArray( hoisted_2_1, function ( i_3 )
                        return REM_INT( QUO_INT( logic_new_func_x_2, hoisted_1_1 ^ i_3 ), hoisted_1_1 );
                    end );
                hoisted_2_2 := LazyArray( hoisted_5_1, function ( j_3 )
                        return hoisted_4_1[hoisted_1_2[hoisted_3_1[j_3]]];
                    end );
                return Sum( hoisted_7_1, function ( i_3 )
                        return hoisted_2_2[i_3] * hoisted_6_1 ^ i_3;
                    end );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Length, Length( arg3_1 ) ^ Length( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, AsLazyArray, LazyStandardInterval( Length( a_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Length, 0 );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := List( objects_1, Length );
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], P_1, AsLazyArray, LazyInterval( deduped_1_1[k_1], Sum( deduped_1_1{[ 1 .. k_1 - 1 ]} ) ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1;
    deduped_15_1 := ModelingCategory( cat_1 );
    deduped_14_1 := Length( source_1 );
    deduped_13_1 := [ 0 .. Length( Source( alpha_1 ) ) - 1 ];
    hoisted_3_1 := CreateCapCategoryObjectWithAttributes( deduped_15_1, PairOfIntAndList, NTuple( 2, 1, [ CreateCapCategoryObjectWithAttributes( UnderlyingCategory( deduped_15_1 ), PairOfIntAndList, NTuple( 2, 0, [  ] ) ) ] ) );
    deduped_12_1 := List( deduped_13_1, function ( i_2 )
            return hoisted_3_1;
        end );
    deduped_11_1 := [ 0 .. Length( deduped_12_1 ) - 1 ];
    hoisted_2_1 := Length( Range( alpha_1 ) );
    hoisted_1_1 := AsLazyArray( alpha_1 );
    hoisted_10_1 := LazyInterval( 1, Sum( deduped_13_1, function ( i_2 )
              return hoisted_1_1[i_2] * hoisted_2_1 ^ i_2;
          end ) );
    hoisted_8_1 := deduped_11_1;
    hoisted_6_1 := List( deduped_12_1, function ( logic_new_func_x_2 )
            return PairOfIntAndList( logic_new_func_x_2 )[1];
        end );
    hoisted_7_1 := List( deduped_11_1, function ( j_2 )
            return Product( hoisted_6_1{[ 1 .. j_2 ]} );
        end );
    hoisted_4_1 := LazyStandardInterval( 1 );
    hoisted_5_1 := List( deduped_13_1, function ( logic_new_func_x_2 )
            return hoisted_4_1;
        end );
    hoisted_9_1 := LazyArray( deduped_14_1, function ( i_2 )
            return Sum( hoisted_8_1, function ( j_3 )
                    local deduped_1_3;
                    deduped_1_3 := 1 + j_3;
                    return hoisted_5_1[deduped_1_3][i_2] * hoisted_7_1[deduped_1_3];
                end );
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, AsLazyArray, LazyArray( deduped_14_1, function ( i_2 )
              return hoisted_10_1[hoisted_9_1[i_2]];
          end ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, source_1, range_1, alpha_1 )
    local hoisted_1_1, hoisted_2_1;
    hoisted_2_1 := AsLazyArray( alpha_1 )[0];
    hoisted_1_1 := Length( range_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, AsLazyArray, LazyArray( Length( source_1 ), function ( i_2 )
              return REM_INT( QUO_INT( hoisted_2_1, hoisted_1_1 ^ i_2 ), hoisted_1_1 );
          end ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    if not AsLazyArray( arg2_1 ) = AsLazyArray( arg3_1 ) then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    if not AsLazyArray( arg2_1 ) = AsLazyArray( arg3_1 ) then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    if not Length( arg2_1 ) = Length( arg3_1 ) then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    return Length( arg2_1 ) = 0;
end
########
        
    , 100 );
    
    ##
    AddIsTerminal( cat,
        
########
function ( cat_1, arg2_1 )
    return Length( arg2_1 ) = 1;
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := AsLazyArray( arg2_1 );
    deduped_3_1 := Length( deduped_4_1 );
    deduped_2_1 := Length( Source( arg2_1 ) );
    hoisted_1_1 := Length( Range( arg2_1 ) );
    if not ForAll( deduped_4_1, function ( a_2 )
                 return (IsInt( a_2 ) and a_2 >= 0);
             end ) then
        return false;
    elif not deduped_2_1 = deduped_3_1 then
        return false;
    elif not ForAll( deduped_4_1, function ( a_2 )
                 return a_2 < hoisted_1_1;
             end ) then
        return false;
    elif not deduped_3_1 = deduped_2_1 then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := Length( arg2_1 );
    return IsInt( deduped_1_1 ) and deduped_1_1 >= 0;
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg4_1, AsLazyArray, arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return AsLazyArray( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Length, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return Length( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := Source( alpha_1 );
    hoisted_2_1 := AsLazyArray( beta_1 );
    hoisted_1_1 := AsLazyArray( alpha_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_3_1, Range( beta_1 ), AsLazyArray, LazyArray( Length( deduped_3_1 ), function ( i_2 )
              return hoisted_2_1[hoisted_1_1[i_2]];
          end ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := List( objects_1, Length );
    hoisted_2_1 := deduped_3_1[k_1];
    hoisted_1_1 := Product( deduped_3_1{[ 1 .. k_1 - 1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, objects_1[k_1], AsLazyArray, LazyArray( Length( P_1 ), function ( i_2 )
              return REM_INT( QUO_INT( i_2, hoisted_1_1 ), hoisted_2_1 );
          end ) );
end
########
        
    , 100 );
    
    ##
    AddTerminalObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Length, 1 );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, AsLazyArray, Concatenation( List( tau_1, AsLazyArray ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, AsLazyArray, LazyStandardInterval( 0 ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := [ 0 .. Length( objects_1 ) - 1 ];
    hoisted_4_1 := deduped_5_1;
    hoisted_2_1 := List( objects_1, Length );
    hoisted_3_1 := List( deduped_5_1, function ( j_2 )
            return Product( hoisted_2_1{[ 1 .. j_2 ]} );
        end );
    hoisted_1_1 := List( tau_1, AsLazyArray );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, AsLazyArray, LazyArray( Length( T_1 ), function ( i_2 )
              return Sum( hoisted_4_1, function ( j_3 )
                      local deduped_1_3;
                      deduped_1_3 := 1 + j_3;
                      return hoisted_1_1[deduped_1_3][i_2] * hoisted_3_1[deduped_1_3];
                  end );
          end ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, AsLazyArray, LazyConstantArray( Length( T_1 ), 0 ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "SkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategoryPrecompiled", function (  )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function (  )
    return SkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategory(  );
end;
        
        
    
    cat := category_constructor(  : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_SkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategoryPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
