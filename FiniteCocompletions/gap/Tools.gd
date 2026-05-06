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

DeclareOperation( "EnrichmentSpecificFiniteStrictCoproductCompletion",
        [ IsCapCategory, IsCapCategory ] );

#! @Description
#!  The arguments are an ojbect <A>objC</A> in a category $C$ and
#!  an object <A>objH</A> in $H :=$ <C>RangeCategoryOfHomomorphismStructure</C>( $C$ ).
#!  The output is an object in <C>EnrichmentSpecificFiniteStrictCoproductCompletion</C>( $C$ ),
#!  namely the tensor product <A>objC</A> $\otimes$ <A>objH</A>, i.e.,
#!  the formal coproduct of $l$ copies of <A>objC</A>, where $l :=$ <C>ObjectDatum</C>( <A>objH</A> )
#!  is a nonnegative integer.
#! @Arguments objC, objH
#! @Returns a &CAP; object
DeclareOperation( "TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure",
        [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  The arguments are an ojbect <A>objC</A> in a cocartesian category $C$ and
#!  a morphism <A>morH</A> in $H :=$ <C>RangeCategoryOfHomomorphismStructure</C>( $C$ ).
#!  The output is a morphism in <C>EnrichmentSpecificFiniteStrictCoproductCompletion</C>( $C$ ),
#!  namely the tensor product <A>objC</A> $\otimes$ <A>morH</A>, i.e.,
#!  the morphism induced by <A>morH</A> from the formal coproduct of $t$ copies of <A>objC</A>
#!  to the formal coproduct of $t$ copies of <A>objC</A>, where
#!  $s :=$ <C>ObjectDatum</C>( <C>Source</C>( <A>morH</A> ) ) and
#!  $t :=$ <C>ObjectDatum</C>( <C>Range</C>( <A>morH</A> ) ).
#! @Arguments objC, morH
#! @Returns a &CAP; morphism
DeclareOperation( "TensorizeObjectWithMorphismInRangeCategoryOfHomomorphismStructure",
        [ IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#!  The arguments are a morphism <A>morC</A> in a cocartesian category $C$ and
#!  an object <A>objH</A> in $H :=$ <C>RangeCategoryOfHomomorphismStructure</C>( $C$ ).
#!  The output is a morphism in <C>EnrichmentSpecificFiniteStrictCoproductCompletion</C>( $C$ ),
#!  namely the tensor product <A>morC</A> $\otimes$ <A>objH</A>, i.e.,
#!  the morphism induced by <A>morC</A> of the formal coproduct of $l$ copies of <C>Source</C>( <A>morC</A> )
#!  to the formal coproduct of $l$ copies of <C>Range</C>( <A>morC</A> ), where
#!  $l :=$ <C>ObjectDatum</C>( <A>objH</A> ).
#! @Arguments morC, objH
#! @Returns a &CAP; morphism
DeclareOperation( "TensorizeMorphismWithObjectInRangeCategoryOfHomomorphismStructure",
        [ IsCapCategoryMorphism, IsCapCategoryObject ] );
#! @InsertChunk CharacteristicMatrix

# Technical functions
DeclareGlobalFunction( "SKELETAL_CATEGORY_OF_FINITE_SETS_IsMonomorphism" );
CapJitAddTypeSignature( "SKELETAL_CATEGORY_OF_FINITE_SETS_IsMonomorphism", [ IsList, IsBigInt ], IsBool );

DeclareGlobalFunction( "SKELETAL_CATEGORY_OF_FINITE_SETS_IsEpimorphism" );
CapJitAddTypeSignature( "SKELETAL_CATEGORY_OF_FINITE_SETS_IsEpimorphism", [ IsList, IsBigInt ], CapJitDataTypeOfListOf( IsBool ) );

#! @Description
#!  The input is <A>UCm</A> $:=$ <C>FiniteStrictCoproductCompletionOfObjectFiniteCategory</C>( $C$ ) an object-finite category $C$,
#!  a list <A>autos</A> of $k$ many automorphisms in $C$,
#!  an index <A>c</A> of an object in $C$ (a positive integer),
#!  and an integer $i$ and the length $m$ of its orbit under the permutation parts of the automorphisms of the object of index <A>c</A> in $C$.
#!  The output is a pair of lists of automorphisms of $C$
#!  corresponding to a list of $m$ transversals and to a list of $m k - (m-1)$ of generators of the stabilizier.
#! @Arguments UCm, autos, c, e, m
#! @Returns a list integers
DeclareOperation( "SchreierSimsOnOrbit",
        [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsList, IsInt, IsInt, IsInt ] );

CapJitAddTypeSignature( "SchreierSimsOnOrbit", [ IsFiniteStrictCoproductCompletionOfObjectFiniteCategory, IsList, IsInt, IsInt, IsInt ], function ( input_types )
    local type_of_list;
    
    type_of_list := CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 4,
                   IsInt,
                   CapJitDataTypeOfListOf( IsInt ),
                   type_of_list,
                   type_of_list );
    
end );
