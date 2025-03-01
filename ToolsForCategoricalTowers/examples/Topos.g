#! @Chunk LambdaAbstraction_PushoutComplement

#! @Example
LoadPackage( "FpCategories", false );
#! true
LoadPackage( "LazyCategories", false );
#! true
q := FinQuiver( "q(K,L,G)[l:K->L,m:L->G]" );
#! FinQuiver( "q(K,L,G)[l:K-≻L,m:L-≻G]" )
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
# Float( Length( String( c ) ) / 10^9 ); TimeToString( time ); ## 0.573594, "3.864 sec."
#! <A monomorphism in T>
program := LambdaAbstractionAsString( c, [ T, l, m ] );;
Assert( 0, DisplayString( EvalString( program ) ) = program );
c2 := EvalString( program )( T, l, m );
Assert( 0, IsIdenticalObj( c2, c ) );
Lazy := LazyCategory( T : primitive_operations := true, optimize := 2 );
#! LazyCategory( T )
zl := l / Lazy; SetLabel( zl, "l" );
#! <An evaluated morphism in LazyCategory( T )>
zm := m / Lazy; SetLabel( zm, "m" );
#! <An evaluated morphism in LazyCategory( T )>
Assert( 0, Target( zl ) = Source( zm ) );
SetLabel( Source( zl ), ObjectDatum( Source( l ) )[2][1] );
SetLabel( Source( zm ), ObjectDatum( Source( m ) )[2][1] );
SetLabel( Target( zm ), ObjectDatum( Target( m ) )[2][1] );
ze := ImageEmbedding( zm );
#! <A monomorphism in LazyCategory( T )>
zc := PushoutComplement( zl, zm );
#! <A monomorphism in LazyCategory( T )>
#! @EndExample
