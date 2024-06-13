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
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "UnderlyingCategory", IsMonoidalCategory );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsCategoryOfInternalBimonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfMonoids", IsMonoidalCategory );

CapJitAddTypeSignature( "AssociatedCategoryOfMonoids", [ IsCategoryOfInternalBimonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfComonoids", IsMonoidalCategory );

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
DeclareAttribute( "UnderlyingMonoidMorphism", IsInternalBimonoid );

CapJitAddTypeSignature( "UnderlyingMonoidMorphism", [ IsInternalBimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingComonoidMorphism", IsInternalBimonoid );

CapJitAddTypeSignature( "UnderlyingComonoidMorphism", [ IsInternalBimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareOperation( "LinearizationOfSetMonoid",
        [ IsMonoidalCategory and IsLinearCategoryOverCommutativeRing, IsMonoid ] );

####################################
##
#! @Section Constructors
##
####################################

#!
DeclareOperation( "CategoryOfBimonoids", [ IsCapCategory and IsMonoidalCategory ] );

CapJitAddTypeSignature( "CategoryOfBimonoids", [ IsMonoidalCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( CategoryOfBimonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "CategoryOfBimonoids2", IsCapCategory and IsMonoidalCategory );

CapJitAddTypeSignature( "CategoryOfBimonoids2", [ IsMonoidalCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( CategoryOfBimonoids2( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "DualBimonoid", IsInternalBimonoid );

CapJitAddTypeSignature( "DualBimonoid", [ IsInternalBimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

DeclareAttribute( "DualBimonoid", IsInternalBimonoidMorphism );

#!
DeclareOperation( "TransformedBimonoid",
        [ IsCapCategoryMorphism, IsInternalBimonoid ] );

CapJitAddTypeSignature( "TransformedBimonoid", [ IsCapCategoryMorphism, IsInternalBimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalBimonoids( input_types[2].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
    
end );
