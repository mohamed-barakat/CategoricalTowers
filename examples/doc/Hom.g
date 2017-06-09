#! @System Hom

LoadPackage( "FunctorCategories" );

#! To illustrate our implementation of the category of functors, we consider the following example.
#! First, create a quiver with one edge 1 and one vertex $t$.

#! @Example
q := RightQuiver( "q(1)[t:1->1]" );
#! q(1)[t:1->1]
#! @EndExample

#! Construct the path algebra of this quiver over $\mathbb{Q}$.

#! @Example
Q := HomalgFieldOfRationals( );
#! Q
Qq := PathAlgebra( Q, q );
#! Q * q
#! @EndExample

#! Out of this path algebra construct the algebroid (actually the algebra) $B$ that is obtained as the quotient of the path algebra modulo the ideal $(t^3 - 1)$.

#! @Example
B := Algebroid( Qq, [ Qq.t^3 - Qq.1 ] );
#! Algebra generated by the right quiver q(1)[t:1->1]
RelationsOfAlgebroid( B );
#! [ (1)-[1*(t*t*t) - 1*(1)]->(1) ]
#! @EndExample

#! Construct the a $\mathbb{Q}$-linear morphism $\epsilon \colon B \to \QQ$ defined by $\epsilon(t)=1$.

#! @Example
counit := rec( t := 1 );
#! rec( t := 1 )
#! @EndExample

#! Construct the $\mathbb{Q}$-linear morphism $\Delta \colon B \to B \otimes_{\mathbb{Q}} B$ defined by $\Delta(t)= t \otimes t$.

#! @Example
B2 := B^2;
#! Algebra generated by the right quiver qxq(1x1)[1xt:1x1->1x1,tx1:1x1->1x1]
comult := rec( t := PreCompose( B2.tx1, B2.1xt ) );
#! rec( t := (1x1)-[{ 1*(1xt*tx1) }]->(1x1) )
#! @EndExample

#! Use $\epsilon$ and $\Delta$ to define a bialgebroid (actually bialgebra) structure on $B$.

#! @Example
AddBialgebroidStructure( B, counit, comult );
#! Bialgebra generated by the right quiver q(1)[t:1->1]
counit := Counit( B );
#! Functor from finitely presented Bialgebra generated by
#! the right quiver q(1)[t:1->1] -> Algebra generated by
#! the right quiver *(1)[]
ApplyFunctor( counit, B.1 );
#! (1)
ApplyFunctor( counit, B.t );
#! (1)-[1*(1)]->(1)
comult := Comultiplication( B );
#! Functor from finitely presented Bialgebra generated by
#! the right quiver q(1)[t:1->1] -> Algebra generated by
#! the right quiver qxq(1x1)[1xt:1x1->1x1,tx1:1x1->1x1]
ApplyFunctor( comult, B.1 );
#! (1x1)
ApplyFunctor( comult, B.t );
#! (1x1)-[{ 1*(1xt*tx1) }]->(1x1)
#! @EndExample

#! Let $A$ be the category of matrices as a skeletal model for the category of finite dimensional vector spaces over $\mathbb{Q}$.

#! @Example
LoadPackage( "LinearAlgebraForCAP" );
#! true
A := MatrixCategory( Q );
#! Category of matrices over Q
#! @EndExample

#! Construct the category of functors from $B$ to $A$.

#! @Example
H := Hom( B, A );
#! The category of functors: Bialgebra generated by
#! the right quiver q(1)[t:1->1] -> Category of matrices over Q
#! @EndExample

#! Verify that its zero object $z$ behaves as expected.

#! @Example
z := ZeroObject( H );
#! <A zero object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
z( B.1 );
#! <A vector space object over Q of dimension 0>
z( B.t );
#! <A zero, isomorphism in Category of matrices over Q>
idz := IdentityMorphism( z );
#! <A zero, identity morphism in The category of functors: Bialgebra
#!  generated by the right quiver q(1)[t:1->1] -> Category of matrices over Q>
idz( B.1 );
#! <A zero, identity morphism in Category of matrices over Q>
DirectSum( z, z );
#! <A zero object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
#! @EndExample

#! Construct a morphism $V$ in the category of functors from $B$ to $A$.

#! @Example
phi := HomalgMatrix( [ 0, 1, 0,  0, 0, 1,  1, 0, 0 ], 3, 3, Q );
#! <A 3 x 3 matrix over an internal ring>
V := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
V := rec( 1 := V, t := VectorSpaceMorphism( V, phi, V ) );
#! rec( 1 := <A vector space object over Q of dimension 3>,
#!      t := <A morphism in Category of matrices over Q> )
V := AsObjectInHomCategory( B, V );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
IsWellDefined( V );
#! true
#! @EndExample

#! Display some of the properties of this natural transformation.

#! @Example
V( B.1 );
#! <A vector space object over Q of dimension 3>
V( B.t );
#! <A morphism in Category of matrices over Q>
Display( V( B.t ) );
#! [ [  0,  1,  0 ],
#!   [  0,  0,  1 ],
#!   [  1,  0,  0 ] ]
#! 
#! A morphism in Category of matrices over Q
IsZero( V );
#! false
#! @EndExample

#! Costruct the direct sum of $V$ with itself.

#! @Example
W := DirectSum( V, V );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
W( B.1 );
#! <A vector space object over Q of dimension 6>
W( B.t );
#! <A morphism in Category of matrices over Q>
Display( W( B.t ) );
#! [ [  0,  1,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0 ],
#!   [  1,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  1,  0 ],
#!   [  0,  0,  0,  0,  0,  1 ],
#!   [  0,  0,  0,  1,  0,  0 ] ]
#! 
#! A morphism in Category of matrices over Q
#! @EndExample

#! Construct the projection $\pi_1$ from $V \oplus V$ to the first summand and study some of its properties.

#! @Example
pi1 := ProjectionInFactorOfDirectSum( [ V, V ], 1 );
#! <A morphism in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
pi1 = -pi1;
#! false
pi1( B.1 );
#! <A morphism in Category of matrices over Q>
Display( pi1( B.1 ) );
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ],
#!   [  0,  0,  1 ],
#!   [  0,  0,  0 ],
#!   [  0,  0,  0 ],
#!   [  0,  0,  0 ] ]
#! 
#! A morphism in Category of matrices over Q
IsWellDefined( pi1 );
#! true
IsEpimorphism( pi1 );
#! true
IsMonomorphism( pi1 );
#! false
#! @EndExample

#! Construct the kernel object $V1$ of $\pi_1$ and check that it is $V$.

#! @Example
V1 := KernelObject( pi1 );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
IsWellDefined( V1 );
#! true
V1 = V;
#! true
#! @EndExample

#! Construct the projection $\pi_2$ from $V \oplus V$ to the second summand and check that it is not equal to $\pi_1$.

#! @Example
pi2 := ProjectionInFactorOfDirectSum( [ V, V ], 2 );
#! <A morphism in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
pi1 = pi2;
#! false
#! @EndExample

#! Construct another object $U$ in the category of functors from $B$ to $A$.

#! @Example
psi := HomalgMatrix( [ 0, 1,  -1, -1 ], 2, 2, Q );
#! <A 2 x 2 matrix over an internal ring>
U := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
U := rec( 1 := U, t := VectorSpaceMorphism( U, psi, U ) );
#! rec( 1 := <A vector space object over Q of dimension 2>,
#!      t := <A morphism in Category of matrices over Q> )
U := CapFunctor( B, U );
#! Functor from finitely presented Bialgebra generated by
#! the right quiver q(1)[t:1->1] -> Category of matrices over Q
U := AsObjectInHomCategory( U );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
IsWellDefined( U );
#! true
U( B.1 );
#! <A vector space object over Q of dimension 2>
U( B.t );
#! <A morphism in Category of matrices over Q>
Display( U( B.t ) );
#! [ [   0,   1 ],
#!   [  -1,  -1 ] ]
#! 
#! A morphism in Category of matrices over Q
IsZero( U );
#! false
#! @EndExample

#! To construct a morphism $\eta$ from $U$ to $V$, we first define a HomAlg matrix.

#! @Example
eta := HomalgMatrix( [ 1, 0,  0, 1,  -1, -1 ], 3, 2, Q );
#! <A 3 x 2 matrix over an internal ring>
#! @EndExample

#! Then we define a record that will be used to define the natural transformation $\eta$.
#! Here `1' is the string representation of the only object of $B$ and the vector space morphism induced by the above matrix is the component of $\eta$ at this object.

#! @Example
eta := rec( 1 := VectorSpaceMorphism( V( B.1 ), eta, U( B.1 ) ) );
#! rec( 1 := <A morphism in Category of matrices over Q> )
#! @EndExample

#! Finally we define the natural transformation $\eta$ from $V$ to $U$ as a morphism in the category of functors from $B$ to $A$.

#! @Example
eta := AsMorphismInHomCategory( V, eta, U );
#! <A morphism in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
#! @EndExample

#! We check that $\eta$ is well defined.

#! @Example
IsWellDefined( eta );
#! true
#! @EndExample

#! We retrieve the component of $\eta$ at the object 1 of $B$.

#! @Example
eta( B.1 );
#! <A morphism in Category of matrices over Q>
Display( eta( B.1 ) );
#! [ [   1,   0 ],
#!   [   0,   1 ],
#!   [  -1,  -1 ] ]
#! 
#! A morphism in Category of matrices over Q
#! @EndExample

#! We study some of the properties of $\eta$.

#! @Example
IsEpimorphism( eta );
#! true
IsMonomorphism( eta );
#! false
#! @EndExample

#! Construct the kernel object of $\eta$.

#! @Example
K := KernelObject( eta );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
K( B.1 );
#! <A vector space object over Q of dimension 1>
K( B.t );
#! <A morphism in Category of matrices over Q>
Display( K( B.t ) );
#! [ [  1 ] ]
#! 
#! A morphism in Category of matrices over Q
iota := KernelEmbedding( eta );
#! <A monomorphism in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
C := CokernelObject( iota );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
C = U;
#! true
#! @EndExample

#! Now we study the monoidal structure.
#! First we obtain the unit object $I$ of the monoidal category.

#! @Example
I := TensorUnit( H );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
I( B.1 );
#! <A vector space object over Q of dimension 1>
I( B.t );
#! <A morphism in Category of matrices over Q>
Display( I( B.t ) );
#! [ [  1 ] ]
#! 
#! A morphism in Category of matrices over Q
#! @EndExample

#! It turns out that $I$ is equal to $K$.

#! @Example
I = K;
#! true
#! @EndExample

#! Construct the tensor product $V \otimes V$.

#! @Example
VV := TensorProductOnObjects( V, V );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
VV( B.1 );
#! <A vector space object over Q of dimension 9>
VV( B.t );
#! <A morphism in Category of matrices over Q>
Display( VV( B.t ) );
#! [ [  0,  0,  0,  0,  1,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  1,  0,  0,  0 ],
#!   [  0,  0,  0,  1,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0,  1,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0,  0,  1 ],
#!   [  0,  0,  0,  0,  0,  0,  1,  0,  0 ],
#!   [  0,  1,  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0,  0,  0,  0 ],
#!   [  1,  0,  0,  0,  0,  0,  0,  0,  0 ] ]
#! 
#! A morphism in Category of matrices over Q
#! @EndExample

#! Compute the dual object of $V$.

#! @Example
Vs := DualOnObjects( V );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
Vs( B.1 );
#! <A vector space object over Q of dimension 3>
Vs( B.t );
#! <A morphism in Category of matrices over Q>
Display( Vs( B.t ) );
#! [ [  0,  0,  1 ],
#!   [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
#! A morphism in Category of matrices over Q
epsilon := MorphismToBidual( V );
#! <A morphism in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
Source( epsilon ) = V;
#! true
Range( epsilon ) = V;
#! true
EndV := InternalHomOnObjects( V, V );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
VsV := TensorProductOnObjects( Vs, V );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
VVs := TensorProductOnObjects( V, Vs );
#! <An object in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
EndV = VsV;
#! true
EndV = VVs;
#! false
beta := Braiding( Vs, V );
#! <A morphism in The category of functors: Bialgebra generated by
#!  the right quiver q(1)[t:1->1] -> Category of matrices over Q>
Source( beta ) = VsV;
#! true
Range( beta ) = VVs;
#! true
#! @EndExample
