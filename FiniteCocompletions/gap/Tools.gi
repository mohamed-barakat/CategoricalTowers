# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

##
InstallMethod( EnrichmentSpecificFiniteStrictCoproductCocompletion,
        "for a category",
        [ IsCapCategory ],
        
  function( C )
    
    if not HasRangeCategoryOfHomomorphismStructure( C ) then
        Error( "the category `C` has no RangeCategoryOfHomomorphismStructure\n" );
    fi;
    
    return EnrichmentSpecificFiniteStrictCoproductCocompletion( C, RangeCategoryOfHomomorphismStructure( C ) );
    
end );

##
InstallMethod( TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure,
        "for an object in a cocartesian category and an object in the its range category of the homomorphism structure",
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  function( d, h )
    local D;
    
    D := CapCategory( d );
    
    return TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( RangeCategoryOfHomomorphismStructure( D ), D, d, h );
    
end );

##
InstallMethod( TensorizeObjectWithMorphismInRangeCategoryOfHomomorphismStructure,
        "an object in a cocartesian category and a morphism in its range category of the homomorphism structure",
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( d, nu )
    local D, H;
    
    D := CapCategory( d );
    H := RangeCategoryOfHomomorphismStructure( D );
    
    return TensorizeObjectWithMorphismInRangeCategoryOfHomomorphismStructure( H, D,
                   TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( H, D, d, Source( nu ) ),
                   d,
                   nu,
                   TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( H, D, d, Range( nu ) ) );
    
end );

##
InstallMethod( TensorizeMorphismWithObjectInRangeCategoryOfHomomorphismStructure,
        "for a morphism in a cocartesian category and an object in its range category of the homomorphism structure",
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( phi, h )
    local D, H;
    
    D := CapCategory( phi );
    H := RangeCategoryOfHomomorphismStructure( D );
    
    return TensorizeMorphismWithObjectInRangeCategoryOfHomomorphismStructure( H, D,
                   TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( H, D, Source( phi ), h ),
                   phi,
                   h,
                   TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure( H, D, Range( phi ), h ) );
    
end );
