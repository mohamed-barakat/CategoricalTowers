#! @Chunk LambdaAbstraction_PushoutComplement

#! @Example
LoadPackage( "FpCategories", false );
#! true
q := FinQuiver( "q(K,L,G)[l:K->L,m:L->G]" );
#! FinQuiver( "q(K,L,G)[l:K→L,m:L→G]" )
T := SyntacticCategoryInDoctrines( "IsElementaryTopos" : name := "T", quiver := q );
#! T
K := T.K;
#! <An object in T>
EvalString( String( K ) ) = K;
#! true
L := T.L;
#! <An object in T>
EvalString( String( L ) ) = L;
#! true
G := T.G;
#! <An object in T>
EvalString( String( G ) ) = G;
#! true
l := T.l;
#! <A morphism in T>
IsEqualForMorphisms( EvalString( String( l ) ), l );
#! true
m := T.m;
#! <A morphism in T>
e := ImageEmbedding( m );
#! <A monomorphism in T>
c := PushoutComplement( l, m );
#! <A monomorphism in T>
# Float( Length( String( c ) ) / 10^9 ); TimeToString( time ); ## 0.573594, "3.864 sec."
program := LambdaAbstractionAsString( c, [ T, l, m ] );;
Assert( 0, DisplayString( EvalString( program ) ) = program );
c2 := EvalString( program )( T, l, m );
Assert( 0, IsIdenticalObj( c2, c ) );
#! @EndExample
