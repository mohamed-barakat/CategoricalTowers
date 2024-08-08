#! @Chunk HmonF3a

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "ZariskiFrames", false );
#! true
R := HomalgRingOfIntegersInSingular( )["h,a,i"] / [ "2*h-1" ," a*i-1" ];
#! Z[h,a,i]/( 2*h-1, a*i-1 )
Rmat := CategoryOfRows( R );;
MonRmat := CategoryOfMonoids( Rmat );
U := TensorUnit( Rmat );
#! <A row module over Z[h,a,i]/( 2*h-1, a*i-1 ) of rank 1>
V := 2 / Rmat;;
#! <A row module over Z[h,a,i]/( 2*h-1, a*i-1 ) of rank 2>
V2 := TensorProduct( V, V );
#! <A row module over Z[h,a,i]/( 2*h-1, a*i-1 ) of rank 4>
unit := [ [ 1, 0 ] ];;
unit := HomalgMatrix( unit, 1, 2, R );;
unit := CategoryOfRowsMorphism( U, unit, V );
#! <A morphism in Rows( Z[h,a,i]/( 2*h-1, a*i-1 ) )>
mult := "[ [ 1, 0 ], [ 0, 1 ], [ 0, 1 ], [ 0, a ] ]";
mult := HomalgMatrix( mult, 4, 2, R );
mult := CategoryOfRowsMorphism( V2, mult, V );
#! <A morphism in Rows( Z[h,a,i]/( 2*h-1, a*i-1 ) )>
M := ObjectConstructor( MonRmat, Triple( V, unit, mult ) );
#! <An object in Category of monoid objects>
Assert( 0, IsWellDefined( M ) );
HmonRmat := CategoryOfHopfMonoids( Rmat );
#! CategoryOfHopfMonoids( Rows( Z[h,a,i]/( 2*h-1, a*i-1 ) ) )

counit := [ [ 1 ], [ 0 ] ];;
counit := HomalgMatrix( counit, 2, 1, R );;
counit := CategoryOfRowsMorphism( V, counit, U );

comult := "[ [ 1, 0, 0, 0 ], [ 0, 1, 1, -2 * i ] ]";
comult := HomalgMatrix( comult, 2, 4, R );
comult := CategoryOfRowsMorphism( V, comult, V2 );

antipode := HomalgIdentityMatrix( 2, R );
antipode := HomalgMatrix( antipode, 2, 2, R );
antipode := CategoryOfRowsMorphism( V, antipode, V );

Hmonoid := ObjectConstructor( HmonRmat, NTuple( 6, V, unit, mult, counit, comult, antipode ) );
Assert( 0, IsWellDefined( Hmonoid ) );
#! @EndExample
