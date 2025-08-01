# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Declarations
#

#! @Chapter Linear closures of path categories and their quotients

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Returns the $k$-linear closure category of <A>C</A>.
#! @Arguments k, C
#! @Returns a &CAP; category
DeclareOperation( "LinearClosure", [ IsHomalgRing, IsPathCategory ] );

#! @Description
#!  Returns a the quotient category of <A>kC</A> modulo the two-sided ideal generated by <A>relations</A>.
#!  This method requires the Groebner basis of <A>relations</A> to be a finite set.
#! @Arguments kC, relations
#! @Returns a list of morphisms
DeclareOperation( "QuotientCategory", [ IsLinearClosure, IsDenseList ] );
#! @InsertChunk QuotientCategoriesOfLinearClosuresOfPathCategories
#! @InsertChunk GroebnerBasisForLinearClosuresOfPathCategories

####################################
#
# @Section Attributes
#
####################################

DeclareAttribute( "DefiningRelations", IsQuotientCategory );
DeclareAttribute( "GroebnerBasisOfDefiningRelations", IsQuotientCategory );

####################################
#
#! @Section Operations
#
####################################

#! @Description
#!  Returns the Groebner basis of the two-sided ideal generated by <A>relations</A>.
#! @Arguments kC, relations
#! @Returns a list of morphisms
DeclareOperation( "GroebnerBasis", [ IsLinearClosure, IsDenseList ] );

#! @Description
#!  Returns a reduced Groebner basis of the two-sided ideal generated by <A>relations</A>.
#! @Arguments kC, relations
#! @Returns a list of morphisms
DeclareOperation( "ReducedGroebnerBasis", [ IsLinearClosure, IsDenseList ] );

DeclareOperation( "ReducedGroebnerBasisWithGivenGroebnerBasis", [ IsLinearClosure, IsDenseList ] );

DeclareGlobalFunction( "INSTALL_VIEW_AND_DISPLAY_METHODS_IN_LINEAR_CLOSURES_OF_PATH_CATEGORIES_OR_THEIR_QUOTIENTS" );
DeclareGlobalFunction( "INSTALL_VIEW_AND_DISPLAY_METHODS_IN_QUOTIENT_CATEGORIES_OF_LINEAR_CLOSURES_OF_PATH_CATEGORIES_OR_THEIR_QUOTIENTS" );
DeclareGlobalFunction( "INSTALL_CANONICAL_REPRESENTATIVE_METHODS_IN_QUOTIENT_CATEGORIES_OF_LINEAR_CLOSURES_OF_PATH_CATEGORIES_OR_THEIR_QUOTIENTS" );

DeclareOperation( "EvaluateLinearClosureMorphism",
        [ IsLinearClosure, IsLinearClosureMorphism, IsCapCategory, IsCapCategoryObject, IsList ] );

DeclareOperation( "ExtendFunctorToAlgebroidData",
        [ IsLinearClosure, IsList, IsCapCategory ] );
