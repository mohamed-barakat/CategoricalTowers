#! @Chunk Hmon_test

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "ZariskiFrames", false );
#! true
F2 := HomalgRingOfIntegersInSingular( 2 );
#! GF(2)
F2mat := CategoryOfRows( F2 );;
MonF2mat := CategoryOfMonoids( F2mat );
R := F2["c1..216,s1..36"];;
SetName( R, "GF(2)[c1..216,s1..36]" );
frob2 := HomalgMatrix( List( Indeterminates( R ), a -> a^2 - a ), Length( Indeterminates( R ) ), 1, R );
Rmat := CategoryOfRows( R );;
MonRmat := CategoryOfMonoids( Rmat );
#! CategoryOfMonoids( Rows( GF(2)[c1..216,s1..36] ) )
Display( MonRmat );
#! A CAP category with name CategoryOfMonoids( Rows( GF(2)[c1..216,s1..36] ) ):
#! 
#! 29 primitive operations were used to derive 85 operations for this category
#! which algorithmically
#! * IsCartesianCategory
#! * IsSymmetricMonoidalCategory
I := TensorUnit( MonRmat );
#! <An object in CategoryOfMonoids( Rows( GF(2)[c1..216,s1..36] ) )>
T := TerminalObject( MonRmat );
#! <An object in CategoryOfMonoids( Rows( GF(2)[c1..216,s1..36] ) )>
Assert( 0, IsTerminal( T ) );
U := TensorUnit( Rmat );
#! <A row module over Z of rank 1>
V := 4 / Rmat;;
#! <A row module over Z of rank 4>
V2 := TensorProduct( V, V );
#! <A row module over Z of rank 16>
unit := [ [ 1, 0, 0, 1 ] ];;
unit := HomalgMatrix( unit, 1, 4, R );;
unit := CategoryOfRowsMorphism( U, unit, V );
#! <A morphism in Rows( GF(2)[c1..216,s1..36] )>
mult := HomalgIdentityMatrix( 4, R );
mult := List( [ 1 .. 4 ], r -> ConvertRowToMatrix( CertainRows( mult, [ r ] ), 2, 2 ) );
mult := List( mult, a -> List( mult, b -> ConvertMatrixToRow( a * b ) ) );
mult := UnionOfRows( Concatenation( mult ) );
mult := CategoryOfRowsMorphism( V2, mult, V );
#! <A morphism in Rows( GF(2)[c1..216,s1..36] )>
M := ObjectConstructor( MonRmat, Triple( V, unit, mult ) );
#! <An object in Category of monoid objects>
id_M := IdentityMorphism( M );
#! <An identity morphism in Category of monoid objects>
D := [ I, I, M ];
A := DirectProduct( D );
#! <An object in CategoryOfMonoids( Rows( GF(2)[c1..216,s1..36] ) )>
pr1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in CategoryOfMonoids( Rows( GF(2)[c1..216,s1..36] ) )>
pr2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in CategoryOfMonoids( Rows( GF(2)[c1..216,s1..36] ) )>
pr3 := ProjectionInFactorOfDirectProduct( D, 3 );
#! <A morphism in CategoryOfMonoids( Rows( GF(2)[c1..216,s1..36] ) )>
Assert( 0, IsOne( UniversalMorphismIntoDirectProduct( [ pr1, pr2, pr3 ] ) ) );

A2 := TensorProduct( A, A );

HmonRmat := CategoryOfHopfMonoids( Rmat );
#! CategoryOfHopfMonoids( Rows( GF(2)[c1..216,s1..36] ) )

object := ObjectDatum( A )[1];
unit := ObjectDatum( A )[2];
mult := ObjectDatum( A )[3];

counit := CertainColumns( HomalgIdentityMatrix( 6, R ), [ 1 ] );
counit := CategoryOfRowsMorphism( object, counit, Source( unit ) );

comult := HomalgMatrix( Indeterminates( R ){[ 1 .. 6 * 36 ]}, 6, 36, R );
comult := CategoryOfRowsMorphism( object, comult, Source( mult ) );

antipode := HomalgMatrix( Indeterminates( R ){[ 6 * 36 + 1 .. 6 * 36 + 36 ]}, 6, 6, R );
antipode := CategoryOfRowsMorphism( object, antipode, object );

Hmonoid := ObjectConstructor( HmonRmat, NTuple( 6, object, unit, mult, counit, comult, antipode ) );
obstruction := [ ];; IsWellDefined( Hmonoid : obstruction := obstruction );
all := UnionOfRows( List( obstruction, pair -> ConvertMatrixToColumn( pair[1] - pair[2] ) ) );
#BasisOfRows( all ); ## killed after 19 days
gamma := ClosedSubsetOfSpec( all );
SetParametrizedObject( gamma, Hmonoid );
gamma_small := EmbedInSmallerAmbientSpaceUsingLinearRelations( gamma );

break;

gens := [ [[1,0],[0,1]], [[0,0],[0,0]], [[1,0],[0,0]], [[0,1],[0,0]], [[0,0],[1,0]], [[0,0],[0,1]] ];
mon := MonoidByGenerators( gens );
F2bimon := LinearizationOfSetMonoid( F2mat, mon );
Assert( 0, F2bimon!.elements = [[[0,0],[0,0]],[[0,0],[0,1]],[[0,0],[1,0]],[[0,1],[0,0]],[[1,0],[0,0]],[[1,0],[0,1]]] );
id := HomalgIdentityMatrix( 6, F2 );
iso := LeftInverse( UnionOfRows( [ id[1], id[6]-id[5]-id[2]+id[1], id[5]-id[1], id[4]-id[1], id[3]-id[1], id[2]-id[1] ] ) ) / F2mat;
tbimon := TransformedBimonoid( iso, F2bimon );
point := Involution( ConvertMatrixToRow( UnderlyingMatrix( ObjectDatum( tbimon )[5] ) ) );
Assert( 0, point in gamma );
Assert( 0, IsWellDefined( tbimon ) );
break;

t := EmbeddedTangentSpaceAtPoint( gamma, point );
Assert( 0, point in t );
Assert( 0, Dimension( t ) = 3 );
i := t * gamma;
Assert( 0, Dimension( i ) = 0 );
Assert( 0, Degree( i ) = 1 );
w := HomalgMatrix( Indeterminates( R ){[ 1 .. 36 ]}, 36, 1, R );
u := ClosedSubsetOfSpec( CertainRows( BestUnderlyingColumn( t ), [ 1 .. 19 ] ) ); ## starting from 19,18,17 -> Rank( Delta_e0 ) = 2
v := gamma * u;
SetParametrizedObject( v, UnionOfColumns( UnderlyingMatrix( comult ), UnderlyingMatrix( antipode ) );
Dimension( v );
Delta_e0 := ConvertRowToMatrix( Involution( DecideZeroRows( w, BasisOfRows( UnderlyingColumn( v ) ) ) ), 6, 6 );
Display( Delta_e0 );

Assert( 0, Dimension( v ) = 1 );
#cmpl := ComplementOfTangentSpaceAtPoint( gamma, point );

L := List( [ 1 .. NrColumns( rel12345 ) ], c -> Factors( rel12345[1,c] ) );;
L2 := Filtered( L, f -> Length( f ) = 2 );
rel_extra := Filtered( EntriesOfHomalgMatrix( BasisOfRows( HomalgMatrix( List( L2, Product ), A134 ) ) ), e -> Degree( e ) = 1 );
eta134 := RingMapOntoSimplifiedResidueClassRing( A134 / rel_extra );
E134 := Range( eta134 );
rel12345 := Pullback( eta134, rel12345 );
rel12345 := CertainColumns( rel12345, NonZeroColumns( rel12345 ) );
L := List( [ 1 .. NrColumns( rel12345 ) ], c -> Factors( rel12345[1,c] ) );;
L2 := Filtered( L, f -> Length( f ) = 2 );

homog := List( L2, pair -> First( pair, p -> not ForAny( Coefficients( p )!.monomials, IsOne ) ) );
S12345 := E134 / homog{[1 .. 40]}; psi12345 := RingMapOntoSimplifiedResidueClassRing( S12345 ); srel12345 := Pullback( psi12345, rel12345 ); srel12345 := CertainColumns( srel12345, NonZeroColumns( srel12345 ) ); Display( BasisOfColumns( srel12345 ) );

inhomog := Concatenation( List( L2, pair -> Filtered( pair, p -> PositionProperty( Coefficients( p )!.monomials, IsOne ) <> fail ) ) );
inhomog := BasisOfColumns( HomalgMatrix( inhomog, 1, Length( inhomog ), A134 ) );
I12345 := A134 / inhomog; pi12345 := RingMapOntoSimplifiedResidueClassRing( I12345 ); irel12345 := Pullback( pi12345, rel12345 ); irel12345 := CertainColumns( irel12345, NonZeroColumns( irel12345 ) );


#! @EndExample
