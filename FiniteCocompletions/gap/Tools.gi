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
InstallMethodForCompilerForCAP( SchreierSimsOnASingleOrbit,
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsList, IsInt, IsInt, IsInt ],
        
  function ( UCm, automorphisms, c, e, m )
    local C, object, k, autos, targets, id, initial_value, predicate, data, perms, func;
    
    C := UnderlyingCategory( UCm );
    
    object := SetOfObjects( C )[c];
    
    k := Length( automorphisms );
    
    id := IdentityMorphism( C, object );
    
    #initial_value := NTuple( 4, 1, [ e ], [ id ], CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( C ) ) ) );
    initial_value := NTuple( 4, 1, [ e ], [ id ], [ id ] );
    
    if k = 0 then
        return initial_value;
    fi;
    
    predicate :=
      function( tuple_old, tuple_new )
        
        return tuple_new[1] > m;
        
    end;
    
    data := List( [ 1 .. k ], r -> PairOfLists( automorphisms[r] ) );
    
    perms := List( [ 1 .. k ], r -> PermList( List( data[r][1][c][2], i -> 1 + i ) ) );
    
    autos := List( [ 1 .. k ], r -> data[r][2][c] );
    
    func :=
      function( tuple )
        local i, B, b_i, T, t_i, S, loop_initial_value, loop_predicate, loop_func, loop;
        
        i := tuple[1];
        
        B := tuple[2];
        b_i := B[i];
        
        T := tuple[3];
        t_i := T[i];
        
        S := tuple[4];
        
        loop_initial_value := NTuple( 4, 1, B, T, S );
        
        loop_predicate :=
          function( loop_tuple_old, loop_tuple_new )
            
            return loop_tuple_new[1] = k + 1;
            
        end;
        
        loop_func :=
          function( loop_tuple )
            local r, B, T, S, b, t, j;
            
            r := loop_tuple[1];
            
            B := loop_tuple[2];
            
            T := loop_tuple[3];
            
            S := loop_tuple[4];
            
            b := b_i^perms[r];
            
            t := PreCompose( C, t_i, autos[r][b_i] );
            
            j := Position0( B, b );
            
            if j > 0 then
                
                return NTuple( 4,
                               r + 1,
                               B,
                               T,
                               ## this is the only line we need to compile
                               Concatenation( S, [ PreCompose( C, t, InverseForMorphisms( C, T[j] ) ) ] ) );
                
            else
                
                return NTuple( 4,
                               r + 1,
                               Concatenation( B, [ b ] ),
                               Concatenation( T, [ t ] ),
                               S );
                
            fi;
            
        end;
        
        loop := CapFixpoint( loop_predicate, loop_func, loop_initial_value );
        
        return NTuple( 4, i + 1, loop[2], loop[3], loop[4] );
        
    end;
    
    return CapFixpoint( predicate, func, initial_value );
    
end );
