#! @Chunk precompileSnakeInFreeAbelian

#! @Example
LoadPackage( "FiniteCocompletions", false );
#! true
q := FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" );
#! q(4)[a:1->2,b:2->3,c:3->4]
Fq := PathCategory( q );
#! PathCategory( FinQuiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) )
Q := HomalgFieldOfRationals( );
#! Q
Qq := LinearClosure( Q, Fq );
#! Q-LinearClosure( PathCategory( FinQuiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) ) )
L := Qq / [ Qq.abc ];
#! Q-LinearClosure( PathCategory( FinQuiver( "q(1,2,3,4)[a:1-≻2,b:2-≻3,c:3-≻4]" ) ) )
#! / [ 1*a•b•c ]
A := AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure( L );
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )
a := A.a;
#! <A morphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
b := A.b;
#! <A morphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
c := A.c;
#! <A morphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
IsZero( PreCompose( [ a, b, c ] ) );
#! true
d := CokernelProjection( a );
#! <An epimorphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
e := CokernelColift( a, PreCompose( b, c ) );
#! <A morphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
f := KernelEmbedding( e );
#! <A monomorphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
g := KernelEmbedding( c );
#! <A monomorphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
h := KernelLift( c, PreCompose( a, b ) );
#! <A morphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
i := CokernelProjection( h );
#! <An epimorphism in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
ker := Source( f );
#! <An object in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
coker := Target( i );
#! <An object in
#! AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#! Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#! / [ 1*a•b•c ] )>
HomStructure( ker, coker );
#! <A row module over Q of rank 1>
hom_ker_coker := BasisOfExternalHom( ker, coker );
#! [ <A morphism in
#!    AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#!    Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#!    / [ 1*a•b•c ] )> ]
s := hom_ker_coker[1];
#! <A morphism in
#!  AbelianClosureWithStrictDirectSumsAsFreydOfCoFreydOfStrictAdditiveClosure(
#!  Q-LinearClosure( PathCategory( FinQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" ) ) )
#!  / [ 1*a•b•c ] )>

CKDL := ModelingCategory( A );;
KDL := UnderlyingCategory( CKDL );;
DL := UnderlyingCategory( KDL );;

list_of_evaluatable_strings := [ "A", "CKDL", "KDL", "DL", "L", "Qq", "Fq" ];

ker_reconstructed := CellAsEvaluatableString( ker, list_of_evaluatable_strings );

Assert( 0, ker = EvalString( ker_reconstructed ) );

func_ker := EvalString( ReplacedStringViaRecord( """
  function( T, a, b, c )
    local objects, generating_morphisms,
          embedding_on_objects, embedding_on_morphisms, extended_functorA;
    
    objects := [ Source( a ), Target( a ), Target( b ), Target( c ) ];
    generating_morphisms := [ a, b, c ];
    
    ## Q → T
    embedding_on_objects :=
      function( objQ )
        
        return objects[objQ];
        
    end;
    
    embedding_on_morphisms :=
      function( morQ )
        
        return generating_morphisms[morQ];
        
    end;
    
    ## A → T
    extended_functorA :=
      ExtendFunctorToAbelianClosureWithStrictDirectSumsData(
              A,
              ExtendFunctorToQuotientCategoryData(
                      L,
                      ExtendFunctorToAlgebroidData(
                              Qq,
                              ExtendFunctorToFpCategoryData(
                                      Fq,
                                      Pair( embedding_on_objects, embedding_on_morphisms ),
                                      T )[2],
                              T )[2],
                      T )[2],
              T )[2];
    
    return extended_functorA[1]( ker_reconstructed );
    
end
""",
  rec( ker_reconstructed := ker_reconstructed ) ) );

kker := func_ker( A, a, b, c );

#Assert( 0, kker = ker );

coker_reconstructed := CellAsEvaluatableString( coker, list_of_evaluatable_strings );

Assert( 0, coker = EvalString( coker_reconstructed ) );

func_coker := EvalString( ReplacedStringViaRecord( """
  function( T, a, b, c )
    local objects, generating_morphisms,
          embedding_on_objects, embedding_on_morphisms, extended_functorA;
    
    objects := [ Source( a ), Target( a ), Target( b ), Target( c ) ];
    generating_morphisms := [ a, b, c ];
    
    ## Q → T
    embedding_on_objects :=
      function( objQ )
        
        return objects[objQ];
        
    end;
    
    embedding_on_morphisms :=
      function( morQ )
        
        return generating_morphisms[morQ];
        
    end;
    
    ## A → T
    extended_functorA :=
      ExtendFunctorToAbelianClosureWithStrictDirectSumsData(
              A,
              ExtendFunctorToQuotientCategoryData(
                      L,
                      ExtendFunctorToAlgebroidData(
                              Qq,
                              ExtendFunctorToFpCategoryData(
                                      Fq,
                                      Pair( embedding_on_objects, embedding_on_morphisms ),
                                      T )[2],
                              T )[2],
                      T )[2],
              T )[2];
    
    return extended_functorA[1]( coker_reconstructed );
    
end
""",
  rec( coker_reconstructed := coker_reconstructed ) ) );

ccoker := func_coker( A, a, b, c );

#Assert( 0, ccoker = coker );

s_reconstructed := CellAsEvaluatableString( s, list_of_evaluatable_strings );

Assert( 0, s = EvalString( s_reconstructed ) );

func := EvalString( ReplacedStringViaRecord( """
  function( T, a, b, c )
    local objects, generating_morphisms,
          embedding_on_objects, embedding_on_morphisms, extended_functorA, s;
    
    objects := [ Source( a ), Target( a ), Target( b ), Target( c ) ];
    generating_morphisms := [ a, b, c ];
    
    ## Q → T
    embedding_on_objects :=
      function( objQ )
        
        return objects[objQ];
        
    end;
    
    embedding_on_morphisms :=
      function( morQ )
        
        return generating_morphisms[morQ];
        
    end;
    
    ## A → T
    extended_functorA :=
      ExtendFunctorToAbelianClosureWithStrictDirectSumsData(
              A,
              ExtendFunctorToQuotientCategoryData(
                      L,
                      ExtendFunctorToAlgebroidData(
                              Qq,
                              ExtendFunctorToFpCategoryData(
                                      Fq,
                                      Pair( embedding_on_objects, embedding_on_morphisms ),
                                      T )[2],
                              T )[2],
                      T )[2],
              T )[2];
    
    s := s_reconstructed;
    
    return extended_functorA[2](
                   extended_functorA[1]( Source( s ) ),
                   s,
                   extended_functorA[1]( Target( s ) ) );
    
end
""",
  rec( s_reconstructed := s_reconstructed, source_reconstructed := ker_reconstructed, target_reconstructed := coker_reconstructed ) ) );

ss := func( A, a, b, c );

#Assert( 0, ss = s );

T := DummyCategory( rec( name := "A placeholder abelian category",
             commutative_ring_of_linear_category := Q,
             properties := [ "IsLinearCategoryOverCommutativeRing", "IsAbelianCategory" ],
             list_of_operations_to_install :=
             Concatenation( [ "ObjectConstructor", "MorphismConstructor" ],
                     CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsLinearCategoryOverCommutativeRing,
                     Difference( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategory,
                             [ "ProjectionInFactorOfDirectSum",
                               "InjectionOfCofactorOfDirectSum",
                               "UniversalMorphismIntoDirectSum",
                               "UniversalMorphismFromDirectSum" ] ),
                     [ "MorphismBetweenDirectSums" ] ) ) );;

T!.compiler_hints :=
  rec( category_attribute_names :=
       [ "CommutativeRingOfLinearCategory",
         ] );

StartTimer( "SnakeLemma" );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( T );

ReadPackageOnce( "FiniteCocompletions",
    "examples/precompileSnakeInFreeAbelian_CompilerLogic.g" );

#! true

compiled_func := CapJitCompiledFunction( func, T, [ "category", "morphism", "morphism", "morphism" ], "morphism" );

StopTimer( "SnakeLemma" );

DisplayTimer( "SnakeLemma" );

Assert( 0, compiled_func( A, a, b, c ) = ss );

Display( compiled_func );
#! function ( T_1, a_1, b_1, c_1 )
#!     local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1,
#!     deduped_13_1;
#!     deduped_13_1 := Target( b_1 );
#!     deduped_12_1 := Target( c_1 );
#!     deduped_11_1 := Source( a_1 );
#!     deduped_10_1 := Target( a_1 );
#!     deduped_9_1 := PreCompose( T_1, b_1, c_1 );
#!     deduped_8_1 := [ deduped_13_1, deduped_11_1 ];
#!     deduped_7_1 := [ deduped_10_1, deduped_11_1 ];
#!     deduped_6_1 := IdentityMorphism( T_1, deduped_13_1 );
#!     deduped_5_1 := ZeroMorphism( T_1, deduped_11_1, deduped_12_1 );
#!     deduped_4_1 := IdentityMorphism( T_1, deduped_10_1 );
#!     deduped_3_1 := MorphismBetweenDirectSums( T_1, deduped_8_1, [ [ c_1, deduped_6_1 ], [ deduped_5_1, ZeroMorphism( T_1, deduped_11_1, deduped_13_1 ) ] ],
#!        [ deduped_12_1, deduped_13_1 ] );
#!     deduped_2_1 := MorphismBetweenDirectSums( T_1, deduped_7_1, [ [ deduped_9_1, deduped_4_1 ], [ deduped_5_1, AdditiveInverseForMorphisms( T_1, a_1 ) ] ],
#!        [ deduped_12_1, deduped_10_1 ] );
#!     deduped_1_1 := KernelLift( T_1, c_1, KernelObject( T_1, deduped_3_1 ), PreCompose( T_1, KernelEmbedding( T_1, deduped_3_1 ), MorphismBetweenDirectSums( T_1,
#!            deduped_8_1, [ [ deduped_6_1 ], [ PreCompose( T_1, a_1, b_1 ) ] ], [ deduped_13_1 ] ) ) );
#!     return CokernelColift( T_1, KernelLift( T_1, deduped_9_1, KernelObject( T_1, deduped_2_1 ), PreCompose( T_1, KernelEmbedding( T_1, deduped_2_1 ),
#!            MorphismBetweenDirectSums( T_1, deduped_7_1, [ [ deduped_4_1 ], [ ZeroMorphism( T_1, deduped_11_1, deduped_10_1 ) ] ], [ deduped_10_1 ] ) ) ),
#!        CokernelObject( T_1, deduped_1_1 ), PreCompose( T_1, KernelLift( T_1, c_1, KernelObject( T_1, deduped_9_1 ), PreCompose( T_1, KernelEmbedding( T_1, deduped_9_1 )
#!               , b_1 ) ), CokernelProjection( T_1, deduped_1_1 ) ) );
#! end

#! @EndExample
