# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryFromDataTablesPrecompiled", function ( cat )
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), Length, BigInt( 1 ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, range_1, AsList, DataTables( cat_1 )[2][6][1 + IndexOfMorphism( alpha_1 )][1 + IndexOfMorphism( beta_1 )] );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), Length, DataTables( cat_1 )[2][5][1 + IndexOfObject( arg2_1 )][1 + IndexOfObject( arg3_1 )] );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := DataTables( cat_1 )[2];
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( deduped_3_1[1][1 + IndexOfObject( a_1 )] );
    deduped_1_1 := 1 + deduped_2_1;
    return CAP_JIT_INCOMPLETE_LOGIC( CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, deduped_3_1[2][deduped_1_1] ), CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, deduped_3_1[3][deduped_1_1] ), IndexOfMorphism, deduped_2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, range_1, AsList, DataTables( cat_1 )[2][7][1 + IndexOfMorphism( alpha_1 )] );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, source_1, range_1, alpha_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := DataTables( cat_1 )[2];
    deduped_4_1 := CAP_JIT_INCOMPLETE_LOGIC( deduped_5_1[8][1 + IndexOfObject( source_1 )][1 + IndexOfObject( range_1 )][1 + AsList( alpha_1 )[1]] );
    deduped_3_1 := 1 + deduped_4_1;
    return CAP_JIT_INCOMPLETE_LOGIC( CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, deduped_5_1[2][deduped_3_1] ), CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, deduped_5_1[3][deduped_3_1] ), IndexOfMorphism, deduped_4_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IndexOfMorphism( arg2_1 ) = IndexOfMorphism( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IndexOfMorphism( arg2_1 ) = IndexOfMorphism( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IndexOfObject( arg2_1 ) = IndexOfObject( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := IndexOfMorphism( alpha_1 );
    return IsBigInt( deduped_1_1 ) and deduped_1_1 >= 0 and deduped_1_1 < DataTables( cat_1 )[1][2];
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := IndexOfObject( arg2_1 );
    return IsBigInt( deduped_1_1 ) and deduped_1_1 >= 0 and deduped_1_1 < DataTables( cat_1 )[1][1];
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg4_1, IndexOfMorphism, arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return IndexOfMorphism( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return IndexOfObject( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := DataTables( cat_1 )[2];
    deduped_4_1 := CAP_JIT_INCOMPLETE_LOGIC( deduped_5_1[4][1 + IndexOfMorphism( alpha_1 )][1 + IndexOfMorphism( beta_1 )] );
    deduped_3_1 := 1 + deduped_4_1;
    return CAP_JIT_INCOMPLETE_LOGIC( CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, deduped_5_1[2][deduped_3_1] ), CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, deduped_5_1[3][deduped_3_1] ), IndexOfMorphism, deduped_4_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSetOfGeneratingMorphismsOfCategory( cat,
        
########
function ( cat_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := DataTables( cat_1 );
    deduped_4_1 := deduped_5_1[2];
    hoisted_2_1 := deduped_4_1[3];
    hoisted_1_1 := deduped_4_1[2];
    hoisted_3_1 := List( [ 0 .. deduped_5_1[1][2] - 1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := 1 + i_2;
            return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, hoisted_1_1[deduped_1_2] ), CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, hoisted_2_1[deduped_1_2] ), IndexOfMorphism, i_2 );
        end );
    return List( IndicesOfGeneratingMorphisms( cat_1 ), function ( i_2 )
            return hoisted_3_1[1 + i_2];
        end );
end
########
        
    , 100 );
    
    ##
    AddSetOfMorphismsOfFiniteCategory( cat,
        
########
function ( cat_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := DataTables( cat_1 );
    deduped_3_1 := deduped_4_1[2];
    hoisted_2_1 := deduped_3_1[3];
    hoisted_1_1 := deduped_3_1[2];
    return List( [ 0 .. deduped_4_1[1][2] - 1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := 1 + i_2;
            return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, hoisted_1_1[deduped_1_2] ), CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, hoisted_2_1[deduped_1_2] ), IndexOfMorphism, i_2 );
        end );
end
########
        
    , 100 );
    
    ##
    AddSetOfObjectsOfCategory( cat,
        
########
function ( cat_1 )
    return List( [ 0 .. DataTables( cat_1 )[1][1] - 1 ], function ( i_2 )
            return CreateCapCategoryObjectWithAttributes( cat_1, IndexOfObject, i_2 );
        end );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "CategoryFromDataTablesPrecompiled", function ( quiver )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( quiver )
    local sFinSets;
    sFinSets := SkeletalCategoryOfFiniteSets(  : FinalizeCategory := true );
    return CategoryFromDataTables( FreeCategory( quiver : range_of_HomStructure := sFinSets,
          FinalizeCategory := true ) );
end;
        
        
    
    cat := category_constructor( quiver : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryFromDataTablesPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
