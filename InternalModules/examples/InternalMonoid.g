#! @Chunk InternalMonoid

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true
zz := HomalgRingOfIntegers( );
#! Z
Zmat := CategoryOfRows( zz );;
#! Rows( Z )
MonZmat := CategoryOfMonoids( Zmat );
#! CategoryOfMonoids( Rows( Z ) )
Display( MonZmat );
#! A CAP category with name CategoryOfMonoids( Rows( Z ) ):
#! 
#! 29 primitive operations were used to derive 85 operations for this category
#! which algorithmically
#! * IsCategoryWithInitialObject
#! * IsCartesianCategory
#! * IsSymmetricMonoidalCategory
I := TensorUnit( MonZmat );
#! <An object in CategoryOfMonoids( Rows( Z ) )>
Assert( 0, IsWellDefined( I ) );
Assert( 0, IsInitial( I ) );
T := TerminalObject( MonZmat );
#! <An object in CategoryOfMonoids( Rows( Z ) )>
Assert( 0, IsTerminal( T ) );
U := TensorUnit( Zmat );
#! <A row module over Z of rank 1>
V := 4 / Zmat;;
#! <A row module over Z of rank 4>
V2 := TensorProduct( V, V );
#! <A row module over Z of rank 16>
unit := [ [ 1, 0, 0, 1 ] ];;
unit := HomalgMatrix( unit, 1, 4, zz );;
unit := CategoryOfRowsMorphism( U, unit, V );
#! <A morphism in Rows( Z )>
mult := HomalgIdentityMatrix( 4, zz );;
mult := List( [ 1 .. 4 ], r -> ConvertRowToMatrix( CertainRows( mult, [ r ] ), 2, 2 ) );;
mult := List( mult, a -> List( mult, b -> ConvertMatrixToRow( a * b ) ) );;
mult := UnionOfRows( Concatenation( mult ) );;
mult := CategoryOfRowsMorphism( V2, mult, V );
#! <A morphism in Rows( Z )>
M := ObjectConstructor( MonZmat, Triple( V, unit, mult ) );
#! <An object in Category of monoid objects>
Assert( 0, IsWellDefined( M ) );
id_M := IdentityMorphism( M );
#! <An identity morphism in Category of monoid objects>
Assert( 0, IsWellDefined( id_M ) );
Assert( 0, IsWellDefined( TensorProduct( M, M ) ) );
Assert( 0, IsWellDefined( TensorProduct( id_M, id_M ) ) );
Assert( 0, IsWellDefined( LeftUnitor( M ) ) );
Assert( 0, IsWellDefined( RightUnitor( M ) ) );
Assert( 0, IsWellDefined( AssociatorLeftToRight( M, I, M ) ) );
Assert( 0, IsWellDefined( Braiding( M, M ) ) );
Assert( 0, IsWellDefined( BraidingInverse( M, M ) ) );
Assert( 0, InverseForMorphisms( Braiding( M, M ) ) = BraidingInverse( M, M ) );
D := [ I, I, M ];
A := DirectProduct( D );
#! <An object in CategoryOfMonoids( Rows( Z ) )>
Assert( 0, IsWellDefined( A ) );
Assert( 0, IsWellDefined( UniversalMorphismFromInitialObject( A ) ) );
pr1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in CategoryOfMonoids( Rows( Z ) )>
pr2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in CategoryOfMonoids( Rows( Z ) )>
pr3 := ProjectionInFactorOfDirectProduct( D, 3 );
#! <A morphism in CategoryOfMonoids( Rows( Z ) )>
Assert( 0, IsOne( UniversalMorphismIntoDirectProduct( [ pr1, pr2, pr3 ] ) ) );
C := DualComonoid( A );
Assert( 0, IsWellDefined( C ) );
Assert( 0, IsWellDefined( UniversalMorphismIntoTerminalObject( C ) ) );
Assert( 0, DualMonoid( C ) = A );
BimonZmat := CategoryOfBimonoids( Zmat );
#! CategoryOfBimonoids( Rows( Z ) )
Display( BimonZmat );
#! A CAP category with name CategoryOfBimonoids( Rows( Z ) ):
#! 
#! 30 primitive operations were used to derive 106 operations for this category
#! which algorithmically
#! * IsCategoryWithTerminalObject
#! * IsRigidSymmetricClosedMonoidalCategory
m := LinearizationOfSetMonoid( Zmat, FullTransformationMonoid( 2 ) );
Assert( 0, IsWellDefined( m ) );
Assert( 0, IsWellDefined( DualOnObjects( m ) ) );
Assert( 0, IsWellDefined( DualOnMorphisms( IdentityMorphism( m ) ) ) );
Assert( 0, IsOne( DualOnMorphisms( IdentityMorphism( m ) ) ) );
#Assert( 0, IsWellDefined( UniversalMorphismFromZeroObject( m ) ) );
#Assert( 0, IsWellDefined( UniversalMorphismIntoZeroObject( m ) ) );
HmonZmat := CategoryOfHopfMonoids( Zmat );
#! CategoryOfHopfMonoids( Rows( Z ) )
Display( HmonZmat );
#! A CAP category with name CategoryOfHopfMonoids( Rows( Z ) ):
#! 
#! 31 primitive operations were used to derive 123 operations for this category
#! which algorithmically
#! * IsSymmetricMonoidalCategory
#! * IsCategoryWithZeroObject
g := LinearizationOfSetGroup( Zmat, CyclicGroup( 4 ) );
Assert( 0, IsWellDefined( g ) );
Assert( 0, IsWellDefined( DualOnObjects( g ) ) );
Assert( 0, IsWellDefined( UniversalMorphismFromZeroObject( g ) ) );
Assert( 0, IsWellDefined( UniversalMorphismIntoZeroObject( g ) ) );
Assert( 0, OppositeHopfMonoid( g ) = g );
Assert( 0, CoOppositeHopfMonoid( g ) = g );
Assert( 0, OppositeCoOppositeHopfMonoid( g ) = g );
Assert( 0, not DualOnObjects( g ) = g );
h := LinearizationOfSetGroup( Zmat, SymmetricGroup( 3 ) );
Assert( 0, not OppositeHopfMonoid( h ) = h );
Assert( 0, CoOppositeHopfMonoid( h ) = h );
#! @EndExample
