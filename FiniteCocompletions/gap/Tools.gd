# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Declarations
#

#! @Chapter Tools

####################################
#
#! @Section Operations
#
####################################

DeclareOperation( "EnrichmentSpecificFiniteStrictCoproductCocompletion",
        [ IsCapCategory, IsCapCategory ] );

#! @Description
#!  The arguments are an ojbect <A>objD</A> in a cocartesian category $D$ and
#!  an object <A>objH</A> in $H :=$ <C>RangeCategoryOfHomomorphismStructure</C>( $D$ ).
#!  The output is an object in $D$, namely the tensor product <A>objD</A> $\otimes$ <A>objH</A>,
#!  i.e., the coproduct of $l$ copies of <A>objD</A>, where $l :=$ <C>ObjectDatum</C>( <A>objH</A> )
#!  is a nonnegative integer.
#! @Arguments objD, objH
#! @Returns a &CAP; object
DeclareOperation( "TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure",
        [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  The arguments are an ojbect <A>objD</A> in a cocartesian category $D$ and
#!  a morphism <A>morH</A> in $H :=$ <C>RangeCategoryOfHomomorphismStructure</C>( $D$ ).
#!  The output is a morphism in $D$, namely the tensor product <A>objD</A> $\otimes$ <A>morH</A>,
#!  i.e., the morphism induced by <A>morH</A> from the coproduct of $t$ copies of <A>objC</A>
#!  to the coproduct of $t$ copies of <A>objC</A>, where
#!  $s :=$ <C>ObjectDatum</C>( <C>Source</C>( <A>morH</A> ) ) and
#!  $t :=$ <C>ObjectDatum</C>( <C>Range</C>( <A>morH</A> ) ).
#! @Arguments objD, morH
#! @Returns a &CAP; morphism
DeclareOperation( "TensorizeObjectWithMorphismInRangeCategoryOfHomomorphismStructure",
        [ IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#!  The arguments are a morphism <A>morD</A> in a cocartesian category $D$ and
#!  an object <A>objH</A> in $H :=$ <C>RangeCategoryOfHomomorphismStructure</C>( $D$ ).
#!  The output is a morphism in $D$, namely the tensor product <A>morD</A> $\otimes$ <A>objH</A>,
#!  i.e., the morphism induced by <A>morD</A> of the coproduct of $l$ copies of <C>Source</C>( <A>morD</A> )
#!  to the coproduct of $l$ copies of <C>Range</C>( <A>morD</A> ), where
#!  $l :=$ <C>ObjectDatum</C>( <A>objH</A> ).
#! @Arguments morD, objH
#! @Returns a &CAP; morphism
DeclareOperation( "TensorizeMorphismWithObjectInRangeCategoryOfHomomorphismStructure",
        [ IsCapCategoryMorphism, IsCapCategoryObject ] );
