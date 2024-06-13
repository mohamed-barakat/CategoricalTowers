# SPDX-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Declarations
#

#! @Chapter Internal bimonoids

####################################
##
#! @Section GAP Categories
##
####################################

## categories

#!
DeclareCategory( "IsCategoryOfInternalBimonoids", IsCapCategory );

#!
DeclareCategory( "IsInternalBimonoid", IsCapCategoryObject );

#!
DeclareCategory( "IsInternalBimonoidMorphism", IsCapCategoryMorphism );

####################################
##
#! @Section Properties
##
####################################

#!
DeclareProperty( "IsCommutative", IsInternalBimonoid );

#!
DeclareProperty( "IsCocommutative", IsInternalBimonoid );

####################################
##
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "UnderlyingCategory", IsCategoryOfInternalBimonoids );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsCategoryOfInternalBimonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfMonoids", IsCategoryOfInternalBimonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfMonoids", [ IsCategoryOfInternalBimonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfComonoids", IsCategoryOfInternalBimonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfComonoids", [ IsCategoryOfInternalBimonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#! @Arguments bimonoid
DeclareAttribute( "DefiningQuintupleOfInternalBimonoid",
        IsInternalBimonoid );

CapJitAddTypeSignature( "DefiningQuintupleOfInternalBimonoid", [ IsInternalBimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 5,
                   CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

#! @Arguments bimonoid_morphism
DeclareAttribute( "UnderlyingMorphism",
        IsInternalBimonoidMorphism );

CapJitAddTypeSignature( "UnderlyingMorphism", [ IsInternalBimonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingObject", IsInternalBimonoid );

CapJitAddTypeSignature( "UnderlyingObject", [ IsInternalBimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingMonoid", IsInternalBimonoid );

CapJitAddTypeSignature( "UnderlyingMonoid", [ IsInternalBimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingComonoid", IsInternalBimonoid );

CapJitAddTypeSignature( "UnderlyingComonoid", [ IsInternalBimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingMonoidMorphism", IsInternalBimonoidMorphism );

CapJitAddTypeSignature( "UnderlyingMonoidMorphism", [ IsInternalBimonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingComonoidMorphism", IsInternalBimonoidMorphism );

CapJitAddTypeSignature( "UnderlyingComonoidMorphism", [ IsInternalBimonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareOperation( "LinearizationOfSetMonoid",
        [ IsMonoidalCategory and IsLinearCategoryOverCommutativeRing, IsMonoid ] );

#!
DeclareAttribute( "AffineVarietyOfBimonoids", IsInternalMonoid );

#!
DeclareAttribute( "AffineVarietyOfBimonoids", IsInternalComonoid );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CATEGORY_OF_BIMONOIDS_AS_COMONOIDS_OF_MONOIDS", [ IsCapCategory and IsMonoidalCategory ] );

DeclareOperation( "CATEGORY_OF_BIMONOIDS_AS_MONOIDS_OF_COMONOIDS", [ IsCapCategory and IsMonoidalCategory ] );

#!
DeclareAttribute( "CategoryOfBimonoids", IsCapCategory and IsMonoidalCategory );

#!
DeclareAttribute( "CategoryOfBimonoidsAsComonoidsOfMonoids", IsCapCategory and IsMonoidalCategory );

#!
DeclareAttribute( "CategoryOfBimonoidsAsMonoidsOfComonoids", IsCapCategory and IsMonoidalCategory );

#!
DeclareAttribute( "OppositeBimonoid", IsInternalBimonoid );

#!
DeclareAttribute( "CoOppositeBimonoid", IsInternalBimonoid );

#!
DeclareAttribute( "OppositeCoOppositeBimonoid", IsInternalBimonoid );

#!
DeclareOperation( "TransformedBimonoid",
        [ IsCapCategoryMorphism, IsInternalBimonoid ] );

DeclareOperation( "Bimonoid",
        [ IsInternalMonoid, IsList, IsList ] );
#!
DeclareOperation( "Bimonoid",
        [ IsInternalMonoid, IsRecord, IsRecord ] );
