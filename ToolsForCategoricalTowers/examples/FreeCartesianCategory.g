#! @Chunk FreeCartesianCategory

#! @Example

LoadPackage( "FpCategories", false );
#! true
SetInfoLevel( InfoSyntacticCategory, 2 );
S := SyntacticCategoryInDoctrines( "IsCartesianCategory" :
             name := "S",
             strict_category := true,
             with_given_objects_methods := true,
             optimize := 1,
             quiver := FinQuiver( "q(A,B,C)[f:A->B,g:A->C]" ) );
#! S
A := S.A;
#! <An object in S>
B := S.B;
#! <An object in S>
C := S.C;
#! <An object in S>
f := S.f;
#! <A morphism in S>
g := S.g;
#! <A morphism in S>

Assert( 0,
        IsOne( UniversalMorphismIntoTerminalObject( TerminalObject( S ) ) ) );

Assert( 0,
        IsOne( UniversalMorphismIntoDirectProduct(
                [ ProjectionInFactorOfDirectProduct( [ A, B, C ], 1 ),
                  ProjectionInFactorOfDirectProduct( [ A, B, C ], 2 ),
                  ProjectionInFactorOfDirectProduct( [ A, B, C ], 3 ) ] ) ) );

Assert( 0,
        IsOne( DirectProductFunctorial(
                [ IdentityMorphism( A ),
                  IdentityMorphism( B ),
                  IdentityMorphism( C ) ] ) ) );

Assert( 0, IsEqualForMorphisms( f,
        PreCompose(
                UniversalMorphismIntoDirectProduct( [ f, g ] ),
                ProjectionInFactorOfDirectProduct( [ B, C ], 1 ) ) ) );

Assert( 0, IsEqualForMorphisms( g,
        PreCompose(
                UniversalMorphismIntoDirectProduct( [ f, g ] ),
                ProjectionInFactorOfDirectProduct( [ B, C ], 2 ) ) ) );

Assert( 0, IsOne( PreCompose(
        CartesianLeftUnitorInverse( A ),
        CartesianLeftUnitor( A ) ) ) );

Assert( 0, IsOne( PreCompose(
        CartesianLeftUnitor( A ),
        CartesianLeftUnitorInverse( A ) ) ) );

Assert( 0, IsOne( PreCompose(
        CartesianBraiding( A, B ),
        CartesianBraidingInverse( A, B ) ) ) );

Assert( 0, IsOne( PreCompose(
        CartesianBraidingInverse( A, B ),
        CartesianBraiding( A, B ) ) ) );

Assert( 0, IsOne( PreCompose(
        CartesianAssociatorLeftToRight( A, B, C ),
        CartesianAssociatorRightToLeft( A, B, C ) ) ) );

Assert( 0, IsOne( PreCompose(
        CartesianAssociatorRightToLeft( A, B, C ),
        CartesianAssociatorLeftToRight( A, B, C ) ) ) );

#! @EndExample
