# SPDX-License-Identifier: GPL-2.0-or-later
# InternalModules: Modules over internal algebras
#
# Declarations
#

#! @Chapter Internal comonoids

####################################
##
#! @Section GAP Categories
##
####################################

## categories

#!
DeclareCategory( "IsCategoryOfInternalComonoids", IsCapCategory );

#!
DeclareCategory( "IsInternalComonoid", IsCapCategoryObject );

#!
DeclareCategory( "IsInternalComonoidMorphism", IsCapCategoryMorphism );

####################################
##
#! @Section Properties
##
####################################

#!
DeclareProperty( "IsCocommutative", IsInternalComonoid );

####################################
##
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "UnderlyingCategory", IsCategoryOfInternalComonoids );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsCategoryOfInternalComonoids ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Arguments comonoid
DeclareAttribute( "DefiningTripleOfInternalComonoid",
        IsInternalComonoid );

CapJitAddTypeSignature( "DefiningTripleOfInternalComonoid", [ IsInternalComonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalComonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 3,
                   CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ),
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

#! @Arguments comonoid_morphism
DeclareAttribute( "UnderlyingMorphism",
        IsInternalComonoidMorphism );

CapJitAddTypeSignature( "UnderlyingMorphism", [ IsInternalComonoidMorphism ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalComonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingObject", IsInternalComonoid );

CapJitAddTypeSignature( "UnderlyingObject", [ IsInternalComonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalComonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CATEGORY_OF_COMONOIDS", [ IsCapCategory and IsMonoidalCategory ] );

#!
DeclareAttribute( "CategoryOfComonoids", IsCapCategory and IsMonoidalCategory );

#!
DeclareAttribute( "AssociatedCategoryOfMonoids", IsCategoryOfInternalComonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfMonoids", [ IsCategoryOfInternalComonoids ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalComonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "CoOppositeComonoid", IsInternalComonoid );

CapJitAddTypeSignature( "CoOppositeComonoid", [ IsInternalComonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalComonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

DeclareAttribute( "DualMonoid", IsInternalComonoidMorphism );

#!
DeclareAttribute( "DualMonoid", IsInternalComonoid );

CapJitAddTypeSignature( "DualMonoid", [ IsInternalComonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalComonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfMonoids( input_types[1].category ) );
    
end );

DeclareAttribute( "DualMonoid", IsInternalComonoidMorphism );

#!
DeclareOperation( "TransformedComonoid",
        [ IsCapCategoryMorphism, IsInternalComonoid ] );

CapJitAddTypeSignature( "TransformedComonoid", [ IsCapCategoryMorphism, IsInternalComonoid ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalComonoids( input_types[2].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
    
end );
