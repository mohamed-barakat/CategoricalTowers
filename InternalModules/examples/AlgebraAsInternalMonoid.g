#! @Chunk AlgebraAsInternalMonoid

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "Algebroids", false );
#! true
q := FinQuiver( "q(o)[g:o->o,x:o->o]" );
#! FinQuiver( "q(o)[g:o-≻o,x:o-≻o]" )
F := PathCategory( q );
#! PathCategory( FinQuiver( "q(o)[g:o-≻o,x:o-≻o]" ) )
F3 := HomalgRingOfIntegersInSingular( 3 );
#! GF(3)
L := F3[F];
#! GF(3)-LinearClosure( PathCategory( FinQuiver( "q(o)[g:o-≻o,x:o-≻o]" ) ) )
Q := L / [ L.g^2-L.id_o, L.x^3-L.x, L.gx+L.xg ];
#! GF(3)-LinearClosure( PathCategory( FinQuiver( "q(o)[g:o-≻o,x:o-≻o]" ) ) ) / [ 1*g^2, 1*x^3 - 1*x, 1*g⋅x + 1*x⋅g ]
Dimension( Q );
#! 6;
A := AlgebraAsInternalMonoid( Q );
#! <An object in CategoryOfMonoids( Rows( Z ) )>
IsWellDefined( A );
#! true
o := Q.id_o;
#! [1*id(o)]:(o) -≻ (o)
g := Q.g;
#! [1*g]:(o) -≻ (o)
x := Q.x;
#! [1*x]:(o) -≻ (o)
counit := rec( g := 1,
               x := 0 );;
comult := rec( g := [ [ 1, [ g, g ] ] ],
               x := [ [ 1, [ o, x ] ], [ 1, [ x, o ] ] ] );;
antipode := rec( g := [ [ 1, g ] ],
                 x := [ [ -1, x ] ] );;
H := HopfMonoid( A, counit, comult, antipode );
#! <An object in CategoryOfHopfMonoids( Rows( GF(3) ) )>
IsWellDefined( H );
#! true
#! @EndExample
