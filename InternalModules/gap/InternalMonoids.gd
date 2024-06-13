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
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "UnderlyingCategory", IsMonoidalCategory );

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

#!
DeclareAttribute( "CategoryOfMonoids", IsCapCategory and IsMonoidalCategory );

CapJitAddTypeSignature( "CategoryOfMonoids", [ IsMonoidalCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( CategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfComonoids", IsCategoryOfInternalMonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfComonoids", [ IsCategoryOfInternalMonoids ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

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
