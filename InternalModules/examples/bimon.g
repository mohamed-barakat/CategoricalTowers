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
#! Rows( GF(2) )
ComonF2mat := CategoryOfComonoids( F2mat );;
#! CategoryOfComonoids( Rows( GF(2) ) )
R := F2["c1..168"];;
SetName( R, "GF(2)[c1..168]" );
S := R["s1..9"];;
SetName( S, "GF(2)[c1..168][s1..9]" );
Rmat := CategoryOfRows( R );
#! Rows( GF(2)[c1..144] )
Smat := CategoryOfRows( S );
#! Rows( GF(2)[c1..144][s1..9] )
ComonRmat := CategoryOfComonoids( Rmat );;
#! CategoryOfComonoids( Rows( GF(2)[c1..144] ) )
BimonRmat := CategoryOfBimonoids2( Rmat );
#! CategoryOfBimonoids2( Rows( GF(2)[c1..144] ) )
HmonSmat := CategoryOfHopfMonoids( Smat );
#! CategoryOfHopfMonoids( Rows( GF(2)[c1..144][s1..9] ) )
I := TensorUnit( ComonRmat );
#! <An object in CategoryOfComonoids( Rows( GF(2) ) )>
U := TensorUnit( Rmat );
#! <A row module over GF(2) of rank 1>
V := 4 / Rmat;
#! <A row module over GF(2) of rank 4>
V2 := TensorProduct( V, V );
#! <A row module over GF(2) of rank 16>
counit := HomalgMatrix( [ 1, 0, 0, 1 ], 4, 1, R );;
counit := CategoryOfRowsMorphism( V, counit, U );;
id := HomalgIdentityMatrix( 4, R );;
comult := [ KroneckerMat( id[1], id[1] ) + KroneckerMat( id[2], id[3] ),
            KroneckerMat( id[1], id[2] ) + KroneckerMat( id[2], id[4] ),
            KroneckerMat( id[3], id[1] ) + KroneckerMat( id[4], id[3] ),
            KroneckerMat( id[3], id[2] ) + KroneckerMat( id[4], id[4] ) ];;
comult := UnionOfRows( comult );;
comult := CategoryOfRowsMorphism( V, comult, V2 );;
c := ObjectConstructor( ComonRmat, Triple( V, counit, comult ) );
Assert( 0, IsWellDefined( c ) );
iso := LeftInverse( UnionOfRows( [ id[1]+id[4], id[2], id[3], id[4] ] ) ) / Rmat;
C := TransformedComonoid( iso, c );
#! <An object in CategoryOfComonoids( Rows( GF(2) ) )>
Assert( 0, IsWellDefined( C ) );
comon := Coproduct( [ I, I, C ] );
Assert( 0, IsWellDefined( comon ) );
object := UnderlyingObject( comon );
counit := ObjectDatum( comon )[2];
comult := ObjectDatum( comon )[3];
id6 := HomalgIdentityMatrix( 6, R );
unit := id6[1];
unit := CategoryOfRowsMorphism( Target( counit ), unit, Source( counit ) );
mult := HomalgMatrix( Indeterminates( R ), 36 - 8, 6, R );
mult := UnionOfRows( id6, id6[2], id6[1], mult );
mult := CategoryOfRowsMorphism( Target( comult ), mult, Source( comult ) );
bimon := ObjectConstructor( BimonRmat, NTuple( 5, object, unit, mult, counit, comult ) );
obstruction := [ ];; IsWellDefined( bimon : obstruction := obstruction );
all := UnionOfRows( List( obstruction, pair -> ConvertMatrixToColumn( pair[1] - pair[2] ) ) );
all := CertainRows( all, NonZeroRows( all ) );
gamma := ClosedSubsetOfSpec( all );
SetParametrizedObject( gamma, UnderlyingMatrix( mult ) );
gamma_small := EmbedInSmallerAmbientSpaceUsingLinearRelations( gamma );

break;


#! @EndExample
