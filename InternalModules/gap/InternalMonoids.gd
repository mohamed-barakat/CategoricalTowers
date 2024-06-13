# SPDX-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Declarations
#

#! @Chapter Internal monoids

####################################
##
#! @Section GAP Categories
##
####################################

## categories

#!
DeclareCategory( "IsCategoryOfInternalMonoids", IsCapCategory );

#!
DeclareCategory( "IsInternalMonoid", IsCapCategoryObject );

#!
DeclareCategory( "IsInternalMonoidMorphism", IsCapCategoryMorphism );

####################################
##
#! @Section Properties
##
####################################

#!
DeclareProperty( "IsCommutative", IsInternalMonoid );

####################################
##
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "UnderlyingCategory", IsCategoryOfInternalMonoids );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsCategoryOfInternalMonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Arguments monoid
DeclareAttribute( "DefiningTripleOfInternalMonoid",
        IsInternalMonoid );

CapJitAddTypeSignature( "DefiningTripleOfInternalMonoid", [ IsInternalMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 3,
                   CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

#! @Arguments monoid_morphism
DeclareAttribute( "UnderlyingMorphism",
        IsInternalMonoidMorphism );

CapJitAddTypeSignature( "UnderlyingMorphism", [ IsInternalMonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingObject", IsInternalMonoid );

CapJitAddTypeSignature( "UnderlyingObject", [ IsInternalMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CATEGORY_OF_MONOIDS", [ IsCapCategory and IsMonoidalCategory ] );

#!
DeclareAttribute( "CategoryOfMonoids", IsCapCategory and IsMonoidalCategory );

#!
DeclareAttribute( "AssociatedCategoryOfComonoids", IsCategoryOfInternalMonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfComonoids", [ IsCategoryOfInternalMonoids ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "OppositeMonoid", IsInternalMonoid );

CapJitAddTypeSignature( "OppositeMonoid", [ IsInternalMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

DeclareAttribute( "DualComonoid", IsInternalMonoidMorphism );

#!
DeclareAttribute( "DualComonoid", IsInternalMonoid );

CapJitAddTypeSignature( "DualComonoid", [ IsInternalMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

DeclareAttribute( "DualComonoid", IsInternalMonoidMorphism );

#!
DeclareOperation( "TransformedMonoid",
        [ IsCapCategoryMorphism, IsInternalMonoid ] );

CapJitAddTypeSignature( "TransformedMonoid", [ IsCapCategoryMorphism, IsInternalMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[2].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
    
end );
