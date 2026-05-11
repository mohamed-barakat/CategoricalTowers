# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

##
InstallMethod( EnrichmentSpecificFiniteStrictCoproductCompletion,
        "for a category",
        [ IsCapCategory ],
        
  function( C )
    
    if not HasRangeCategoryOfHomomorphismStructure( C ) then
        Error( "the category `C` has no RangeCategoryOfHomomorphismStructure\n" );
    fi;
    
    return EnrichmentSpecificFiniteStrictCoproductCompletion( C, RangeCategoryOfHomomorphismStructure( C ) );
    
end );

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
InstallMethodForCompilerForCAP( SchreierSimsOnOrbit,
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsList, IsInt, IsInt, IsInt ],
        
  function ( UCm, automorphisms, c, e, m )
    local C, object, k, data, perms, autos, targets, id, initial_value, predicate, func;
    
    C := UnderlyingCategory( UCm );
    
    object := SetOfObjects( C )[c];
    
    k := Length( automorphisms );
    
    data := List( [ 1 .. k ], r -> PairOfLists( automorphisms[r] ) );
    
    perms := List( [ 1 .. k ], r -> PermList( 1 + data[r][1][c][2] ) );
    
    autos := List( [ 1 .. k ], r -> data[r][2][c] );
    
    id := IdentityMorphism( C, object );
    
    initial_value := NTuple( 4, 1, [ e ], [ id ], [ ] );
    
    predicate :=
      function( tuple_old, tuple_new )
        
        return tuple_new[1] > m;
        
    end;
    
    func :=
      function( tuple )
        local i, B, b_i, T, t_i, S, r, b, t, j;
        
        i := tuple[1];
        
        B := tuple[2];
        b_i := B[i];
        
        T := tuple[3];
        t_i := T[i];
        
        S := tuple[4];
        
        for r in [ 1 .. k ] do
            b := b_i^perms[r];
            
            t := PreCompose( C, t_i, autos[r][b_i] );
            
            j := Position( B, b );
            
            if IsInt( j ) then
                S := Concatenation( S, [ PreCompose( C, t, InverseForMorphisms( C, T[j] ) ) ] );
            else
                B := Concatenation( B, [ b ] );
                T := Concatenation( T, [ t ] );
            fi;
            
        od;
        
        return NTuple( 4, i + 1, B, T, S );
        
    end;
    
    return CapFixpoint( predicate, func, initial_value );
    
end );
