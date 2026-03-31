#! @BeginChunk FiniteStrictCoproductCompletionOfObjectFiniteCategory

#! @Example
LoadPackage( "FinGSetsForCAP", false );
#! true
LoadPackage( "FiniteCocompletions", false );
#! true
T := TerminalCategoryWithSingleObject();
#! TerminalCategoryWithSingleObject( )
id_T := SetOfMorphisms( T )[1];;
mT := FiniteStrictCoproductCompletionOfObjectFiniteCategory( T );
#! FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSin\
#! gleObject( ) )
x := [ 5, [ 5 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
y := [ 3, [ 3 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
t := [ 2, [ 2 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
pi := MorphismConstructor( mT, x, [ [ [ [ 0, 0, 0, 0, 0 ], [ 0, 0, 2, 1, 1 ] ] ], [ [ id_T, id_T, id_T, id_T, id_T ] ] ], y );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
phi := MorphismConstructor( mT, x, [ [ [ [ 0, 0, 0, 0, 0 ], [ 1, 1, 1, 0, 0 ] ] ], [ [ id_T, id_T, id_T, id_T, id_T ] ] ], t );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
IsColiftableAlongEpimorphism( mT, pi, phi );
#! true
psi := ColiftAlongEpimorphism( mT, pi, phi );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
Display( psi);
#! { 0, 1, 2 } ⱶ[ [ [ 0, 0, 0 ], [ 1, 0, 1 ] ] ]→ { 0, 1, 2 }
#!
#! [ [ A morphism in TerminalCategoryWithSingleObject( ), 
#!       A morphism in TerminalCategoryWithSingleObject( ), 
#!       A morphism in TerminalCategoryWithSingleObject( ) ] ]
#! A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) ) given by the above data
PreCompose( pi, psi ) = phi;
#! true

x := [ 4, [ 4 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
y := [ 3, [ 3 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
pi := MorphismConstructor( mT, x, [ [ [ [ 0, 0, 0, 0 ], [ 1, 0, 1, 2 ] ] ], [ [ id_T, id_T, id_T, id_T ] ] ], y );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
IsColiftableAlongEpimorphism( mT, pi, pi );
#! true
psi := ColiftAlongEpimorphism( mT, pi, pi );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
psi = IdentityMorphism( y );
#! true

x := [ 4, [ 4 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
f := MorphismConstructor( mT, x, [ [ [ [ 0, 0, 0, 0 ], [ 1, 3, 0, 2 ] ] ], [ [ id_T, id_T, id_T, id_T ] ] ], x );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
id_x := IdentityMorphism( x );
#! <An identity morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory\
#! ( TerminalCategoryWithSingleObject( ) )>
IsColiftableAlongEpimorphism( mT, f, id_x );
#! true
f_inv := ColiftAlongEpimorphism( mT, f, id_x );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
PreCompose( f, f_inv ) = IdentityMorphism( x );
#! true

x_1 := [ 4, [ 4 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
y_1 := [ 3, [ 3 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
t_1 := [ 2, [ 2 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
pi_1 := MorphismConstructor( mT, x_1, [ [ [ [ 0, 0, 0, 0 ], [ 0, 0, 1, 2 ] ] ], [ [ id_T, id_T, id_T, id_T ] ] ], y_1 );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
phi_1 := MorphismConstructor( mT, x_1, [ [ [ [ 0, 0, 0, 0 ], [ 1, 1, 0, 0 ] ] ], [ [ id_T, id_T, id_T, id_T ] ] ], t_1 );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
psi_1 := ColiftAlongEpimorphism( mT, pi_1, phi_1 );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
x_2 := [ 2, [ 2 ] ] / mT;
#! <An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalC\
#! ategoryWithSingleObject( ) )>
pi_2 := MorphismConstructor( mT, x_2, [ [ [ [ 0, 0 ], [ 1, 0 ] ] ], [ [ id_T, id_T ] ] ], x_2 );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
phi_2 := IdentityMorphism( x_2 );
#! <An identity morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory\
#! ( TerminalCategoryWithSingleObject( ) )>
psi_2 := ColiftAlongEpimorphism( mT, pi_2, phi_2 );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
pi := CoproductFunctorial( [x_1,x_2], [pi_1,pi_2], [y_1,x_2] );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
phi := CoproductFunctorial( [x_1,x_2], [phi_1,phi_2], [t_1,x_2] );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
psi_to_be := CoproductFunctorial( [y_1,x_2], [psi_1,psi_2], [t_1,x_2] );
#! <A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( Terminal\
#! CategoryWithSingleObject( ) )>
psi_to_be = ColiftAlongEpimorphism( mT, pi, phi );
#! true

#! @EndExample
#! @EndChunk
