#! @Chunk Bimon_test

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
R := F2["c1..216"];;
SetName( R, "GF(2)[c1..216]" );
frob2 := HomalgMatrix( List( Indeterminates( R ), a -> a^2 - a ), Length( Indeterminates( R ) ), 1, R );
Rmat := CategoryOfRows( R );;
MonRmat := CategoryOfMonoids( Rmat );
#! CategoryOfMonoids( Rows( GF(2)[c1..216] ) )
Display( MonRmat );
#! A CAP category with name CategoryOfMonoids( Rows( GF(2)[c1..216] ) ):
#! 
#! 29 primitive operations were used to derive 85 operations for this category
#! which algorithmically
#! * IsCartesianCategory
#! * IsSymmetricMonoidalCategory
I := TensorUnit( MonRmat );
#! <An object in CategoryOfMonoids( Rows( GF(2)[c1..216] ) )>
T := TerminalObject( MonRmat );
#! <An object in CategoryOfMonoids( Rows( GF(2)[c1..216] ) )>
Assert( 0, IsTerminal( T ) );
U := TensorUnit( Rmat );
#! <A row module over GF(2)[c1..216] of rank 1>
V := 4 / Rmat;
#! <A row module over GF(2)[c1..216] of rank 4>
V2 := TensorProduct( V, V );
#! <A row module over GF(2)[c1..216] of rank 16>
unit := [ [ 1, 0, 0, 1 ] ];;
unit := HomalgMatrix( unit, 1, 4, R );;
unit := CategoryOfRowsMorphism( U, unit, V );
#! <A morphism in Rows( GF(2)[c1..216] )>
mult := HomalgIdentityMatrix( 4, R );
mult := List( [ 1 .. 4 ], r -> ConvertRowToMatrix( CertainRows( mult, [ r ] ), 2, 2 ) );
mult := List( mult, b -> List( mult, a -> ConvertMatrixToRow( a * b ) ) );
mult := UnionOfRows( Concatenation( mult ) );
mult := CategoryOfRowsMorphism( V2, mult, V );
#! <A morphism in Rows( GF(2)[c1..216] )>
M := ObjectConstructor( MonRmat, Triple( V, unit, mult ) );
#! <An object in Category of monoid objects>
IsWellDefined( M );
#! true
break;
D := [ I, I, M ];;
A := DirectProduct( D );
#! <An object in CategoryOfMonoids( Rows( GF(2)[c1..216] ) )>
pr1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in CategoryOfMonoids( Rows( GF(2)[c1..216] ) )>
pr2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in CategoryOfMonoids( Rows( GF(2)[c1..216] ) )>
pr3 := ProjectionInFactorOfDirectProduct( D, 3 );
#! <A morphism in CategoryOfMonoids( Rows( GF(2)[c1..216] ) )>
Assert( 0, IsOne( UniversalMorphismIntoDirectProduct( [ pr1, pr2, pr3 ] ) ) );
A2 := TensorProduct( A, A );

object := ObjectDatum( A )[1];
unit := ObjectDatum( A )[2];
mult := ObjectDatum( A )[3];

counit := CertainColumns( HomalgIdentityMatrix( 6, R ), [ 1 ] );
counit := CategoryOfRowsMorphism( object, counit, Source( unit ) );
comult := HomalgMatrix( Indeterminates( R ), 6, 36, R );
comult := CategoryOfRowsMorphism( object, comult, Source( mult ) );

BimonRmat := CategoryOfBimonoids( Rmat );
#! CategoryOfBimonoids( Rows( GF(2)[c1..216] ) )

bimonoid := ObjectConstructor( BimonRmat, NTuple( 5, object, unit, mult, counit, comult ) );
obstruction := [ ];; IsWellDefined( bimonoid : obstruction := obstruction );
all := UnionOfRows( List( obstruction, pair -> ConvertMatrixToColumn( pair[1] - pair[2] ) ) );
gamma := ClosedSubsetOfSpec( all );
SetParametrizedObject( gamma, UnderlyingMatrix( comult ) );
gamma_small := EmbedInSmallerAmbientSpaceUsingLinearRelations( gamma );
break;

#rel134 := UnionOfColumns( [ obstruction[1][1] - obstruction[1][2], ConvertMatrixToRow( obstruction[3][1] - obstruction[3][2] ), ConvertMatrixToRow( obstruction[4][1] - obstruction[4][2] ) ] );
#S134 := R / rel134;
#phi134 := RingMapOntoSimplifiedResidueClassRing( S134 );
#A134 := Range( phi134 );
#frob2_134 := HomalgMatrix( List( Indeterminates( A134 ), a -> a^2 - a ), 1, Length( Indeterminates( A134 ) ), A134 );
#rel1234 := Pullback( phi134, ConvertMatrixToRow( obstruction[2][1] - obstruction[2][2] ) );
#rel1234 := CertainColumns( rel1234, NonZeroColumns( rel1234 ) );
#S1234 := A134 / rel1234;
#rel12345 := UnionOfColumns( rel1234, Pullback( phi134, ConvertMatrixToRow( obstruction[5][1] - obstruction[5][2] ) ) );
#rel12345 := CertainColumns( rel12345, NonZeroColumns( rel12345 ) );
#S12345 := A134 / rel12345;

#mat2 := UnionOfColumns( rel12345, frob2_134 );

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
u := ClosedSubsetOfSpec( CertainRows( BestUnderlyingColumn( t ), [ 1 .. 19 ] ) ); ## starting from 19,18,17,16 -> Rank( Delta_e0 ) = 2, 16 leads to a bigger space
v := gamma * u;
SetParametrizedObject( v, UnderlyingMatrix( comult ) );
Dimension( v );
vs := EmbedInSmallerAmbientSpace( v );
irr := IrreducibleComponents( vs );
comults := List( irr, AClosedPoint );

comult_example := ParametrizedObject( vs );
#comult_example := CategoryOfRowsMorphism( object, comult_example, Source( mult ) );
W := UnderlyingRing( vs );
SetName( W, "GF(2)[c119,c125,c130,c132,c134,c135,c142,c154,c160,c164,c165,c173,c174,c179,c195,c214,c215]/( ... )" );
Wmat := CategoryOfRows( W );
BimonWmat := CategoryOfBimonoids( Wmat );
bimon_object := 6 / Wmat;
bimon_unit := W * UnderlyingMatrix( unit ) / Wmat;
bimon_mult := W * UnderlyingMatrix( mult ) / Wmat;
bimon_counit := W * UnderlyingMatrix( counit ) / Wmat;
bimon_comult := W * ( comult_example ) / Wmat;
#Assert( 0, IsWellDefined( ObjectConstructor( BimonWmat, NTuple( 5, bimon_object, bimon_unit, bimon_mult, bimon_counit, bimon_comult ) ) ) );

S := W["s1..36"];;
SetName( S, "GF(2)[c1..216][s1..36]" );
Smat := CategoryOfRows( S );
HmonSmat := CategoryOfHopfMonoids( Smat );
#! CategoryOfHopfMonoids( Rows( GF(2)[c1..216][s1..36] ) )
hopf_object := 6 / Smat;
hopf_unit := S * UnderlyingMatrix( unit ) / Smat;
hopf_mult := S * UnderlyingMatrix( mult ) / Smat;
hopf_counit := S * UnderlyingMatrix( counit ) / Smat;
hopf_comult := S * ( comult_example ) / Smat;
antipode := HomalgMatrix( RelativeIndeterminatesOfPolynomialRing( S ), 6, 6, S );
antipode := CategoryOfRowsMorphism( hopf_object, antipode, hopf_object );
hopf := ObjectConstructor( HmonSmat, NTuple( 6, hopf_object, hopf_unit, hopf_mult, hopf_counit, hopf_comult, antipode ) );
obstruction_hopf := [ ];; IsWellDefined( hopf : obstruction := obstruction_hopf );
hopf_all := BasisOfRows( UnionOfRows( List( obstruction_hopf, pair -> ConvertMatrixToColumn( pair[1] - pair[2] ) ) ) );

break;

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
