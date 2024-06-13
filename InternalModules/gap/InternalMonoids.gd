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

#!
DeclareAttribute( "AssociatedCategoryOfComonoids", IsCategoryOfInternalMonoids );

CapJitAddTypeSignature( "AssociatedCategoryOfComonoids", [ IsCategoryOfInternalMonoids ],
  function ( input_types )
    
    Assert( 0, IsCategoryOfInternalMonoids( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( AssociatedCategoryOfComonoids( input_types[1].category ) );
    
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

DeclareAttribute( "UnderlyingAlgebra", IsInternalMonoid );

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
## @Section Operations
##
####################################

DeclareOperation( "LeftUnitLawOfMonoid",
        [ IsMonoidalCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

CapJitAddTypeSignature( "LeftUnitLawOfMonoid", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function ( input_types )
    local cat;
    
    cat := input_types[1].category;
    
    Assert( 0, IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( input_types[2].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[3].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[4].category, cat ) );
    
    return rec( filter := IsBool );
    
end );

DeclareOperation( "RightUnitLawOfMonoid",
        [ IsMonoidalCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

CapJitAddTypeSignature( "RightUnitLawOfMonoid", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function ( input_types )
    local cat;
    
    cat := input_types[1].category;
    
    Assert( 0, IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( input_types[2].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[3].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[4].category, cat ) );
    
    return rec( filter := IsBool );
    
end );

DeclareOperation( "AssociativitiyLawOfMonoid",
        [ IsMonoidalCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

CapJitAddTypeSignature( "AssociativitiyLawOfMonoid", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function ( input_types )
    local cat;
    
    cat := input_types[1].category;
    
    Assert( 0, IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( input_types[2].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[3].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[4].category, cat ) );
    
    return rec( filter := IsBool );
    
end );

DeclareOperation( "UnitLawOfMonoidMorphism",
        [ IsMonoidalCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

CapJitAddTypeSignature( "UnitLawOfMonoidMorphism", [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function ( input_types )
    local cat;
    
    cat := input_types[1].category;
    
    Assert( 0, IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( input_types[2].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[3].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[4].category, cat ) );
    
    return rec( filter := IsBool );
    
end );

DeclareOperation( "MultiplicativelyLawOfMonoidMorphism",
        [ IsMonoidalCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

CapJitAddTypeSignature( "MultiplicativelyLawOfMonoidMorphism", [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function ( input_types )
    local cat;
    
    cat := input_types[1].category;
    
    Assert( 0, IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( input_types[2].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[3].category, cat ) );
    Assert( 0, IsIdenticalObj( input_types[4].category, cat ) );
    
    return rec( filter := IsBool );
    
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
DeclareAttribute( "OppositeMonoid", IsInternalMonoid );

#!
DeclareAttribute( "DualComonoid", IsInternalMonoid );

#!
DeclareAttribute( "DualComonoid", IsInternalMonoidMorphism );

#!
DeclareOperation( "TransformedMonoid",
        [ IsCapCategoryMorphism, IsInternalMonoid ] );

#!
DeclareOperation( "AlgebraAsInternalMonoid",
        [ IsCapCategory and IsObjectFiniteCategory and IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms ] );
