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
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "UnderlyingCategory", IsMonoidalCategory );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsCategoryOfInternalHopfMonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfMonoids", IsMonoidalCategory );

CapJitAddTypeSignature( "AssociatedCategoryOfMonoids", [ IsCategoryOfInternalHopfMonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfComonoids", IsMonoidalCategory );

CapJitAddTypeSignature( "AssociatedCategoryOfComonoids", [ IsCategoryOfInternalHopfMonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "AssociatedCategoryOfBimonoids", IsMonoidalCategory );

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
DeclareAttribute( "UnderlyingMonoidMorphism", IsInternalHopfMonoid );

CapJitAddTypeSignature( "UnderlyingMonoidMorphism", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingComonoidMorphism", IsInternalHopfMonoid );

CapJitAddTypeSignature( "UnderlyingComonoidMorphism", [ IsInternalHopfMonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalHopfMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingBimonoidMorphism", IsInternalHopfMonoid );

CapJitAddTypeSignature( "UnderlyingBimonoidMorphism", [ IsInternalHopfMonoid ],
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

#!
DeclareAttribute( "CategoryOfHopfMonoids", IsCapCategory and IsMonoidalCategory );

CapJitAddTypeSignature( "CategoryOfHopfMonoids", [ IsMonoidalCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( CategoryOfHopfMonoids( input_types[1].category ) );
    
end );

DeclareAttribute( "DualHopfMonoid", IsInternalHopfMonoid );

DeclareAttribute( "DualHopfMonoid", IsInternalHopfMonoidMorphism );
