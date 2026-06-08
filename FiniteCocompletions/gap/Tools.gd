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
#!  The input is a list <A>perms</A> of <A>k</A> many permutations,
#!  and an integer <A>b</A> and the length <A>m</A> of its orbit under the permutations.
#!  The output is a triple of lists,
#!  the first of which is a list of length <A>m</A> of integers defining the orbit,
#!  the second is a list of length <A>m</A>-1 of pairs of integers corresponding to the non-trivial transversals,
#!  and the third is a list of <A>m</A><A>k</A> - (<A>m</A>-1) many triples of integers
#!  corresponding to the list of generators of the stabilizer of <A>b</A>.
#! @Arguments perms, c, b, m
#! @Returns a triple of lists
DeclareOperation( "SchreierSimsOnASingleOrbit",
        [ IsList, IsInt, IsInt, IsInt ] );

CapJitAddTypeSignature( "SchreierSimsOnASingleOrbit", [ IsList, IsInt, IsInt, IsInt ], function ( input_types )
    
    return CapJitDataTypeOfNTupleOf( 3,
                   CapJitDataTypeOfListOf( IsInt ),
                   CapJitDataTypeOfListOf(
                           CapJitDataTypeOfNTupleOf( 3,
                                   IsInt,
                                   IsInt,
                                   IsInt ) ),
                   CapJitDataTypeOfListOf(
                           CapJitDataTypeOfNTupleOf( 4,
                                   IsInt,
                                   IsInt,
                                   IsInt,
                                   IsInt ) ) );
    
end );
