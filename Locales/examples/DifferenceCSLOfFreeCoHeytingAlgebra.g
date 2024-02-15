#! @Chunk DifferenceCSLOfFreeCoHeytingAlgebra

#! @Example
LoadPackage( "FunctorCategories", false, ">= 2024.02-03" );
#! true
q := FinQuiver( "q(x,y)[]" );
#! FinQuiver( "q(x,y)[]" )
F := PathCategory( q );
#! PathCategory( FinQuiver( "q(x,y)[]" ) )
P := PosetOfCategory( F );
#! PosetOfCategory( PathCategory( FinQuiver( "q(x,y)[]" ) ) )
D := FreeDistributiveCategoryWithStrictProductAndCoproducts( P );
#! FreeDistributiveCategoryWithStrictProductAndCoproducts(
#! PosetOfCategory( PathCategory( FinQuiver( "q(x,y)[]" ) ) ) )
x := D.x;; SetLabel( x, "x" );
y := D.y;;
i := InitialObject( D );;
t := TerminalObject( D );;
xmy := DirectProduct( x, y );;
xjy := Coproduct( x, y );;
L := [ i, xmy, x, y, xjy, t ];;
digraphD := DigraphReflexiveTransitiveReduction( Digraph( L, IsHomSetInhabited ) );
digraphD!.vertexlabels := [ "i", "xmy", "x", "y", "xjy", "t" ];
SetFilterObj( digraphD, IsDigraphOfSubobjects );
F := PathCategory( FinQuiver( QuiverStringOfDigraph( digraphD, "q", "m" ) ) );
#! PathCategory( FinQuiver( "q(i,xmy,x,y,xjy,t)
#! [m_1_2:i-≻xmy,m_2_3:xmy-≻x,m_2_4:xmy-≻y,m_3_5:x-≻xjy,m_4_5:y-≻xjy,m_5_6:xjy-≻t]" ) )
digraphF := DigraphReflexiveTransitiveReduction( Digraph( SetOfObjects( F ), IsHomSetInhabited ) );
SetFilterObj( digraphF, IsDigraphOfSubobjects );
H := PosetOfCategory( F );

#! @EndExample
