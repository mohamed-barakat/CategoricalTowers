#! @Chunk Bimon_test

#! @Example

LoadPackage( "InternalModules", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "ZariskiFrames", false );
#! true
F5 := HomalgRingOfIntegersInSingular( 5 );
#! GF(5)
F5mat := CategoryOfRows( F5 );;
#! Rows( GF(5) )
ComonF5mat := CategoryOfComonoids( F5mat );;
#! CategoryOfComonoids( Rows( GF(5) ) )
R := F5["c1..168"];;
SetName( R, "GF(5)[c1..168]" );
S := F5["c1..168,s1..9"];;
SetName( S, "GF(5)[c1..168,s1..9]" );
Rmat := CategoryOfRows( R );
#! Rows( GF(5)[c1..144] )
Smat := CategoryOfRows( S );
#! Rows( GF(5)[c1..168,s1..9] )
ComonSmat := CategoryOfComonoids( Smat );;
#! CategoryOfComonoids( Rows( GF(5)[c1..168,s1..9] ) )
BimonSmat := CategoryOfBimonoids2( Smat );
#! CategoryOfBimonoids2( Rows( GF(5)[c1..168,s1..9] ) )
HmonSmat := CategoryOfHopfMonoids( Smat : reverse := true );
#! CategoryOfHopfMonoids( Rows( GF(5)[c1..168,s1..9] ) )
I := TensorUnit( ComonSmat );
#! <An object in CategoryOfComonoids( Rows( GF(5) ) )>
U := TensorUnit( Smat );
#! <A row module over GF(5) of rank 1>
V := 4 / Smat;
#! <A row module over GF(5) of rank 4>
V2 := TensorProduct( V, V );
#! <A row module over GF(5) of rank 16>
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
iso := LeftInverse( UnionOfRows( [ id[1]+id[4], id[2], id[3], id[4] ] ) ) / Smat;
C := TransformedComonoid( iso, c );
#! <An object in CategoryOfComonoids( Rows( GF(5) ) )>
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
SetParametrizedObject( gamma, UnderlyingMatrix( mult ) );
gamma_small := EmbedInSmallerAmbientSpaceUsingLinearRelations( gamma );
T := UnderlyingRing( gamma_small );
rel := UnderlyingColumn( gamma_small );
radicals := [ ];
func_smp := function( i )
    local rho;
    Display( "--------" );
    Display( i );
    Display( NrRows( radicals[i] ) );
    Display( "--------" );
    rho := ClosedSubsetOfSpec( UnionOfRows( radicals[i], rel ) );
    SetParametrizedObject( rho, ParametrizedObject( gamma_small ) );
    return EmbedInSmallerAmbientSpaceUsingLinearRelations( rho );
end;
func_bas := function( i )
    local bas;
    Display( "--------" );
    Display( i );
    Display( NrRows( radicals[i] ) );
    bas := BasisOfRows( UnionOfRows( radicals[i], rel ) );
    Display( bas );
    Display( "--------" );
    return bas;
end;
break;

linind := Filtered( [ 1 .. NrRows( rel ) ], i -> Degree( rel[i,1] ) = 2 and Length( Factors( rel[i,1] ) ) > 1 );
lin := CertainRows( rel, linind );
nonlinind := Difference( [ 1 .. NrRows( rel ) ], linind );
nonlin := CertainRows( rel, nonlinind );
radicals := RadicalDecompositionOp( lin );
Assert( 0, Length( radicals ) = 2^10 );
List( radicals, NrRows );

bas := List( [ 794 .. 2^10 ], func_bas );

#bas := List( [ 1 .. 2^10 ], func_bas );

break;

#for i in [ 1 .. 2^10 ] do SaveHomalgMatrixToFile( Concatenation( "radicals_of_linear_equations_F5/radicals_of_linear_equations_", String( i ) ), radicals[i] ); od;
radicals := [ ]; for i in [ 1 .. 2^10 ] do radicals[i] := LoadHomalgMatrixFromFile( Concatenation( "radicals_of_linear_equations_F5/radicals_of_linear_equations_", String( i ) ), 30, 1, T ); od; radicals := List( radicals, mat -> CertainRows( mat, NonZeroRows( mat ) ) );

break;

homalgIOMode( "D" );

bas := List( [ 1 .. 2^10 ], func_bas );
smp := List( [ 1 .. 2^10 ], func_smp );

rho := func_smp( 793 );
rad := UnderlyingColumn( rho );

break;

#! @EndExample
