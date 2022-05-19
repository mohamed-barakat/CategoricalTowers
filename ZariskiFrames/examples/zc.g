#! @Chunk ZariskiCoframe

LoadPackage( "ZariskiFrames" );

#! @Example
Q := HomalgFieldOfRationalsInSingular( );
#! Q
R := Q["x,y"];
#! Q[x,y]
ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
#! The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]
V := ClosedSubsetOfSpec( HomalgMatrix( "[ x ]", 1, 1, R ) );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
W := ClosedSubsetOfSpec( HomalgMatrix( "[ x, y ]", 2, 1, R ) );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
VW := ClosedSubsetOfSpec( HomalgMatrix( "[ x^2, x*y ]", 2, 1, R ) );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
VuW := Coproduct( V, W );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
IsHomSetInhabited( VW, VuW );
#! true
IsHomSetInhabited( VuW, VW );
#! true
VuW = V;
#! true
VnW := DirectProduct( V, W );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
VnW = W;
#! true
VW_W := CoexponentialOnObjects( VW, W );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
VW_W = V;
#! true
iota := CoexponentialOnMorphisms( IdentityMorphism( VW ), UniversalMorphismFromInitialObject( W ) );
#! <A morphism in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
IsWellDefined( iota );
#! true
IsOne( iota );
#! true
VWW := DirectProduct( VW, W );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
VWW_W := CoexponentialOnObjects( VWW, W );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Q[x,y]>
VWW_W = W;
#! true
#! @EndExample
