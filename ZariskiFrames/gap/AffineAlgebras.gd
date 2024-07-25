# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Declarations
#

#! @Chapter Affine algebras

####################################
##
#! @Section GAP Categories
##
####################################

## categories

#!
DeclareCategory( "IsCategoryOfAffineAlgebras", IsCapCategory );

#!
DeclareCategory( "IsAffineAlgebra", IsCapCategoryObject );

#!
DeclareCategory( "IsAffineAlgebraMorphism", IsCapCategoryMorphism );

####################################
##
#! @Section Attributes
##
####################################

#!
DeclareAttribute( "CoefficientsRing", IsCategoryOfAffineAlgebras );

CapJitAddTypeSignature( "CoefficientsRing", [ IsCategoryOfAffineAlgebras ],
  function ( input_types )
    
    return CapJitDataTypeOfRing( CoefficientsRing( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "DefiningQuintupleOfAffineAlgebra",
        IsAffineAlgebra );

#!
DeclareAttribute( "AmbientAlgebra",
        IsAffineAlgebra );

#!
DeclareAttribute( "MatrixOfImages",
        IsAffineAlgebraMorphism );

DeclareAttribute( "AssociatedHomalgRing",
        IsAffineAlgebra );

DeclareAttribute( "AssociatedHomalgRingMap",
        IsAffineAlgebraMorphism );

DeclareOperation( "AssociatedHomalgRingOfCoproduct",
        [ IsAffineAlgebra, IsAffineAlgebra ] );

DeclareAttribute( "CoordinateAlgebraOfGraph",
        IsAffineAlgebraMorphism );

####################################
##
# @Section Operations
##
####################################

DeclareOperation( "IsomorphismsToStandardizedAlgebra",
        [ IsCategoryOfAffineAlgebras, IsAffineAlgebra, IsInt ] );

DeclareOperation( "IsomorphismsToStandardizedAlgebraMorphism",
        [ IsCategoryOfAffineAlgebras, IsAffineAlgebraMorphism ] );

####################################
##
#! @Section Constructors
##
####################################

#!
DeclareAttribute( "CategoryOfAffineAlgebras", IsHomalgRing );

CapJitAddTypeSignature( "CategoryOfAffineAlgebras", [ IsHomalgRing ], function ( input_types )
    
    return CapJitDataTypeOfCategory( CategoryOfAffineAlgebras( input_types[1].category ) );
    
end );
