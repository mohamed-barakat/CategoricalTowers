#! @BeginChunk FiniteStrictCoproductCompletionOfObjectFiniteCategory_CoequalizerOfIdentityAndAutomorphisms

#! @Example
LoadPackage( "FiniteCocompletions", false );
#! true
LoadPackage( "FinGSetsForCAP", false );
#! true
T := TerminalCategoryWithSingleObject( );
#! TerminalCategoryWithSingleObject( )
id_T := SetOfMorphisms( T )[1];;
UTm := FiniteStrictCoproductCompletionOfObjectFiniteCategory( T );
#! FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSin\
#! gleObject( ) )
x := Pair( 5, [ 5 ] ) / UTm;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
f1 := MorphismConstructor(
              x,
              [ [ [ [ 0, 0, 0, 0, 0 ], [ 2, 4, 0, 3, 1 ] ] ],
                [ [ id_T, id_T, id_T, id_T, id_T ] ] ],
              x );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
f2 := MorphismConstructor(
              x,
              [ [ [ [ 0, 0, 0, 0, 0 ], [ 0, 1, 3, 2, 4 ] ] ],
                [ [ id_T, id_T, id_T, id_T, id_T ] ] ],
              x );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
D := [ f1, f2 ];;
Coeq := CoequalizerOfIdentityAndAutomorphisms( D );
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
PairOfIntAndList( Coeq )[2];
#! [ 2 ];
pi := ProjectionOntoCoequalizerOfIdentityAndAutomorphisms( D );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
PreCompose( f1, pi ) = pi;
#! true
PreCompose( f2, pi ) = pi;
#! true
IdentityMorphism( Coeq ) = UniversalMorphismFromCoequalizerOfIdentityAndAutomorphisms( x, D, Coeq, pi );
#! true

S5 := SymmetricGroup( 5 );; StructureDescription( S5 );; S5;
#! S5
TS5 := SkeletalCategoryOfTransitiveLeftGSets(S5);
#! SkeletalCategoryOfTransitiveLeftGSets( S5 ) with 19 objects
S5set := FiniteStrictCoproductCompletionOfObjectFiniteCategory( TS5 );
#! FiniteStrictCoproductCompletionOfObjectFiniteCategory( SkeletalCategoryOfTrans\
#! itiveLeftGSets( S5 ) with 19 objects )
x := Pair( 11, [ 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ) / S5set;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( SkeletalC\
#! ategoryOfTransitiveLeftGSets( S5 ) with 19 objects )>
id1 := MorphismConstructor( TS5.1, (), TS5.1 );;
s1_45 := MorphismConstructor( TS5.1, (4,5), TS5.1 );;
s1_123 := MorphismConstructor( TS5.1, (1,2,3), TS5.1 );;
s1_23 := MorphismConstructor( TS5.1, (2,3), TS5.1 );;
id2 := MorphismConstructor( TS5.2, (), TS5.2 );;
s2_23 := MorphismConstructor( TS5.2, (2,3), TS5.2 );;
s2_123 := MorphismConstructor( TS5.2, (1,2,3), TS5.2 );;
map1 := [ [ [ 0, 0, 0, 0, 0 ], [ 0, 2, 4, 3, 1 ] ],
          [ [ 1, 1, 1, 1, 1, 1 ], [ 4, 1, 2, 3, 0, 5 ] ],
          [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ],
          [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ],
          [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ],
          [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ] ];;
mor1 := [ [ s1_45, s1_45, id1, id1, s1_123 ],
          [ id2, id2, id2, id2, id2, id2 ],
          [], [], [], [], [], [], [], [],
          [], [], [], [], [], [], [], [], [] ];;
f1 := MorphismConstructor( x, Pair( map1, mor1 ), x );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Skeletal\
#! CategoryOfTransitiveLeftGSets( S5 ) with 19 objects )>
IsWellDefined( f1 );
#! true
map2 := [ [ [ 0, 0, 0, 0, 0 ], [ 3, 1, 4, 0, 2 ] ],
          [ [ 1, 1, 1, 1, 1, 1 ], [ 0, 3, 5, 1, 4, 2 ] ],
          [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ],
          [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ],
          [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ],
          [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ], [ [], [] ] ];;
mor2 := [ [ id1, id1, id1, s1_23, id1 ],
          [ s2_23, s2_123, s2_23, id2, id2, id2 ],
          [], [], [], [], [], [], [], [],
          [], [], [], [], [], [], [], [], [] ];;
f2 := MorphismConstructor( x, Pair( map2, mor2 ), x );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Skeletal\
#! CategoryOfTransitiveLeftGSets( S5 ) with 19 objects )>
IsWellDefined( f2 );
#! true
D := [ f1, f2 ];;
Coeq := CoequalizerOfIdentityAndAutomorphisms( D );
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( SkeletalC\
#! ategoryOfTransitiveLeftGSets( S5 ) with 19 objects )>
PairOfIntAndList( Coeq )[2];
#! [ 0, 0, 0, 0, 0, 3, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
pi := ProjectionOntoCoequalizerOfIdentityAndAutomorphisms( D );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Skeletal\
#! CategoryOfTransitiveLeftGSets( S5 ) with 19 objects )>
PreCompose( f1, pi ) = pi;
#! true
PreCompose( f2, pi ) = pi;
#! true
IdentityMorphism( Coeq ) = UniversalMorphismFromCoequalizerOfIdentityAndAutomorphisms( x, D, Coeq, pi );
#! true

#! @EndExample
#! @EndChunk
