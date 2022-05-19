#! @Chunk ZariskiCoframe

#! @Example
LoadPackage( "ZariskiFrames" );
#! true
Q := HomalgFieldOfRationalsInSingular( );
#! Q
R := Q["x,y"];
#! Q[x,y]
ZC := ZariskiCoframeOfAffineSpectrum( R );
#! The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]
U := ObjectConstructor( ZC, HomalgMatrix( "[ y ]", 2, 1, R ) );
#! V_{Q[x,y]}( <...> )
V := ObjectConstructor( ZC, HomalgMatrix( "[ x ]", 1, 1, R ) );
#! V_{Q[x,y]}( <...> )
W := ObjectConstructor( ZC, HomalgMatrix( "[ x, y ]", 2, 1, R ) );
#! V_{Q[x,y]}( <...> )
VW := TensorProduct( V, W );
#! V_{Q[x,y]}( <...> )
VuW := Coproduct( V, W );
#! V_{Q[x,y]}( <...> )
IsHomSetInhabited( VW, VuW );
#! true
IsHomSetInhabited( VuW, VW );
#! true
VuW = V;
#! true
VnW := DirectProduct( V, W );
#! V_{Q[x,y]}( <...> )
VnW = W;
#! true
VW_W := InternalCoHom( VW, W );
#! V_{Q[x,y]}( <...> )
VW_W = V;
#! true
iota := InternalCoHom( VW, UniversalMorphismFromInitialObject( W ) );
#! <An epi-, monomorphism in
#!  The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
IsWellDefined( iota );
#! true
IsOne( iota );
#! true
VWW := TensorProduct( VW, W );
#! V_{Q[x,y]}( <...> )
VWW_W := InternalCoHom( VWW, W );
#! V_{Q[x,y]}( <...> )
VWW_W = V;
#! true
#! @EndExample
