#! @Chunk HmonF3

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "ZariskiFrames", false );
#! true
F3 := HomalgRingOfIntegersInSingular( 3 );
#! GF(2)
F3mat := CategoryOfRows( F3 );;
MonF3mat := CategoryOfMonoids( F3mat );
R := F3;
id := HomalgIdentityMatrix( 6, R );
Rmat := F3mat;
MonRmat := MonF3mat;
#! CategoryOfMonoids( Rows( GF(3) ) )
Display( MonRmat );
#! A CAP category with name CategoryOfMonoids( Rows( GF(3) ) ):
#! 
#! 29 primitive operations were used to derive 85 operations for this category
#! which algorithmically
#! * IsCartesianCategory
#! * IsSymmetricMonoidalCategory
I := TensorUnit( MonRmat );
#! <An object in CategoryOfMonoids( Rows( GF(3) ) )>
T := TerminalObject( MonRmat );
#! <An object in CategoryOfMonoids( Rows( GF(3) ) )>
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
#! <A morphism in Rows( GF(3) )>
mult := HomalgIdentityMatrix( 4, R );
mult := List( [ 1 .. 4 ], r -> ConvertRowToMatrix( CertainRows( mult, [ r ] ), 2, 2 ) );
mult := List( mult, a -> List( mult, b -> ConvertMatrixToRow( a * b ) ) );
mult := UnionOfRows( Concatenation( mult ) );
mult := CategoryOfRowsMorphism( V2, mult, V );
#! <A morphism in Rows( GF(3) )>
M := ObjectConstructor( MonRmat, Triple( V, unit, mult ) );
#! <An object in Category of monoid objects>
id_M := IdentityMorphism( M );
#! <An identity morphism in Category of monoid objects>
D := [ I, I, M ];
A := DirectProduct( D );
#! <An object in CategoryOfMonoids( Rows( GF(3) ) )>
pr1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in CategoryOfMonoids( Rows( GF(3) ) )>
pr2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in CategoryOfMonoids( Rows( GF(3) ) )>
pr3 := ProjectionInFactorOfDirectProduct( D, 3 );
#! <A morphism in CategoryOfMonoids( Rows( GF(3) ) )>
Assert( 0, IsOne( UniversalMorphismIntoDirectProduct( [ pr1, pr2, pr3 ] ) ) );

A2 := TensorProduct( A, A );

HmonRmat := CategoryOfHopfMonoids( Rmat );
#! CategoryOfHopfMonoids( Rows( GF(3) ) )

object := ObjectDatum( A )[1];
unit := ObjectDatum( A )[2];
mult := ObjectDatum( A )[3];

counit := CertainColumns( HomalgIdentityMatrix( 6, R ), [ 1 ] );
counit := CategoryOfRowsMorphism( object, counit, Source( unit ) );

## Mohamed's example

comult_Mohamed := HomalgMatrix( "\
1,0,0,0,0,0,0,1,0,0,0,0,0,0,-1,0,0,0, 0,0,0,1, 0, 0,0,0,0,0, 1, 0,0,0,0, 0,0,-1,\
0,1,0,0,0,0,1,0,0,0,0,0,0,0,0, 0,0,-1,0,0,0,0, 1, 0,0,0,0,1, 0, 0,0,0,-1,0,0,0,\
0,0,1,0,0,0,0,0,0,0,0,1,1,0,0, 0,0,-1,0,0,0,0, -1,0,0,0,0,-1,0, 0,0,1,-1,0,0,0,\
0,0,0,1,0,0,0,0,0,0,1,0,0,0,0, 0,1,0, 1,0,0,0, 0, 1,0,1,1,0, 0, 0,0,0,0, 1,0,0,\
0,0,0,0,1,0,0,0,0,1,0,0,0,0,0, 1,0,0, 0,1,1,0, 0, 0,1,0,0,0, 0, 1,0,0,0, 0,1,0,\
0,0,0,0,0,1,0,0,1,0,0,0,0,1,-1,0,0,0, 0,0,0,-1,0, 0,0,0,0,0, -1,0,1,0,0, 0,0,-1", 6, 36, R );

comult_Mohamed := CategoryOfRowsMorphism( object, comult_Mohamed, Source( mult ) );

antipode_Mohamed := HomalgMatrix( "\
1,0,0,0, 0, 0,\
0,1,0,0, 0, 0,\
0,0,1,0, 0, 0,\
0,0,0,0, -1,0,\
0,0,0,-1,0, 0,\
0,0,0,0, 0, 1", 6, 6, R );

antipode_Mohamed := CategoryOfRowsMorphism( object, antipode_Mohamed, object );

Hmonoid_Mohamed := ObjectConstructor( HmonRmat, NTuple( 6, object, unit, mult, counit, comult_Mohamed, antipode_Mohamed ) );

## Juan's example

comult_Juan := HomalgMatrix( "\
1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,-1,0,0,0,0,-1,0,0,0,0,-1,0,0,0,\
0,1,0,0,0,0,1,0,0,0,0,0,0,0,0, 0,0,-1,0,0,0,0, 1, 0,0,0,0,1,0,0,0,0,-1,0,0,0,\
0,0,1,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,\
0,0,0,1,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,\
0,0,0,0,1,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,\
0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0", 6, 36, R );

comult_Juan := CategoryOfRowsMorphism( object, comult_Juan, Source( mult ) );

antipode_Juan := HomalgMatrix( "\
1,0,0,0,0,0,\
0,1,0,0,0,0,\
0,0,0,0,0,1,\
0,0,0,1,0,0,\
0,0,0,0,1,0,\
0,0,1,0,0,0", 6, 6, R );

antipode_Juan := CategoryOfRowsMorphism( object, antipode_Juan, object );

Hmonoid_Juan := ObjectConstructor( HmonRmat, NTuple( 6, object, unit, mult, counit, comult_Juan, antipode_Juan ) );

## Juan's isomorphism

iso := HomalgMatrix( "\
-1,1,1,-1,\
1,1,-1,-1,\
1,-1,1,-1,\
-1,-1,-1,-1", 4, 4, R );

iso := DiagMat( R, [ HomalgIdentityMatrix( 2, R ), iso ] );
iso := iso / F3mat;



#! @EndExample
