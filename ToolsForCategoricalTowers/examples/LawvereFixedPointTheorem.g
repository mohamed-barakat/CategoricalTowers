#! @Chunk LawvereFixedPointTheorem

#! @Example

LoadPackage( "FpCategories", false );
#! true
SetInfoLevel( InfoSyntacticCategory, 2 );
S := SyntacticCategoryInDoctrines( "IsCartesianClosedCategory" :
             name := "S",
             strict_category := true,
             with_given_objects_methods := true,
             optimize := 1,
             view := "show",
             quiver := FinQuiver( "q(A,B)[g:B->B]" ) );
#! S
A := S.A;
#! A
B := S.B;
#! B
g := S.g;
#! g:B→B
BA := Exponential( A, B );
#! B^A
phi := MorphismConstructor( A, Pair( "MorphismConstructor", [ S, "phi" ] ), BA );
#! phi:A→B^A
Aphi := UniversalMorphismIntoDirectProduct( [ IdentityMorphism( A ), phi ] );
#! ⟨ id_A, phi:A→B^A ⟩
revAB := CartesianRightEvaluationMorphism( A, B );
#! rev:A×(B^A)→B
h := Aphi * revAB;
#! ⟨ id_A, phi:A→B^A ⟩ ⋅ rev:A×(B^A)→B
f := h * g;
#! ⟨ id_A, phi:A→B^A ⟩ ⋅ rev:A×(B^A)→B ⋅ g:B→B
arguments := [ S, A, B, g, phi ];;
abstraction := LambdaAbstraction( f, arguments );
#! function( cat, A, B, g, phi ) ... end
Assert( 0, CallFuncList( abstraction, arguments ) = f );
fn := CartesianLambdaIntroduction( f );
#! rcoev:𝟏→(A×𝟏)^A ⋅ ( π_1:A×𝟏→A ⋅ ⟨ id_A, phi:A→B^A ⟩ ⋅ rev:A×(B^A)→B ⋅ g:B→B )^A

#! @EndExample
