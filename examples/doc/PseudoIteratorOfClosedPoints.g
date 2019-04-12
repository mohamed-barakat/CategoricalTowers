#! @System PseudoIteratorOfClosedPoints

LoadPackage( "ZariskiFrames" );

#! @Example
ZZ := HomalgRingOfIntegersInSingular( );
#! Z
T := ClosedSubsetOfSpec( "", ZZ );
#! V_{Z}( <...> )
Display( T );
#! V( <> )
iter := PseudoIteratorOfClosedPoints( T );
#! <iterator of closed singletons of V_{Z}( <...> )>
iter2 := ShallowCopy( iter );
#! <iterator of closed singletons of V_{Z}( <...> )>
p := NextIterator( iter );
#! <An unevaluated 0 x 1 zero matrix over an external ring>
HomalgRing( p );
#! GF(2)
p := NextIterator( iter );; HomalgRing( p );
#! GF(3)
iter;
#! <iterator of closed singletons of V_{Z}( I ) \ V_{Z}( J )>
List( [ 1 .. 10 ], i -> HomalgRing( NextIterator( iter2 ) ) );
#! [ GF(2), GF(3), GF(5), GF(7), GF(11), GF(13), GF(17), GF(19), GF(23), GF(29) ]
#! @EndExample
