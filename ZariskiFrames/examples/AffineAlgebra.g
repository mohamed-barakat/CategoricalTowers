LoadPackage( "ZariskiFrames" );

zz := HomalgRingOfIntegersInSingular( );
F2 := HomalgRingOfIntegersInSingular( 2, zz );
Q := HomalgFieldOfRationalsInSingular( zz );

AffAlg_Z := CategoryOfAffineAlgebras( zz );
#! CategoryOfAffineAlgebras( Z )
AffAlg_F2 := CategoryOfAffineAlgebras( F2 );
#! CategoryOfAffineAlgebras( GF(2) )
AffAlg_Q := CategoryOfAffineAlgebras( Q );
#! CategoryOfAffineAlgebras( Q )

Display( AffAlg_Z );
#! A CAP category with name CategoryOfAffineAlgebras( Z ):
#! 
#! 23 primitive operations were used to derive 86 operations for this category
#! which algorithmically
#! * IsFiniteCocompleteCategory
#! and not yet algorithmically
#! * IsBicartesianCategory

i := InitialObject( AffAlg_Z );
Assert( 0, IsWellDefined( i ) );
Display( i );

t := TerminalObject( AffAlg_Z );
Assert( 0, IsWellDefined( t ) );
Display( t );

ui := UniversalMorphismFromInitialObject( t );
ut := UniversalMorphismIntoTerminalObject( i );

Assert( 0, IsWellDefined( ui ) );
Assert( 0, IsWellDefined( ut ) );

S := zz["x,y,z"] / AffAlg_Z;
Assert( 0, IsWellDefined( S ) );
idS := IdentityMorphism( S );
IsWellDefined( idS );
PreCompose( idS, idS ) = idS;

T := zz["u"] / AffAlg_Z;
Assert( 0, IsWellDefined( T ) );
ExportVariables( AmbientAlgebra( T ) );

phi := MorphismConstructor( S, [ u, u^2, u^3 ], T );

coimage := CoimageObject( phi );
IsWellDefined( coimage );

Display( coimage );

prj := CoimageProjection( phi );
Assert( 0, IsWellDefined( prj ) );
Assert( 0, IsEpimorphism( prj ) and not IsMonomorphism( prj ) );
ast := AstrictionToCoimage( phi );
Assert( 0, IsWellDefined( ast ) );
Assert( 0, IsIsomorphism( ast ) );
inv := InverseForMorphisms( ast );
Assert( 0, IsWellDefined( inv ) );
Assert( 0, IsOne( PreCompose( ast, inv ) ) );
Assert( 0, IsOne( PreCompose( inv, ast ) ) );

diagram := [ coimage, coimage ];
Assert( 0, IsOne( UniversalMorphismFromCoproduct( List( [ 1, 2 ], i -> InjectionOfCofactorOfCoproduct( diagram, i ) ) ) ) );
