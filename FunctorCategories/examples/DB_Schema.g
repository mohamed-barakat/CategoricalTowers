LoadPackage( "FunctorCategories" );

db_quiver := RightQuiver( "q(E,D,S)[M:E->E,W:E->D,A:D->E,F:E->S,N:D->S]" );

F := FreeCategory( db_quiver );

F.AW = PreCompose( F.A, F.W );

db_schema := F / [ [ F.AW, F.D ], [ F.MW, F.W ] ]; ## F.D is a placeholder for IdentityMorphism( F.D )

DB := FunctorCategory( db_schema, FinSets );

E1 := FinSet( [ 1, 2, 3 ] );
D1 := FinSet( [ 101, 102 ] );
S1 := FinSet( [ "Alan", "Ruth", "Chris", "Sales", "IT" ] );

M1 := MapOfFinSets( E1, [ [ 1, 2 ], [ 2, 2 ], [ 3, 3 ] ], E1 );
W1 := MapOfFinSets( E1, [ [ 1, 101 ], [ 2, 101 ], [ 3, 102 ] ], D1 );
A1 := MapOfFinSets( D1, [ [ 101, 1 ], [ 102, 3 ] ], E1 );
F1 := MapOfFinSets( E1, [ [ 1, "Alan" ], [ 2, "Ruth" ], [ 3, "Chris" ] ], S1 );
N1 := MapOfFinSets( D1, [ [ 101, "Sales" ], [ 102, "IT" ] ], S1 );

I1 := AsObjectInFunctorCategory( db_schema, [ E1, D1, S1 ], [ M1, W1, A1, F1, N1 ] );
