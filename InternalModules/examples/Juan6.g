#! @Chunk HmonF3a

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "ZariskiFrames", false );
#! true
R := HomalgRingOfIntegersInSingular( )["h,a,b,i"] / [ "2*h-1" ," (a^2+4*b)*i-1" ];
#! Z[h,b,i]/( 2*h-1, a^2*i+4*b*i-1 )
Rmat := CategoryOfRows( R );;
MonRmat := CategoryOfMonoids( Rmat );
U := TensorUnit( Rmat );
#! <A row module over Z[h,b,i]/( 2*h-1, a^2*i+4*b*i-1 ) of rank 1>
V := 3 / Rmat;;
#! <A row module over Z[h,b,i]/( 2*h-1, a^2*i+4*b*i-1 ) of rank 2>
V2 := TensorProduct( V, V );
#! <A row module over Z[h,b,i]/( 2*h-1, a^2*i+4*b*i-1 ) of rank 4>
unit := [ [ 1, 0, 0 ] ];;
unit := HomalgMatrix( unit, 1, 3, R );;
unit := CategoryOfRowsMorphism( U, unit, V );
#! <A morphism in Rows( Z[h,b,i]/( 2*h-1, a^2*i+4*b*i-1 ) )>
mult := "[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ],   [ 0, 1, 0 ], [ 2, 1, 0 ], [ a, a, -1 ],   [ 0, 0, 1 ], [ a, a, -1 ], [ -2*b, a^2+b, -a ] ]";
mult := HomalgMatrix( mult, 3^2, 3, R );
mult := CategoryOfRowsMorphism( V2, mult, V );
#! <A morphism in Rows( Z[h,b,i]/( 2*h-1, a^2*i+4*b*i-1 ) )>
M := ObjectConstructor( MonRmat, Triple( V, unit, mult ) );
#! <An object in Category of monoid objects>
Assert( 0, IsWellDefined( M ) );

BimonRmat := CategoryOfBimonoids( Rmat );
#! CategoryOfBimonoids( Rows( Z[h,b,i]/( 2*h-1, a^2*i+4*b*i-1 ) ) )

counit := "[ [ 1 ], [ 2 ], [ a ] ]";;
counit := HomalgMatrix( counit, 3, 1, R );;
counit := CategoryOfRowsMorphism( V, counit, U );

comult := "[ [ 1,0,0,  0,0,0,  0,0,0 ], [ 0,0,0,  0,i*(a^2+2*b),-i*a,  0,-i*a,2*i ], [ 0,0,0,  0,-i*a*b,2*i*b,  0,2*i*b,i*a ] ]";
comult := HomalgMatrix( comult, 3, 3^2, R );
comult := CategoryOfRowsMorphism( V, comult, V2 );

Bimonoid := ObjectConstructor( BimonRmat, NTuple( 5, V, unit, mult, counit, comult ) );
Assert( 0, IsWellDefined( Bimonoid ) );

HmonRmat := CategoryOfHopfMonoids( Rmat );
#! CategoryOfHopfMonoids( Rows( Z[h,b,i]/( 2*h-1, a^2*i+4*b*i-1 ) ) )

antipode := "[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, a, -1 ] ]";
antipode := HomalgMatrix( antipode, 3, 3, R );
antipode := CategoryOfRowsMorphism( V, antipode, V );

Hmonoid := ObjectConstructor( HmonRmat, NTuple( 6, V, unit, mult, counit, comult, antipode ) );

#! @EndExample
