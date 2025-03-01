#! @Chunk FreeCartesianClosedCategory

#! @Example

LoadPackage( "FpCategories", false );
#! true
SetInfoLevel( InfoSyntacticCategory, 2 );
S := SyntacticCategoryInDoctrines( "IsCartesianClosedCategory" :
             name := "S",
             quiver := FinQuiver( "q(A,B,C)[f:A->B,g:B->C]" ),
             strict_category := true,
             with_given_objects_methods := true,
             optimize := 1,
             view := "show" );
#! S
A := S.A;
#! A
B := S.B;
#! B
C := S.C;
#! C
f := S.f;
#! f:A→B
g := S.g;
#! g:B→C

Assert( 0, TestZigzagOfCartesianRightDirectProduct( S, A, B ) );

Assert( 0, TestZigzagOfCartesianRightExponential( S, A, B ) );

Assert( 0, TestZigzagOfCartesianLeftDirectProduct( S, A, B ) );

Assert( 0, TestZigzagOfCartesianLeftExponential( S, A, B ) );

t := TerminalObject( S );
#! 𝟏
x := MorphismConstructor( S, t, Pair( "MorphismConstructor", [ S, "x" ] ), A );
#! x:𝟏→A

xf := PreCompose( x, f );
#! x:𝟏→A ⋅ f:A→B
ixf := PreCompose(
               UniversalMorphismIntoDirectProduct( [ x, CartesianLambdaIntroduction( f ) ] ),
               CartesianRightEvaluationMorphism( A, B ) );
#! ⟨ x:𝟏→A, rcoev:𝟏→(A×𝟏)^A ⋅ ( π_1:A×𝟏→A ⋅ f:A→B )^A ⟩ ⋅ rev:A×(B^A)→B

h := MorphismConstructor( S, DirectProduct( A, C ), Pair( "MorphismConstructor", [ S, "h" ] ), B );
#! h:A×C→B
ha := DirectProductToExponentialRightAdjunctMorphism( A, C, h );
#! rcoev:C→(A×C)^A ⋅ ( h:A×C→B )^A
haa := ExponentialToDirectProductRightAdjunctMorphism( A, B, ha );
#! ⟨ π_1:A×C→A, π_2:A×C→C ⋅ rcoev:C→(A×C)^A ⋅ ( h:A×C→B )^A ⟩ ⋅ rev:A×(B^A)→B

k := MorphismConstructor( S, C, Pair( "MorphismConstructor", [ S, "k" ] ), Exponential( A, B ) );
#! k:C→B^A
ka := ExponentialToDirectProductRightAdjunctMorphism( A, B, k );
#! ⟨ π_1:A×C→A, π_2:A×C→C ⋅ k:C→B^A ⟩ ⋅ rev:A×(B^A)→B
kaa := DirectProductToExponentialRightAdjunctMorphism( A, C, ka );
#! rcoev:C→(A×C)^A ⋅ ( ⟨ π_1:A×C→A, π_2:A×C→C ⋅ k:C→B^A ⟩ ⋅ rev:A×(B^A)→B )^A

#Assert( 0,
#        IsEqualForMorphisms(
#                PreCompose( x, f ),
#                PreCompose( UniversalMorphismIntoDirectProduct( [ x, CartesianLambdaIntroduction( f ) ] ),
#                        CartesianRightEvaluationMorphism( A, B ) ) ) );

#! @EndExample
