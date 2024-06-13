# SPDX-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Declarations
#

#! @Chapter Internal dimonoids

####################################
##
#! @Section GAP Categories
##
####################################

## categories

#!
DeclareCategory( "IsCategoryOfInternalDimonoids", IsCapCategory );

#!
DeclareCategory( "IsInternalDimonoid", IsCapCategoryObject );

#!
DeclareCategory( "IsInternalDimonoidMorphism", IsCapCategoryMorphism );

####################################
##
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "UnderlyingCategory", IsCategoryOfInternalDimonoids );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsCategoryOfInternalDimonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfMonoids", IsMonoidalCategory );

CapJitAddTypeSignature( "AssociatedCategoryOfMonoids", [ IsCategoryOfInternalDimonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfComonoids", IsMonoidalCategory );

CapJitAddTypeSignature( "AssociatedCategoryOfComonoids", [ IsCategoryOfInternalDimonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#! @Arguments dimonoid
DeclareAttribute( "DefiningQuintupleOfInternalDimonoid",
        IsInternalDimonoid );

CapJitAddTypeSignature( "DefiningQuintupleOfInternalDimonoid", [ IsInternalDimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalDimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 5,
                   CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

#! @Arguments dimonoid_morphism
DeclareAttribute( "UnderlyingMorphism",
        IsInternalDimonoidMorphism );

CapJitAddTypeSignature( "UnderlyingMorphism", [ IsInternalDimonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalDimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingObject", IsInternalDimonoid );

CapJitAddTypeSignature( "UnderlyingObject", [ IsInternalDimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalDimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingMonoid", IsInternalDimonoid );

CapJitAddTypeSignature( "UnderlyingMonoid", [ IsInternalDimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalDimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingComonoid", IsInternalDimonoid );

CapJitAddTypeSignature( "UnderlyingComonoid", [ IsInternalDimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalDimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingMonoidMorphism", IsInternalDimonoid );

CapJitAddTypeSignature( "UnderlyingMonoidMorphism", [ IsInternalDimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalDimonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingComonoidMorphism", IsInternalDimonoid );

CapJitAddTypeSignature( "UnderlyingComonoidMorphism", [ IsInternalDimonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalDimonoids( input_types[1].category ) );
    
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
DeclareAttribute( "CategoryOfDimonoids", IsCapCategory and IsMonoidalCategory );

CapJitAddTypeSignature( "CategoryOfDimonoids", [ IsMonoidalCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( CategoryOfDimonoids( input_types[1].category ) );
    
end );

DeclareAttribute( "DualDimonoid", IsInternalDimonoid );

DeclareAttribute( "DualDimonoid", IsInternalDimonoidMorphism );
