#! @Chunk Bimon_test

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "ZariskiFrames", false );
#! true
F3 := HomalgRingOfIntegersInSingular( 3 );
#! GF(3)
F3mat := CategoryOfRows( F3 );;
#! Rows( GF(3) )
ComonF3mat := CategoryOfComonoids( F3mat );
#! CategoryOfComonoids( Rows( GF(3) ) )
HmonF3mat := CategoryOfHopfMonoids( F3mat );
#! CategoryOfHopfMonoids( Rows( GF(3) ) )
R := F3["c1..168"];;
SetName( R, "GF(3)[c1..168]" );
S := F3["c1..168,s1..9"];;
SetName( S, "GF(3)[c1..168,s1..9]" );
Rmat := CategoryOfRows( R );
#! Rows( GF(3)[c1..144] )
Smat := CategoryOfRows( S );
#! Rows( GF(3)[c1..168,s1..9] )
ComonSmat := CategoryOfComonoids( Smat );;
#! CategoryOfComonoids( Rows( GF(3)[c1..168,s1..9] ) )
BimonSmat := CategoryOfBimonoids2( Smat );
#! CategoryOfBimonoids2( Rows( GF(3)[c1..168,s1..9] ) )
HmonSmat := CategoryOfHopfMonoids( Smat : reverse := true );
#! CategoryOfHopfMonoids( Rows( GF(3)[c1..168,s1..9] ) )
I := TensorUnit( ComonSmat );
#! <An object in CategoryOfComonoids( Rows( GF(3) ) )>
U := TensorUnit( Smat );
#! <A row module over GF(3) of rank 1>
V := 4 / Smat;
#! <A row module over GF(3) of rank 4>
V2 := TensorProduct( V, V );
#! <A row module over GF(3) of rank 16>
counit := HomalgMatrix( [ 1, 0, 0, 1 ], 4, 1, S );;
counit := CategoryOfRowsMorphism( V, counit, U );;
id := HomalgIdentityMatrix( 4, S );;
comult := [ KroneckerMat( id[1], id[1] ) + KroneckerMat( id[2], id[3] ),
            KroneckerMat( id[1], id[2] ) + KroneckerMat( id[2], id[4] ),
            KroneckerMat( id[3], id[1] ) + KroneckerMat( id[4], id[3] ),
            KroneckerMat( id[3], id[2] ) + KroneckerMat( id[4], id[4] ) ];;
comult := UnionOfRows( comult );;
comult := CategoryOfRowsMorphism( V, comult, V2 );;
c := ObjectConstructor( ComonSmat, Triple( V, counit, comult ) );
Assert( 0, IsWellDefined( c ) );
iso4 := LeftInverse( UnionOfRows( [ id[1]+id[4], id[2], id[3], id[4] ] ) ) / Smat;
inv := DiagMat( [ HomalgIdentityMatrix( 2, F3 ), F3 * UnionOfRows( [ id[1]+id[4], id[2], id[3], id[4] ] ) ] );
C := TransformedComonoid( iso4, c );
#! <An object in CategoryOfComonoids( Rows( GF(3) ) )>
Assert( 0, IsWellDefined( C ) );
comon := Coproduct( [ I, I, C ] );
Assert( 0, IsWellDefined( comon ) );
object := UnderlyingObject( comon );
counit := ObjectDatum( comon )[2];
comult := ObjectDatum( comon )[3];
id6 := HomalgIdentityMatrix( 6, S );
unit := id6[1];
unit := CategoryOfRowsMorphism( Target( counit ), unit, Source( counit ) );
mult := HomalgMatrix( Indeterminates( S ){[ 1 .. (36 - 8) * 6 ]}, 36 - 8, 6, S );
mult := UnionOfRows( id6, id6[2], id6[1], mult );
mult := CategoryOfRowsMorphism( Target( comult ), mult, Source( comult ) );
antipode := HomalgMatrix( Indeterminates( S ){[ (36 - 8) * 6 + 1 .. (36 - 8) * 6 + 9 ]}, 3, 3, S );;
antipode := DiagMat( [ HomalgIdentityMatrix( 3, S ), antipode ] );
antipode := CategoryOfRowsMorphism( object, antipode, object );
hmon := ObjectConstructor( HmonSmat, NTuple( 6, object, unit, mult, counit, comult, antipode ) );
obstruction := [ ];; IsWellDefined( hmon : obstruction := obstruction );
all := UnionOfRows( List( obstruction, pair -> ConvertMatrixToColumn( pair[1] - pair[2] ) ) );
all := CertainRows( all, NonZeroRows( all ) );
gamma := ClosedSubsetOfSpec( all );
SetParametrizedObject( gamma, hmon );
rho := EmbedInSmallerAmbientSpaceUsingLinearRelations( gamma );
T := UnderlyingRing( rho );
rel := UnderlyingColumn( rho );
radicals := [ ];
func_smp :=
  function( gamma, radicals, i )
    local rel, affind, aff, nonaffind, nonaff, affall, rho;
    Display( "--------" );
    Display( i );
    Display( NrRows( radicals[i] ) );
    
    rel := UnderlyingColumn( gamma );
    affind := Filtered( [ 1 .. NrRows( rel ) ], i -> Degree( rel[i,1] ) <= 1 );
    aff := CertainRows( rel, affind );
    nonaffind := Difference( [ 1 .. NrRows( rel ) ], affind );
    nonaff := CertainRows( rel, nonaffind );
    affall := BasisOfRows( UnionOfRows( aff, radicals[i] ) );
    
    Display( NrRows( affall ) );
    Display( "--------" );
    
    rho := DecideZeroRows( nonaff, affall );
    rho := CertainRows( rho, NonZeroRows( rho ) );
    rho := ClosedSubsetOfSpec( UnionOfRows( rho, affall ) );
    SetParametrizedObject( rho, ParametrizedObject( gamma ) );
    return rho;
    
    #return EmbedInSmallerAmbientSpaceUsingLinearRelations( rho );
end;
func_rad :=
  function( gamma, radicals, i )
    local rho, rel, quadind, quad, nonquadind, nonquad;
    
    rho := func_smp( gamma, radicals, i ); ## 4 branches: (793, 11), (797, 6), (921, 17), (925, 6)
    rel := UnderlyingColumn( rho );
    
    quadind := Filtered( [ 1 .. NrRows( rel ) ], i -> Degree( rel[i,1] ) = 2 and Length( Factors( rel[i,1] ) ) > 1 );
    quad := CertainRows( rel, quadind );
    nonquadind := Difference( [ 1 .. NrRows( rel ) ], quadind );
    nonquad := CertainRows( rel, nonquadind );
    radicals := RadicalDecompositionOp( quad );
    List( radicals, NrRows );
    
    return radicals;
end;
func_cmp :=
  function( gamma, radicals, i, j )
    local rho, rel, quadind, quad, nonquadind, nonquad;
    
    rho := func_smp( gamma, radicals, i ); ## 4 branches: (793, 11), (797, 6), (921, 17), (925, 6)
    rel := UnderlyingColumn( rho );
    
    quadind := Filtered( [ 1 .. NrRows( rel ) ], i -> Degree( rel[i,1] ) = 2 and Length( Factors( rel[i,1] ) ) > 1 );
    quad := CertainRows( rel, quadind );
    nonquadind := Difference( [ 1 .. NrRows( rel ) ], quadind );
    nonquad := CertainRows( rel, nonquadind );
    radicals := RadicalDecompositionOp( quad );
    List( radicals, NrRows );
    
    return func_smp( rho, radicals, j );
end;

#for i in [ 1 .. 2^10 ] do SaveHomalgMatrixToFile( Concatenation( "radicals_of_linear_equations_F3/radicals_of_linear_equations_", String( i ) ), radicals[i] ); od;
radicals := [ ];; for i in [ 1 .. 2^10 ] do radicals[i] := LoadHomalgMatrixFromFile( Concatenation( "radicals_of_linear_equations_F3/radicals_of_linear_equations_", String( i ) ), 30, 1, T ); od; radicals := List( radicals, mat -> CertainRows( mat, NonZeroRows( mat ) ) );

Assert( 0, Length( radicals ) = 2^10 );

break;

## 4 branches: (793, 11), (797, 6), (921, 17), (925, 6)
rad1 := func_rad( rho, radicals, 793 ); 
rad2 := func_rad( rho, radicals, 797 );
rad3 := func_rad( rho, radicals, 921 );

rho1 := func_cmp( rho, radicals, 793, 11 ); 
rho2 := func_cmp( rho, radicals, 797, 6 );
rho3 := func_cmp( rho, radicals, 921, 17 );

rel1 := UnderlyingColumn( rho1 );
rel2 := UnderlyingColumn( rho2 );
rel3 := UnderlyingColumn( rho3 );

bas1 := BasisOfRows( rel1 );
bas2 := BasisOfRows( rel2 );
bas3 := BasisOfRows( rel3 );


rho4 := func_cmp( rho, radicals, 925, 6 );

rel4 := UnderlyingColumn( rho4 );
bas4 := BasisOfRows( rel4 );

#BasisOfRows( rel4 ); ## took 4d11h and 12GB virt and 6GB res
#<A non-zero right regular 117 x 1 matrix over an external ring>

bas4 := LoadHomalgMatrixFromFile( "radicals_of_linear_equations_F3/bas4.txt", 117, 1, HomalgRing( rel4 ) );
SetBasisOfRowModule( rel4, bas4 );
SetBasisOfRowModule( bas4, bas4 );

Assert( 0, IsCommutative( ParametrizedObject( rho4 ) ) );
Assert( 0, not IsCocommutative( ParametrizedObject( rho4 ) ) );

break;

func_bas :=
  function( gamma, radicals, i )
    local bas;
    Display( "--------" );
    Display( i );
    Display( NrRows( radicals[i] ) );
    bas := BasisOfRows( UnionOfRows( radicals[i], UnderlyingColumn( gamma ) ) );
    Display( bas );
    Display( "--------" );
    return bas;
end;

bas := List( [ 1 .. Length( radicals ) ], i -> func_bas( rho, radicals, i ) );

break;

point := AClosedPoint( rho4 );
cex := TransformedHopfMonoid( inv / UnderlyingCategory( CapCategory( point ) ), point );
ex := DualHopfMonoid( cex );

break;

#! @EndExample
