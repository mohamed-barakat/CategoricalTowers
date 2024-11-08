# SPDX-License-Identifier: GPL-2.0-or-later
# FpCategories: Finitely presented categories by generating quivers and relations
#
# Declarations
#

#! @Chapter Prop of path category

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of props of path categories.
DeclareCategory( "IsPropOfPathCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; category of objects in the prop of path categories.
DeclareCategory( "IsObjectInPropOfPathCategory",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in the prop of path categories.
DeclareCategory( "IsMorphismInPropOfPathCategory",
        IsCapCategoryMorphism );

####################################
#
#! @Section Attributes
#
####################################

#! @Description
#!  Returns the index of the object <A>v</A>.
#! @Arguments v
#! @Returns a positive integer
DeclareAttribute( "ObjectIndex", IsPropOfPathCategory );

CapJitAddTypeSignature( "ObjectIndex", [ IsPropOfPathCategory ], IsBigInt );

DeclareAttribute( "MorphismListOfTriples", IsObjectInPropOfPathCategory );

####################################
#
#! @Section Constructors
#
####################################

if false then
DeclareGlobalVariable( "PropOfPathCategory" );
fi;

DeclareOperation( "PreSheafEncodingPathCategory", [ IsFinQuiver ] );

