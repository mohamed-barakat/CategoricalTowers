# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Declarations
#

####################################
#
#! @Chapter Categories of functors
#! @Section Attributes
#
####################################

DeclareAttribute( "ConvertToCellInFunctorCategory", IsQuiverRepresentation );
DeclareAttribute( "ConvertToCellInFunctorCategory", IsQuiverRepresentationHomomorphism );
DeclareAttribute( "ConvertToCellInCategoryOfQuiverRepresentations", IsObjectInFunctorCategory );
DeclareAttribute( "ConvertToCellInCategoryOfQuiverRepresentations", IsMorphismInFunctorCategory );

#! @Description
#! The input is a Hom-category <A>H</A><C>:=Hom(B,C)</C> where <C>B</C> is an algebroid defined by some quiver algebra <C>A</C> and
#! <C>C</C> is a matrix category over some homalg field <C>K</C>.
#! The output is the isomorphism from <A>H</A> into <C>CategoryOfQuiverRepresentations(A)</C>.
#! @Arguments H
#! @Returns a &CAP; functor
DeclareAttribute( "IsomorphismOntoCategoryOfQuiverRepresentations", IsFunctorCategory );


#! @Description
#! The input is a Hom-category <A>H</A><C>:=Hom(B,C)</C> where <C>B</C> is an algebroid defined by some quiver algebra <C>A</C> and
#! <C>C</C> is a matrix category over some homalg field <C>K</C>.
#! The output is the isomorphism from  <C>CategoryOfQuiverRepresentations(A)</C> into <A>H</A>.
#! @Arguments H
#! @Returns a &CAP; functor
DeclareAttribute( "IsomorphismFromCategoryOfQuiverRepresentations", IsFunctorCategory );

#! @Description
#!  The input is a finitely presented category <A>B</A>. The output is the Yoneda embedding functor from
#!  <A>B</A> into the functors category <C>Hom</C>( <C>OppositeAlgebroid</C>(<A>B</A>),$H$), where
#!  $H$=<C>RangeCategoryOfHomomorphismStructure</C>(<A>B</A>).
#! @Arguments B
#! @Returns a &CAP; functor
DeclareAttribute( "YonedaEmbedding", IsCapCategory );

#! @Description
#!  The input is a category <A>B</A> with finitely many objects equipped with
#!  a homomorphism structure with values in a finite complete and finite cocomplete category <A>H</A>.
#!  The output is the nerve of <A>B</A> truncated in degree $2$,
#!  as an object in the category of presheaves on <C>SimplicialCategoryTruncatedInDegree</C>($2$)
#!  with values in <A>H</A>.
#! @Arguments B
#! @Returns a &CAP; functor
DeclareAttribute( "NerveTruncatedInDegree2", IsCapCategory );
#! @InsertChunk NerveTruncatedInDegree2
