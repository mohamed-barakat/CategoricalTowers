# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Declarations
#

#! @Chapter Tools

#! @Section Tools for quivers

#! @Description
#!  Return a pair consisting of the number of vertices of the quiver <A>q</A>
#!  and a list of pairs of integers encoding the arrows of <A>q</A>.
#! @Arguments q
#! @Returns a pair
DeclareAttribute( "DefiningPairOfAQuiver",
        IsQuiver );
#! @InsertChunk DefiningPairOfAQuiver

#! @Description
#!  The defining pair of the quiver underlying the finitely presented category <A>C</A>.
#! @Arguments C
#! @Returns a pair
DeclareAttribute( "DefiningPairOfUnderlyingQuiver",
        IsCapCategory );

CapJitAddTypeSignature( "DefiningPairOfUnderlyingQuiver", [ IsCapCategory ],
  function ( input_types )
    
    return rec( filter := IsNTuple,
                element_types :=
                [ rec( filter := IsInt ),
                  rec( filter := IsList,
                       element_type :=
                       rec( filter := IsNTuple,
                            element_types :=
                            [ rec( filter := IsInt ),
                              rec( filter := IsInt ) ] ) ) ] );
    
end );

#! @Section Tools for categories

#! @Description
#!  The nerve data of the finite category <A>C</A>.
#! @Arguments C
#! @Returns a pair of lists
DeclareAttribute( "NerveTruncatedInDegree2Data",
        IsCapCategory );

CapJitAddTypeSignature( "NerveTruncatedInDegree2Data", [ IsCapCategory ],
  function ( input_types )
    local V;
    
    Assert( 0, IsFinite( input_types[1].category ) );
    
    V := RangeCategoryOfHomomorphismStructure( input_types[1].category );
    
    return rec( filter := IsNTuple,
                element_types :=
                [ rec( filter := IsNTuple,
                       element_types :=
                       [ CapJitDataTypeOfObjectOfCategory( V ),      # C0
                         CapJitDataTypeOfObjectOfCategory( V ),      # C1
                         CapJitDataTypeOfObjectOfCategory( V ) ] ),  # C2
                  rec( filter := IsNTuple,
                       element_types :=
                       [ CapJitDataTypeOfMorphismOfCategory( V ),    # id
                         CapJitDataTypeOfMorphismOfCategory( V ),    # s
                         CapJitDataTypeOfMorphismOfCategory( V ),    # t
                         CapJitDataTypeOfMorphismOfCategory( V ),    # is
                         CapJitDataTypeOfMorphismOfCategory( V ),    # it
                         CapJitDataTypeOfMorphismOfCategory( V ),    # ps
                         CapJitDataTypeOfMorphismOfCategory( V ),    # pt
                         CapJitDataTypeOfMorphismOfCategory( V ) ] ) # mu
                  ] );
    
end );

