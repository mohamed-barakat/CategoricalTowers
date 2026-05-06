# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

##
InstallMethod( EnrichmentSpecificFiniteStrictCoproductCompletion,
        "for a category",
        [ IsCapCategory ],
        
  FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, C )
    
    if not HasRangeCategoryOfHomomorphismStructure( C ) then
        Error( "the category `C` has no RangeCategoryOfHomomorphismStructure\n" );
    fi;
    
    return EnrichmentSpecificFiniteStrictCoproductCompletion( C, RangeCategoryOfHomomorphismStructure( C ) : FinalizeCategory := CAP_NAMED_ARGUMENTS.FinalizeCategory );
    
end ) );

##
InstallMethod( TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure,
        "for an object in a cocartesian category and an object in the its range category of the homomorphism structure",
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  function( c, h )
    local UC;
    
    UC := EnrichmentSpecificFiniteStrictCoproductCompletion( CapCategory( c ) );
    
    return TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( RangeCategoryOfHomomorphismStructure( UC ), UC, c, h );
    
end );

##
InstallMethod( TensorizeObjectWithMorphismInRangeCategoryOfHomomorphismStructure,
        "an object in a cocartesian category and a morphism in its range category of the homomorphism structure",
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( c, nu )
    local UC, H;
    
    UC := EnrichmentSpecificFiniteStrictCoproductCompletion( CapCategory( c ) );
    H := RangeCategoryOfHomomorphismStructure( UC );
    
    return TensorizeObjectWithMorphismInRangeCategoryOfHomomorphismStructure( H, UC,
                   TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( H, UC, c, Source( nu ) ),
                   c,
                   nu,
                   TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( H, UC, c, Target( nu ) ) );
    
end );

##
InstallMethod( TensorizeMorphismWithObjectInRangeCategoryOfHomomorphismStructure,
        "for a morphism in a cocartesian category and an object in its range category of the homomorphism structure",
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( phi, h )
    local UC, H;
    
    UC := EnrichmentSpecificFiniteStrictCoproductCompletion( CapCategory( phi ) );
    H := RangeCategoryOfHomomorphismStructure( UC );
    
    return TensorizeMorphismWithObjectInRangeCategoryOfHomomorphismStructure( H, UC,
                   TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( H, UC, Source( phi ), h ),
                   phi,
                   h,
                   TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( H, UC, Target( phi ), h ) );
    
end );

##
InstallGlobalFunction( SKELETAL_CATEGORY_OF_FINITE_SETS_IsMonomorphism,
  function ( imgs, t )
    local testList, img;
    
    testList := ListWithIdenticalEntries( t, false );
    
    for img in imgs do
        if testList[1 + img] then
            return false;
        fi;
        testList[1 + img] := true;
    od;
    
    return true;
    
end );

##
InstallGlobalFunction( SKELETAL_CATEGORY_OF_FINITE_SETS_IsEpimorphism,
  function ( imgs, t )
    local testList, img;
    
    testList := ListWithIdenticalEntries( t, false );
    
    for img in imgs do
        testList[1 + img] := true;
    od;
    
    return testList;
    
end );

##
InstallMethod( SchreierSimsOnASingleOrbit,
        [ IsList, IsInt, IsInt, IsInt ],
        
  function ( perms, k, b, m )
    local B, T, S, i, b_i, r, p;
    
    B := [ b ];
    T := [ ];
    S := [ ];
    
    for i in [ 1 .. m ] do ## while i <= Length( B )
        
        b_i := B[i];
        
        for r in [ 1 .. k ] do
            
            b := b_i^perms[r];
            
            p := Position( B, b );
            
            if p = fail then
                Add( B, b );
                Add( T, NTuple( 3, i, b_i, r ) );
            else
                Add( S, NTuple( 4, i, b_i, r, p ) );
            fi;
            
        od;
        
    od;
    
    return Triple( B, T, S );
    
end );
