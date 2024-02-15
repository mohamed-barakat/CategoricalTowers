#! @Chunk DifferenceCSL

# the assumption si <= mi leads to fewer meets and joins:

#! @Example
LoadPackage( "Locales", false );
#! true
LoadPackage( "FunctorCategories", false, ">= 2023.09-02" );
#! true
q := "q(m0,s0,m1,s1,m2,s2,m0_x_s1,s0_u_m1,m1_x_s2,s1_u_m2)\
[sm0:s0->m0,sm1:s1->m1,sm2:s2->m2,\
p011:m0_x_s1->s1,\
i101:m1->s0_u_m1,\
p122:m1_x_s2->s2,\
i212:m2->s1_u_m2,\
mc0:m0_x_s1->s0,jc0:m0->s0_u_m1,\
mc1:m1_x_s2->s1,jc1:m1->s1_u_m2]";;
q := FinQuiver( q );
#! FinQuiver( "q(m0,s0,m1,s1,m2,s2,m0_x_s1,s0_u_m1,m1_x_s2,s1_u_m2)
#! [sm0:s0-≻m0,sm1:s1-≻m1,sm2:s2-≻m2,
#!  p011:m0_x_s1-≻s1,
#!  i101:m1-≻s0_u_m1,
#!  p122:m1_x_s2-≻s2,
#!  i212:m2-≻s1_u_m2,
#!  mc0:m0_x_s1-≻s0,jc0:m0-≻s0_u_m1,
#!  mc1:m1_x_s2-≻s1,jc1:m1-≻s1_u_m2]" )
F := PathCategory( q );
#! PathCategory( FinQuiver( "q(m0,s0,m1,s1,m2,s2,m0_x_s1,s0_u_m1,m1_x_s2,s1_u_m2)
#! [sm0:s0-≻m0,sm1:s1-≻m1,sm2:s2-≻m2,
#!  p011:m0_x_s1-≻s1,
#!  i101:m1-≻s0_u_m1,
#!  p122:m1_x_s2-≻s2,
#!  i212:m2-≻s1_u_m2,
#!  mc0:m0_x_s1-≻s0,jc0:m0-≻s0_u_m1,
#!  mc1:m1_x_s2-≻s1,jc1:m1-≻s1_u_m2]" ) )
HomStructure( F.s0, F.s0_u_m1 );
#! |1|
HomStructure( F.s1, F.s1_u_m2 );
#! |1|
HomStructure( F.m0_x_s1, F.m0 );
#! |1|
HomStructure( F.m1_x_s2, F.m1 );
#! |1|
C := F /
     [ [ F.p011 * F.sm1 * F.i101, F.mc0 * F.sm0 * F.jc0 ],
       [ F.p122 * F.sm2 * F.i212, F.mc1 * F.sm1 * F.jc1 ] ];
#! PathCategory( FinQuiver( "q(m0,s0,m1,s1,m2,s2,m0_x_s1,s0_u_m1,m1_x_s2,s1_u_m2)
#! [sm0:s0-≻m0,sm1:s1-≻m1,sm2:s2-≻m2,
#!  p011:m0_x_s1-≻s1,
#!  i101:m1-≻s0_u_m1,
#!  p122:m1_x_s2-≻s2,
#!  i212:m2-≻s1_u_m2,
#!  mc0:m0_x_s1-≻s0,jc0:m0-≻s0_u_m1,
#!  mc1:m1_x_s2-≻s1,jc1:m1-≻s1_u_m2]" ) )
#!  / [ p011⋅sm1⋅i101 = mc0⋅sm0⋅jc0, p122⋅sm2⋅i212 = mc1⋅sm1⋅jc1 ]
objs := SetOfObjects( C );;
Assert( 0, Length( objs ) = 10 );
d := DigraphReflexiveTransitiveReduction( Digraph( objs, IsHomSetInhabited ) );;
SetFilterObj( d, IsDigraphOfSubobjects );
Splash( DotVertexLabelledDigraph( d ) );
P := PosetOfCategory( C );;
coPSh := CoPreSheaves( P );;
l := SetOfObjectsOfCategory( coPSh );;
Assert( 0, Length( l ) = 41 );
dp := DigraphReflexiveTransitiveReduction( Digraph( [ 1 .. Length( objs ) ] , {i,j} -> IsHomSetInhabited( l[1+i], l[1+j] ) ) );;
SetFilterObj( dp, IsDigraphOfSubobjects );
Splash( DotVertexLabelledDigraph( dp ) );
D := DigraphReflexiveTransitiveReduction( Digraph( [ 0 .. Length( l ) - 1 ], {i,j} -> IsHomSetInhabited( l[1+i], l[1+j] ) ) );
SetFilterObj( D, IsDigraphOfSubobjects );
Splash( DotVertexLabelledDigraph( D ) );
SetSetOfObjects( coPSh, l );;
SetIsFinite( coPSh, true );;
emb := CoYonedaEmbeddingOfSourceCategory( coPSh );
Assert( 0, IsHomSetInhabited( emb( P.m0_x_s1 ), DirectProduct( emb( P.m0 ), emb( P.s1 ) ) ) );
Assert( 0, not IsHomSetInhabited( DirectProduct( emb( P.m0 ), emb( P.s1 ) ), emb( P.m0_x_s1 ) ) );
Assert( 0, Coproduct( emb( P.s0 ), emb( P.m1 ) ) = emb( P.s0_u_m1 ) );
#! @EndExample
