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
             view := "show",
             quiver := FinQuiver( "q(A,B,C,D)[f:A->B,g:A->C]" ) );
#! S
A := S.A;
#! A
B := S.B;
#! B
C := S.C;
#! C
D := S.D;
#! D
f := S.f;
#! f:A→B
g := S.g;
#! g:A→C
h := MorphismConstructor( A, Pair( "MorphismConstructor", [ S, "h" ] ), DirectProduct( B, C ) );
#! h:A→B×C
t := TerminalObject( S );
#! 𝟏
a := MorphismConstructor( S, t, Pair( "MorphismConstructor", [ S, "a" ] ), A );
#! a:𝟏→A
aa := UniversalMorphismIntoTerminalObject( A ) * a;
#! A→𝟏 ⋅ a:𝟏→A

Assert( 0,
        IsEqualForMorphisms( h,
                UniversalMorphismIntoDirectProduct(
                        [ PreCompose( h, ProjectionInFactorOfDirectProduct( [ B, C ], 1 ) ),
                          PreCompose( h, ProjectionInFactorOfDirectProduct( [ B, C ], 2 ) ) ] ) ) );

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

Assert( 0,
        IsEqualForMorphisms( f,
                PreCompose(
                        UniversalMorphismIntoDirectProduct( [ f, g ] ),
                        ProjectionInFactorOfDirectProduct( [ B, C ], 1 ) ) ) );

Assert( 0,
        IsEqualForMorphisms( g,
                PreCompose(
                        UniversalMorphismIntoDirectProduct( [ f, g ] ),
                        ProjectionInFactorOfDirectProduct( [ B, C ], 2 ) ) ) );

Assert( 0, TestCartesianUnitorsForInvertibility( S, A ) );

Assert( 0, TestCartesianBraidingForInvertibility( S, A, B ) );

Assert( 0, TestCartesianBraidingCompatibility( S, A, B, C ) );

Assert( 0, TestCartesianAssociatorForInvertibility( S, A, B, C ) );

Assert( 0, TestCartesianTriangleIdentity( S, A, B ) );

Assert( 0, TestCartesianPentagonIdentity( S, A, B, C, D ) );

#! @EndExample
