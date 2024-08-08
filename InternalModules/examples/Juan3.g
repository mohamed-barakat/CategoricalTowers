#! @Chunk HmonF3a

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "ZariskiFrames", false );
#! true
F3a := HomalgRingOfIntegersInSingular( 3 )["a,i"] / "i*a-1";
#! GF(3)(a)
R := F3a;
Rmat := CategoryOfRows( R );;
MonRmat := CategoryOfMonoids( Rmat );
id := HomalgIdentityMatrix( 6, R );
#! CategoryOfMonoids( Rows( GF(3)(a) ) )
I := TensorUnit( MonRmat );
#! <An object in CategoryOfMonoids( Rows( GF(3)(a) ) )>
T := TerminalObject( MonRmat );
#! <An object in CategoryOfMonoids( Rows( GF(3)(a) ) )>
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
#! <A morphism in Rows( GF(3)(a) )>
mult := HomalgIdentityMatrix( 4, R );
mult := List( [ 1 .. 4 ], r -> ConvertRowToMatrix( CertainRows( mult, [ r ] ), 2, 2 ) );
mult := List( mult, a -> List( mult, b -> ConvertMatrixToRow( a * b ) ) );
mult := UnionOfRows( Concatenation( mult ) );
mult := CategoryOfRowsMorphism( V2, mult, V );
#! <A morphism in Rows( GF(3)(a) )>
M := ObjectConstructor( MonRmat, Triple( V, unit, mult ) );
#! <An object in Category of monoid objects>
id_M := IdentityMorphism( M );
#! <An identity morphism in Category of monoid objects>
D := [ I, I, M ];
A := DirectProduct( D );
#! <An object in CategoryOfMonoids( Rows( GF(3)(a) ) )>
pr1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in CategoryOfMonoids( Rows( GF(3)(a) ) )>
pr2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in CategoryOfMonoids( Rows( GF(3)(a) ) )>
pr3 := ProjectionInFactorOfDirectProduct( D, 3 );
#! <A morphism in CategoryOfMonoids( Rows( GF(3)(a) ) )>
Assert( 0, IsOne( UniversalMorphismIntoDirectProduct( [ pr1, pr2, pr3 ] ) ) );

HmonRmat := CategoryOfHopfMonoids( Rmat );
#! CategoryOfHopfMonoids( Rows( GF(3)(a) ) )

object := ObjectDatum( A )[1];
unit := ObjectDatum( A )[2];
mult := ObjectDatum( A )[3];

counit := CertainColumns( HomalgIdentityMatrix( 6, R ), [ 1 ] );
counit := CategoryOfRowsMorphism( object, counit, Source( unit ) );

## Juan's example

comult := HomalgMatrix( "\
1,0,0,0,0,0,0,1,0,0,0,0,0,0,-1,0,0,0,0,0,0,-2*i,0,0,0,0,0,0,-2*a,0,0,0,0,0,0,-1,\
0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,-2,0,0,0,0,-2,0,0,0,0,-1,0,0,0,\
0,0,1,0,0,0,0,0,0,0,0,1,1,0,2,0,0,0,0,0,0,2*i,0,0,0,0,0,0,2*a,0,0,1,0,0,0,2,\
0,0,0,1,0,0,0,0,0,0,a,0,0,0,0,1,0,0,1,0,1,0,0,0,0,a,0,0,0,a,0,0,0,0,a,0,\
0,0,0,0,1,0,0,0,0,i,0,0,0,0,0,0,1,0,0,i,0,0,0,i,1,0,1,0,0,0,0,0,0,i,0,0,\
0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,0,2,0,0,0,0,2,0,0,0,0,2,0,0,1,0,2,0,0,0", 6, 36, R );

comult := CategoryOfRowsMorphism( object, comult, Source( mult ) );

antipode := HomalgMatrix( "\
1,0,0,0,0,0,\
0,1,0,0,0,0,\
0,0,1,0,0,0,\
0,0,0,0,-a,0,\
0,0,0,-i,0,0,\
0,0,0,0,0,1", 6, 6, R );

antipode := CategoryOfRowsMorphism( object, antipode, object );

Hmonoid := ObjectConstructor( HmonRmat, NTuple( 6, object, unit, mult, counit, comult, antipode ) );

#! @EndExample
