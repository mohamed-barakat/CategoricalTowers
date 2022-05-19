#! @Chunk ZariskiFrame

#! @Example
LoadPackage( "ZariskiFrames" );
#! true
Q := HomalgFieldOfRationalsInSingular( );
#! Q
R := Q["x,y"];
#! Q[x,y]
ZF := ZariskiFrameOfAffineSpectrum( R );
#! The frame of Zariski open subsets of the affine spectrum of Q[x,y]
I := ObjectConstructor( ZF, HomalgMatrix( "[ x ]", 1, 1, R ) );
#! D_{Q[x,y]}( <...> )
J := ObjectConstructor( ZF, HomalgMatrix( "[ x, y ]", 2, 1, R ) );
#! D_{Q[x,y]}( <...> )
IJ := TensorProduct( I, J );
#! D_{Q[x,y]}( <...> )
IiJ := DirectProduct( I, J );
#! D_{Q[x,y]}( <...> )
IsHomSetInhabited( IJ, IiJ );
#! true
IsHomSetInhabited( IiJ, IJ );
#! true
IiJ = I;
#! true
IpJ := Coproduct( I, J );
#! D_{Q[x,y]}( <...> )
IpJ = J;
#! true
IJqJ := InternalHom( J, IJ ); ## this is the ideal quotient IJ : J
#! D_{Q[x,y]}( <...> )
IJqJ = I;
#! true
iota := InternalHom( UniversalMorphismIntoTerminalObject( J ), IJ );
#! <An epi-, monomorphism in
#!  The frame of Zariski open subsets of the affine spectrum of Q[x,y]>
IsWellDefined( iota );
#! true
IsOne( iota );
#! true
IJJ := TensorProduct( IJ, J );
#! D_{Q[x,y]}( <...> )
IJJqJ := InternalHom( J, IJJ );
#! D_{Q[x,y]}( <...> )
IJJqJ = I;
#! true
#! @EndExample
