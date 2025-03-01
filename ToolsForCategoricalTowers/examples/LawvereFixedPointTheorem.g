#! @Chunk LawvereFixedPointTheorem

#! @Example

LoadPackage( "FpCategories", false );
#! true
SetInfoLevel( InfoSyntacticCategory, 10 );
S := SyntacticCategoryInDoctrines( "IsCartesianClosedCategory" :
             name := "S",
             strict_category := true,
             optimize := 1,
             quiver := FinQuiver( "q(A,B)[f:B->B]" ) );
#! S
A := S.A;
#! <An object in S>
B := S.B;
#! <An object in S>
f := S.f;
#! <A morphism in S>
BA := Exponential( A, B );
#! <An object in S>
phi := MorphismConstructor( A, Pair( "MorphismConstructor", [ S, "phi" ] ), BA );
#! <A morphism in S>
DeltaA := CartesianDiagonal( A, 2 );
#! <A morphism in S>
phixA := DirectProductOnMorphismAndObject( phi, A );
#! <A morphism in S>
evalAB := CartesianLeftEvaluationMorphism( A, B );
#! <A morphism in S>
s := PreComposeList( [ DeltaA, phixA, evalAB, f ] );
#! <A morphism in S>
arguments := [ S, A, B, f, phi ];;
abstraction := LambdaAbstraction( s, arguments );
#! function( cat, A, B, f, phi ) ... end
Assert( 0, CallFuncList( abstraction, arguments ) = s );
si := CartesianLambdaIntroduction( s );
#! <A morphism in S>

#! @EndExample
