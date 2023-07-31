LoadPackage( "Algebroids", false );
#! true
LoadPackage( "FiniteCocompletions", false );
#! true
LoadPackage( "LazyCategories", false );
#! true
q := FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" );
#! q(4)[a:1->2,b:2->3,c:3->4]
Fq := PathCategory( q );
#! PathCategory( Quiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) )
Q := HomalgFieldOfRationals( );
#! Q
Qq := LinearClosure( Q, Fq );
#! Q-LinearClosure( PathCategory( Quiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) ) )
L := Qq / [ Qq.abc ];
#! Q-LinearClosure( PathCategory( Quiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) ) )
#! / [ 1*a•b•c ]
#! / relations
A := AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure( L );
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Algebroid( Q, FreeCategory( RightQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / relations )
a := A.a;
#! <A morphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Algebroid( Q, FreeCategory( RightQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / relations )>
b := A.b;
#! <A morphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Algebroid( Q, FreeCategory( RightQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / relations )>
c := A.c;
#! <A morphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Algebroid( Q, FreeCategory( RightQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / relations )>
IsZero( PreCompose( [ a, b, c ] ) );
#! true

snake :=
  function ( T_1, a_1, b_1, c_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1,
    deduped_13_1, deduped_14_1, deduped_15_1, ker3, ker33, mor1, lambda, ker2, ker22, mor2, kappa, mu;
    deduped_15_1 := Source( c_1 );
    deduped_14_1 := Range( c_1 );
    deduped_13_1 := Source( a_1 );
    deduped_12_1 := Source( b_1 );
    deduped_11_1 := PreCompose( T_1, b_1, c_1 );
    deduped_10_1 := [ deduped_14_1, deduped_15_1 ];
    deduped_9_1 := [ deduped_15_1, deduped_13_1 ];
    deduped_8_1 := [ deduped_14_1, deduped_12_1 ];
    deduped_7_1 := [ deduped_12_1, deduped_13_1 ];
    deduped_6_1 := IdentityMorphism( T_1, deduped_15_1 );
    deduped_5_1 := ZeroMorphism( T_1, deduped_13_1, deduped_14_1 );
    deduped_4_1 := IdentityMorphism( T_1, deduped_12_1 );
    deduped_3_1 :=
      UniversalMorphismFromDirectSum( T_1,
              deduped_9_1,
              DirectSum( T_1, deduped_10_1 ),
              [ UniversalMorphismIntoDirectSum( T_1,
                      deduped_10_1,
                      deduped_15_1,
                      [ c_1, IdentityMorphism( T_1, Source( c_1 ) ) ] ),
                UniversalMorphismIntoDirectSum( T_1,
                        deduped_10_1,
                        deduped_13_1,
                        [ ZeroMorphism( T_1, Source( a_1 ), Range( c_1 ) ), ZeroMorphism( T_1, Source( a_1 ), Source( c_1 ) ) ] ) ] );
    
    deduped_2_1 :=
      UniversalMorphismFromDirectSum( T_1,
              deduped_7_1,
              DirectSum( T_1, deduped_8_1 ),
              [ UniversalMorphismIntoDirectSum( T_1,
                      deduped_8_1,
                      deduped_12_1,
                      [ PreCompose( T_1, b_1, c_1 ), IdentityMorphism( T_1, Source( b_1 ) ) ] ),
                UniversalMorphismIntoDirectSum( T_1,
                        deduped_8_1,
                        deduped_13_1,
                        [ ZeroMorphism( T_1, Source( a_1 ), Range( c_1 ) ), AdditiveInverseForMorphisms( T_1, a_1 ) ] ) ] );

    ker3 := KernelEmbedding( T_1, deduped_3_1 );

    ## ( 0_{s(a), s(c)},  1_{s(a)} )
    ker33 := UniversalMorphismIntoDirectSum( T_1,
                     [ ZeroMorphism( T_1, Source( a_1 ), Source( c_1 ) ),
                       IdentityMorphism( T_1, Source( a_1 ) ) ] );
    
    Assert( 0, IsEqualAsSubobjects( ker3, ker33 ) );
    
    ## if ker3 = ker33: mor1 = a * b
    mor1 := PreCompose( T_1,
                    ker33,
                    UniversalMorphismFromDirectSum( T_1,
                            deduped_9_1,
                            deduped_15_1,
                            [ IdentityMorphism( T_1, Source( c_1 ) ), PreCompose( T_1, a_1, b_1 ) ] ) );
    
    deduped_1_1 :=
      KernelLift( T_1,
              c_1,
              KernelObject( T_1, deduped_3_1 ),
              mor1 );
    
    lambda := deduped_1_1;
    
    ker2 := KernelEmbedding( T_1, deduped_2_1 );
    
    ker22 := UniversalMorphismIntoDirectSum( T_1,
                     [ a_1, IdentityMorphism( T_1, Source( a_1 ) ) ] );
    
    Assert( 0, IsEqualAsSubobjects( ker2, ker22 ) );
    
    mor2 := PreCompose( T_1,
                    ker22,
                    UniversalMorphismFromDirectSum( T_1,
                            deduped_7_1,
                            deduped_12_1,
                            [ IdentityMorphism( T_1, Source( b_1 ) ), ZeroMorphism( T_1, Source( a_1 ), Source( b_1 ) ) ] ) );
    
    Assert( 0, mor2 = a_1 );
    
    kappa := KernelLift( T_1,
                     PreCompose( T_1, b_1, c_1 ),
                     KernelObject( T_1, deduped_2_1 ),
                     mor2 );
    
    mu := KernelLift( T_1,
                  c_1,
                  KernelObject( T_1, PreCompose( T_1, b_1, c_1 ) ),
                  PreCompose( T_1,
                          KernelEmbedding( T_1, PreCompose( T_1, b_1, c_1 ) ),
                          b_1 ) );
    
    return CokernelColift( T_1,
                   kappa,
                   CokernelObject( T_1, lambda ),
                   PreCompose( T_1,
                           mu,
                           CokernelProjection( T_1, lambda ) ) );
end;

snake2 :=
  function( A, a, b, c )
    local mu, lambda, kappa;
    
    mu := KernelLift( c, KernelEmbedding( b * c ) * b );
    
    lambda := KernelLift( c, a * b );
    
    kappa := KernelLift( b * c, a );

    return CokernelColift( kappa, mu * CokernelProjection( lambda ) );
    
end;

Assert( 0, snake( A, a, b, c ) = snake2( A, a, b, c ) );
