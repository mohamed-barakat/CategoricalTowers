#! @Chunk FreeCartesianCategory

#! @Example

LoadPackage( "FpCategories", false );
#! true
SetInfoLevel( InfoSyntacticCategory, 2 );
S := SyntacticCategoryInDoctrines( "IsFiniteCompleteCategory" :
             name := "S",
             strict_category := true,
             with_given_objects_methods := true,
             optimize := 1,
             view := "show",
             quiver := FinQuiver( "q(A,B,C)[f:A->C,g:B->C]" ) );
#! S
A := S.A;
#! A
B := S.B;
#! B
C := S.C;
#! C
f := S.f;
#! f:A→C
g := S.g;
#! g:B→C

pb := FiberProduct( [ f, g ] );
#! Equalizer( A×B, [ π_1:A×B→A ⋅ f:A→C, π_2:A×B→B ⋅ g:B→C ] )

#! @EndExample
