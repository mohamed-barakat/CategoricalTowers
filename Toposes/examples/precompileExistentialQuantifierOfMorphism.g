LoadPackage( "FinSetsForCAP" );

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );

sFinSets := CategoryOfSkeletalFinSetsWithMorphismsGivenByFunctions( : no_precompiled_code := true );

func :=
  function( cat, f )
    local A, PA, top, dir, upp, top_upp, PPf, int;
    
    A := Source( f );
    PA := PowerObject( cat, A );
    
    top := CartesianLambdaIntroduction( cat,
                   ClassifyingMorphismOfSubobject( cat,
                           IdentityMorphism( cat, Source( f ) ) ) );
    
    dir := MorphismConstructor( cat,
                   TerminalObject( cat ),
                   i -> GeometricSum( BigInt( 2 ), Length( A ) ),
                   PA );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Assert( 0, IsCongruentForMorphisms( cat, top, dir ) );
    
    upp := UpperSegmentOfRelation( cat,
                   PA,
                   PA,
                   CanonicalOrderRelationOnPowerObject( cat, A ) );
    
    top_upp := MorphismConstructor( cat,
                       TerminalObject( cat ),
                       i -> BigInt( 2 ) ^ ( GeometricSum( BigInt( 2 ), Length( A ) ) ),
                       PowerObject( cat, PA ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Assert( 0, IsCongruentForMorphisms( cat, PreCompose( top, upp ), top_upp ) );
    
    PPf := PowerObjectFunctorial( cat,
                   PowerObjectFunctorial( cat,
                           f ) );
    
    int := SubobjectIntersectionMorphism( cat, Range( f ) );
    
    return
      PreComposeList( cat,
              [ #top,
                #upp,
                top_upp,
                PPf,
                #int
                ] );
    
end;

A := 3 / sFinSets;
B := 3 / sFinSets;

f := MapOfFinSets( A, [ 0, 1, 1 ], B );

#Display( func( sFinSets, f ) );

StartTimer( "ExistentialQuantifierOfMorphism" );

image := CapJitCompiledFunction( func, sFinSets, [ "category", "morphism" ], "morphism" );

StopTimer( "ExistentialQuantifierOfMorphism" );

DisplayTimer( "ExistentialQuantifierOfMorphism" );

Display( image );

#Assert( 0, IsCongruentForMorphisms( sFinSets, func( sFinSets, f ), image( sFinSets, f ) ) );
