# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Declarations
#

#! @Chapter Meet-semilattice of multiple differences

#! @Section GAP categories

#! @Description
#!  The &GAP; category of a meet-semilattice of multiple differences.
DeclareCategory( "IsMeetSemilatticeOfMultipleDifferences",
        IsMeetSemilatticeOfDifferences );

#! @Description
#!  The &GAP; category of objects in a meet-semilattice of multiple differences.
#! @Arguments object
DeclareCategory( "IsObjectInMeetSemilatticeOfMultipleDifferences",
        IsObjectInMeetSemilatticeOfDifferences );

#! @Description
#!  The &GAP; category of morphisms in a meet-semilattice of multiple differences.
#! @Arguments morphism
DeclareCategory( "IsMorphismInMeetSemilatticeOfMultipleDifferences",
        IsMorphismInMeetSemilatticeOfDifferences );

#! @Section Attributes

DeclareAttribute( "UnderlyingCategory",
        IsMeetSemilatticeOfMultipleDifferences );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsMeetSemilatticeOfMultipleDifferences ], function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "UnderlyingCategoryOfSingleDifferences",
        IsMeetSemilatticeOfMultipleDifferences );

CapJitAddTypeSignature( "UnderlyingCategoryOfSingleDifferences", [ IsMeetSemilatticeOfMultipleDifferences ], function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategoryOfSingleDifferences( input_types[1].category ) );
    
end );

DeclareAttribute( "PreMinuendAndSubtrahendsInUnderlyingLattice",
        IsObjectInMeetSemilatticeOfMultipleDifferences );

DeclareAttribute( "NormalizedMinuendAndSubtrahendsInUnderlyingLattice",
        IsObjectInMeetSemilatticeOfMultipleDifferences );

DeclareAttribute( "StandardMinuendAndSubtrahendsInUnderlyingLattice",
        IsObjectInMeetSemilatticeOfMultipleDifferences );

DeclareAttribute( "EquivalenceToMeetSemilatticeOfDifferences",
        IsCapCategory );

#! @Arguments A
DeclareAttribute( "AsSingleDifference",
        IsObjectInMeetSemilatticeOfMultipleDifferences );

CapJitAddTypeSignature( "AsSingleDifference", [ IsObjectInMeetSemilatticeOfMultipleDifferences ], function ( input_types )
    
    Assert( 0, IsMeetSemilatticeOfMultipleDifferences( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategoryOfSingleDifferences( input_types[1].category ) );
    
end );

#! @Section Operations

#! @Description
#!  A pair consisting of an object in the underlying lattice <A>P</A> and a list of objects in <A>P</A>.
#! @Arguments A
#! @Returns a list of &CAP; morphism
DeclareOperation( "MinuendAndSubtrahendsInUnderlyingLattice",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ] );

CapJitAddTypeSignature( "MinuendAndSubtrahendsInUnderlyingLattice", [ IsObjectInMeetSemilatticeOfMultipleDifferences ], function ( input_types )
    local type_of_object_in_underlying_category;
    
    Assert( 0, IsMeetSemilatticeOfMultipleDifferences( input_types[1].category ) );

    type_of_object_in_underlying_category := CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
    return rec( filter := IsNTuple,
                element_types :=
                [ type_of_object_in_underlying_category,
                  rec( filter := IsList, element_type := type_of_object_in_underlying_category ) ] );
    
end );

#! @Section Constructors

#! @Description
#!  Construct the meet-semilattice of multiple differences from the lattice <A>L</A>.
#! @Arguments L
#! @Returns a &CAP; category
DeclareAttribute( "MeetSemilatticeOfMultipleDifferences",
        IsCapCategory );

DeclareOperation( "MultipleDifference",
        [ IsList ] );

#! @Description
#!  If <A>D1</A>=<M>A1-B1</M>, <A>D2</A>=<M>A2-B2</M>, ..., then
#!  the output is <C>DirectProduct</C><M>(A1,A2,...)</M> - <C>Coproduct</C><M>(B1,B2,...)</M>.
#! @Arguments D1, D2, ...
#! @Returns an object in a &CAP; category
#! @Group AsMultipleDifference_group
DeclareGlobalFunction( "AsMultipleDifference" );
