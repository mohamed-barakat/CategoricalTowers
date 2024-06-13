# SPDX-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Declarations
#

#! @Chapter Internal Hopf monoids

####################################
##
#! @Section GAP Categories
##
####################################

## categories

#!
DeclareCategory( "IsCategoryOfInternalHopfMonoids", IsCapCategory );

#!
DeclareCategory( "IsInternalHopfMonoid", IsCapCategoryObject );

#!
DeclareCategory( "IsInternalHopfMonoidMorphism", IsCapCategoryMorphism );

####################################
##
#! @Section Properties
##
####################################

#!
DeclareProperty( "IsCommutative", IsInternalHopfMonoid );

#!
DeclareProperty( "IsCocommutative", IsInternalHopfMonoid );

####################################
##
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "UnderlyingCategory", IsCategoryOfInternalHopfMonoids );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsCategoryOfInternalHopfMonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfMonoids", IsCategoryOfInternalHopfMonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfMonoids", [ IsCategoryOfInternalHopfMonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfComonoids", IsCategoryOfInternalHopfMonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfComonoids", [ IsCategoryOfInternalHopfMonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfBimonoids", IsCategoryOfInternalHopfMonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfBimonoids", [ IsCategoryOfInternalHopfMonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfBimonoids( input_types[1].category ) );
    
end );

#! @Arguments dimonoid
DeclareAttribute( "DefiningSextupleOfInternalHopfMonoid",
        IsInternalHopfMonoid );

CapJitAddTypeSignature( "DefiningSextupleOfInternalHopfMonoid", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 6,
                   CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

#! @Arguments dimonoid_morphism
DeclareAttribute( "UnderlyingMorphism",
        IsInternalHopfMonoidMorphism );

CapJitAddTypeSignature( "UnderlyingMorphism", [ IsInternalHopfMonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingObject", IsInternalHopfMonoid );

CapJitAddTypeSignature( "UnderlyingObject", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingMonoid", IsInternalHopfMonoid );

CapJitAddTypeSignature( "UnderlyingMonoid", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingComonoid", IsInternalHopfMonoid );

CapJitAddTypeSignature( "UnderlyingComonoid", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingBimonoid", IsInternalHopfMonoid );

CapJitAddTypeSignature( "UnderlyingBimonoid", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfBimonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingMonoidMorphism", IsInternalHopfMonoidMorphism );

CapJitAddTypeSignature( "UnderlyingMonoidMorphism", [ IsInternalHopfMonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingComonoidMorphism", IsInternalHopfMonoidMorphism );

CapJitAddTypeSignature( "UnderlyingComonoidMorphism", [ IsInternalHopfMonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingBimonoidMorphism", IsInternalHopfMonoidMorphism );

CapJitAddTypeSignature( "UnderlyingBimonoidMorphism", [ IsInternalHopfMonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfBimonoids( input_types[1].category ) );
    
end );

#!
DeclareOperation( "LinearizationOfSetGroup",
        [ IsMonoidalCategory and IsLinearCategoryOverCommutativeRing, IsGroup ] );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CATEGORY_OF_HOPF_MONOIDS", [ IsCapCategory and IsMonoidalCategory ] );

#!
DeclareAttribute( "CategoryOfHopfMonoids", IsCapCategory and IsMonoidalCategory );

#!
DeclareAttribute( "OppositeHopfMonoid", IsInternalHopfMonoid );

CapJitAddTypeSignature( "OppositeHopfMonoid", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

#!
DeclareAttribute( "CoOppositeHopfMonoid", IsInternalHopfMonoid );

CapJitAddTypeSignature( "CoOppositeHopfMonoid", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

#!
DeclareAttribute( "OppositeCoOppositeHopfMonoid", IsInternalHopfMonoid );

CapJitAddTypeSignature( "OppositeCoOppositeHopfMonoid", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

#!
DeclareOperation( "TransformedHopfMonoid",
        [ IsCapCategoryMorphism, IsInternalHopfMonoid ] );

CapJitAddTypeSignature( "TransformedHopfMonoid", [ IsCapCategoryMorphism, IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[2].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
    
end );

##
DeclareOperation( "Pullback",
        [ IsHomalgRingMap, IsInternalHopfMonoid ] );
