#! @Chunk FreeBooleanAlgebra

#! @Example
LoadPackage( "FunctorCategories", false );
#! true
LoadPackage( "Locales", false );
#! true
Q := RightQuiver( "Q(f,p,q,t)[a:f->p,b:p->t,c:f->q,d:q->t]" );
#! Q(f,p,q,t)[a:f->p,b:p->t,c:f->q,d:q->t]
F := FreeCategory( Q );
#! FreeCategory( RightQuiver( "Q(f,p,q,t)[a:f->p,b:p->t,c:f->q,d:q->t]" ) )
C := F / [ [ F.ab, F.cd ] ];
#! FreeCategory( RightQuiver( "Q(f,p,q,t)[a:f->p,b:p->t,c:f->q,d:q->t]" ) )
#! / [ a*b = c*d ]
B := PosetOfCategory( C );
#! PosetOfCategory( FreeCategory(
#! RightQuiver( "Q(f,p,C,t)[a:f->p,b:p->t,c:f->q,d:q->t]" ) ) / [ a*b = c*d ] )
PSh := PreSheaves( B );
#! PreSheaves( PosetOfCategory( FreeCategory(
#! RightQuiver( "Q(f,p,q,t)[a:f->p,b:p->t,c:f->q,d:q->t]" ) ) / [ a*b = c*d ] ),
#! IntervalCategory )
Display( PSh );
#! A CAP category with name
#! PreSheaves( PosetOfCategory( FreeCategory(
#! RightQuiver( "Q(f,p,q,t)[a:f->p,b:p->t,c:f->q,d:q->t]" ) ) / [ a*b = c*d ] ),
#! IntervalCategory ):
#! 
#! 60 primitive operations were used to derive 203 operations for this category
#! which algorithmically
#! * IsEquippedWithHomomorphismStructure
#! * IsDistributiveLattice
#! and furthermore mathematically
#! * IsBiHeytingAlgebra (but not yet algorithmically)
f := PSh.f;
#! <A projective object in PreSheaves( PosetOfCategory( FreeCategory(
#!  RightQuiver( "Q(f,A,C,t)[a:f->A,b:A->t,c:f->C,d:C->t]" ) ) / [ a*b = c*d ] ),
#!  IntervalCategory )>
p := PSh.p;
#! <A projective object in PreSheaves( PosetOfCategory( FreeCategory(
#!  RightQuiver( "Q(f,A,C,t)[a:f->A,b:A->t,c:f->C,d:C->t]" ) ) / [ a*b = c*d ] ),
#!  IntervalCategory )>
q := PSh.q;
#! <A projective object in PreSheaves( PosetOfCategory( FreeCategory(
#!  RightQuiver( "Q(f,A,C,t)[a:f->A,b:A->t,c:f->C,d:C->t]" ) ) / [ a*b = c*d ] ),
#!  IntervalCategory )>
t := PSh.t;
#! <A projective object in PreSheaves( PosetOfCategory( FreeCategory(
#!  RightQuiver( "Q(f,A,C,t)[a:f->A,b:A->t,c:f->C,d:C->t]" ) ) / [ a*b = c*d ] ),
#!  IntervalCategory )>
PSh!.Name := "PSh";
i := InitialObject( PSh );
poq := p + q;
piq := -p + q;
qip := -q + p;
nponq := -q + -p;
peq := qip * piq;
penq := ( poq - i ) * nponq;
np := -p;
nq := -q;
puq := DirectProduct( p, q );
punq := p * nq;
npuq := np * q;
npunq := np * nq;
L := [ t, poq, qip, piq, nponq, p, q, peq, penq, nq, np, puq, punq, npuq, npunq, i ];
Assert( 0, Length( L ) = 16 );
Assert( 0, Length( DuplicateFreeList( L ) ) = 16 );
digraph := DigraphReflexiveTransitiveReduction( Digraph( L, { a, b } -> IsInitial( a - b ) ) );
#Splash( DotVertexLabelledDigraph( digraph ) );

#! @EndExample
