# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallTrueMethod( IsFiniteBicompleteCategory, IsElementaryTopos );
InstallTrueMethod( IsBicartesianClosedCategory, IsElementaryTopos );

## MacLane-Moerdijk, Proof of Thm IV.7.1, page 192, diagram (5)
InstallOtherMethodForCompilerForCAP( IntersectWithPreimagesWithGivenObjects,
        "for a category, two objects, and a morphism",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ],
        
 function( C, PAxB, f, PA )
    local A, B, PB, f_, PA_PA, PAxPA, PA_B, n, pi_1, e;
    
    A := Source( f );
    B := Target( f );
    
    PB := PowerObject( C, B );
    
    ## the preimage of singletons:
    ## {⋅}_B Pf: B → PA, b ↦ f⁻¹(b) ∈ PA
    f_ := PreCompose( C,
                  ## {⋅}_B: B ↪ PB
                  SingletonMorphism( C, B ),
                  ## Pf: PB → PA
                  PowerObjectFunctorialWithGivenPowerObjects( C, PB, f, PA ) );
    
    PA_PA := [ PA, PA ];
    PAxPA := DirectProduct( C, PA_PA );
    
    PA_B := [ PA, B ];
    
    ## n: PA × B → PA, (T, b) ↦ T ∩ f⁻¹(b)
    return PreCompose( C,
                   ## 1_PA × ({⋅}_B Pf): PA × B → PA × PA, (T, b) ↦ (T, f⁻¹(b))
                   DirectProductFunctorialWithGivenDirectProducts( C,
                           ## PA × B
                           PAxB,
                            ## [ PA, B ]
                           PA_B,
                           [ ## 1_PA
                             IdentityMorphism( C, PA ),
                             ## {⋅}_B Pf: B → PA
                             f_ ],
                           ## [ PA, PA ]
                           PA_PA,
                           ## PA × PA
                           PAxPA ),
                   ## ∧: PA × PA → PA, (T, T') ↦ T ∩ T'
                   RelativeTruthMorphismOfAndWithGivenObjects( C,
                           PAxPA,
                           A,
                           PA ) );
    
end );

##
InstallMethod( IntersectWithPreimagesWithGivenObjects,
        "for two objects and a morphism",
        [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ],
        
 function( PAxB, f, PA )
    
    return IntersectWithPreimagesWithGivenObjects( CapCategory( f ), PAxB, f, PA );
    
end );

## MacLane-Moerdijk, Proof of Thm IV.7.1, page 192, diagram (5)
InstallOtherMethodForCompilerForCAP( EmbeddingOfRelativePowerObject,
        "for a category and a morphism",
        [ IsCapCategory, IsCapCategoryMorphism ],
        
 function( C, f )
    local A, B, PA, PA_B, PAxB, n, pi_1, e;
    
    A := Source( f );
    B := Target( f );
    
    PA := PowerObject( C, A );
    
    PA_B := [ PA, B ];
    PAxB := DirectProduct( C, PA_B );
    
    ## n: PA × B → PA, (T, b) ↦ T ∩ f⁻¹(b)
    n := IntersectWithPreimagesWithGivenObjects( C,
                 PAxB,
                 f,
                 PA );
    
    ## π₁: PA × B → PA, (T, b) ↦ T
    pi_1 := ProjectionInFactorOfDirectProductWithGivenDirectProduct( C,
                    PA_B,
                    1,
                    PAxB );
    
    ## the powers objects of fibers of f: A → B:
    ## e: P_fA = { (T, b) |  T ⊆ f⁻¹(b) } ↪ PA × B, (T, b) ↦ (T, b)
    e := EmbeddingOfEqualizer( C,
                 PAxB,
                 [ n, pi_1 ] );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    SetIsMonomorphism( e, true );
    
    return e;
    
end );

##
InstallMethod( EmbeddingOfRelativePowerObject,
        "for a morphism",
        [ IsCapCategoryMorphism ],
        
 function( f )
    
    return EmbeddingOfRelativePowerObject( CapCategory( f ), f );
    
end );

##
InstallOtherMethodForCompilerForCAP( RelativePowerObjectFibrationMorphism,
        "for a category and a morphism",
        [ IsCapCategory, IsCapCategoryMorphism ],
        
 function( C, f )
    local A, B, e, pi_2;
    
    A := Source( f );
    B := Target( f );
    
    ## e: P_fA ↪ PA × B
    e := EmbeddingOfRelativePowerObject( C, f );
    
    ## π₂: PA × B → B
    pi_2 := ProjectionInFactorOfDirectProductWithGivenDirectProduct( C,
                    [ PowerObject( C, A ), B ],
                    2,
                    Target( e ) );
    
    ## P_f: P_fA → B
    return PreCompose( C,
                   e,
                   pi_2 );
    
end );

##
InstallMethod( RelativePowerObjectFibrationMorphism,
        "for a morphism",
        [ IsCapCategoryMorphism ],
        
 function( f )
    
    return RelativePowerObjectFibrationMorphism( CapCategory( f ), f );
    
end );

##
InstallOtherMethodForCompilerForCAP( RelativePowerObjectLeftEvaluationMorphism,
        "for a category and a morphism",
        [ IsCapCategory, IsCapCategoryMorphism ],
        
 function( C, f ) # f: A → B
    local A, PA, PAxA, B, BxA, AxB, beta, PAxB, P_f, emb, P_fA, P_fA_A, PAxB_A, PAxB_xA, e, eA, PA_BxA, PAx_BxA, alpha,
          PA_AxB, PAx_AxB, PAx_beta, PAxA_B, PAxA_xB, gamma, Omega, epsilon, Omega_B, Omega_xB, epsilon_xB;
    
    A := Source( f );
    
    PA := PowerObject( C, A );
    
    PAxA := DirectProduct( C, [ PA, A ] );
    
    B := Target( f );
    
    BxA := DirectProduct( C, [ B, A ] );
    
    AxB := DirectProduct( C, [ A, B ] );
    
    ## β: B × A → A × B
    beta := CartesianBraidingWithGivenDirectProducts( C,
                    BxA,
                    B,
                    A,
                    AxB );
    
    ## PA × B
    PAxB := DirectProduct( C, [ PA, B ] );
    
    ## P_f: P_fA → B
    P_f := RelativePowerObjectFibrationMorphism( C, f );
    
    ## P_fA (P_f_x_f) A ↪ P_fA × A
    emb := FiberProductEmbeddingInDirectProduct( C,
                   [ P_f, f ] );
    
    P_fA := Source( P_f );
    
    P_fA_A := [ P_fA, A ];
    PAxB_A := [ PAxB, A ];
    
    PAxB_xA := DirectProduct( C, PAxB_A );
    
    ## P_fA ↪ PA × B
    e := EmbeddingOfRelativePowerObject( C, f );
    
    ## e × 1_A: P_fA × A → (PA × B) × A
    eA := DirectProductFunctorialWithGivenDirectProducts( C,
                  DirectProduct( C, P_fA_A ),
                  P_fA_A,
                  [ e, IdentityMorphism( C, A ) ],
                  PAxB_A,
                  PAxB_xA );
    
    PA_BxA := [ PA, BxA ];
    
    PAx_BxA := DirectProduct( C, PA_BxA );
    
    ## α: (PA × B) × A → PA × (B × A)
    alpha := CartesianAssociatorLeftToRightWithGivenDirectProducts( C,
                     PAxB_xA,
                     PA,
                     B,
                     A,
                     PAx_BxA );
    
    PA_AxB := [ PA, AxB ];
    
    PAx_AxB := DirectProduct( C, PA_AxB );
    
    ## 1_PA × β: PA × (B × A) → PA × (A × B)
    PAx_beta := DirectProductFunctorialWithGivenDirectProducts( C,
                        PAx_BxA,
                        PA_BxA,
                        [ IdentityMorphism( C, PA ), beta ],
                        PA_AxB,
                        PAx_AxB );
    
    PAxA_B := [ PAxA, B ];
    
    PAxA_xB := DirectProduct( C, PAxA_B );
    
    ## γ: PA × (A × B) → (PA × A) × B
    gamma := CartesianAssociatorRightToLeftWithGivenDirectProducts( C,
                       PAx_AxB,
                       PA,
                       B,
                       A,
                       PAxA_xB );
    
    ## Ω
    Omega := SubobjectClassifier( C );
    
    ## ϵ_A : PA × A → Ω
    epsilon := PowerObjectLeftEvaluationMorphismWithGivenObjects( C,
                       PAxA,
                       A,
                       Omega );
    
    Omega_B := [ Omega, B ];
    
    Omega_xB := DirectProduct( C, Omega_B );
    
    ## ϵ_A × 1_B: (PA × A) × B → Ω × B
    epsilon_xB := DirectProductFunctorialWithGivenDirectProducts( C,
                          PAxA_xB,
                          PAxA_B,
                          [ epsilon, IdentityMorphism( C, B ) ],
                          Omega_B,
                          Omega_xB );
    
    ## P_fA × A → Ω × B
    return PreComposeList( C,
                   Source( emb ),
                   [ emb,
                     eA,
                     alpha,
                     PAx_beta,
                     gamma,
                     epsilon_xB ],
                   Omega_xB );
    
end );

##
InstallMethod( RelativePowerObjectLeftEvaluationMorphism,
        "for a morphism",
        [ IsCapCategoryMorphism ],
        
 function( f )
    
    return RelativePowerObjectLeftEvaluationMorphism( CapCategory( f ), f );
    
end );

##
InstallOtherMethodForCompilerForCAP( CanonicalOrderRelationOnPowerObject,
        [ IsCapCategory, IsCapCategoryObject ],
        
  function( C, a )
    local Pa, diagram, PaxPa, emb;
    
    Pa := PowerObject( C, a );
    
    diagram := [ Pa, Pa ];
    
    PaxPa := DirectProduct( C, diagram );
    
    emb := EmbeddingOfEqualizer( C,
                   PaxPa,
                   [ ProjectionInFactorOfDirectProductWithGivenDirectProduct( C,
                           diagram,
                           1,
                           PaxPa ),
                     RelativeTruthMorphismOfAndWithGivenObjects( C,
                             PaxPa,
                             a,
                             Pa ) ] );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    SetIsMonomorphism( emb, true );
    
    return emb;
    
end );

##
InstallMethod( CanonicalOrderRelationOnPowerObject,
        [ IsCapCategoryObject ],
        
  function( a )
    
    return CanonicalOrderRelationOnPowerObject( CapCategory( a ), a );
    
end );

##
InstallOtherMethodForCompilerForCAP( UniversalQuantifierOfMorphism,
        [ IsCapCategory, IsCapCategoryMorphism ],
        
  function( C, f )
    local a, b, Pa, canonical_order_Pa, lower_segment_Pa, PPf, P_sing_b;
    
    a := Source( f );
    b := Range( f );
    
    ## P(a)
    Pa := PowerObject( C, a );
    
    ## R ↪ P(a) × P(a)
    canonical_order_Pa := CanonicalOrderRelationOnPowerObject( C, a );
    
    ## ↓seg_Pa: P(a) → P(P(a))
    lower_segment_Pa := LowerSegmentOfRelation( C, Pa, Pa, canonical_order_Pa );
    
    ## P(P(f)): P(P(a)) → P(P(b))
    PPf := PowerObjectFunctorial( C, PowerObjectFunctorial( C, f ) );
    
    ## P({}_b): P(P(b)) → P(b)
    P_sing_b := PowerObjectFunctorial( C, SingletonMorphism( C, b ) );
    
    ## ∀_f: P(a) → P(b)
    return PreComposeList( C,
                   [ lower_segment_Pa,
                     PPf,
                     P_sing_b ] );
    
end );

##
InstallMethod( UniversalQuantifierOfMorphism,
        [ IsCapCategoryMorphism ],
        
  function( f )
    
    return UniversalQuantifierOfMorphism( CapCategory( f ), f );
    
end );

##
InstallOtherMethodForCompilerForCAP( SubobjectIntersectionMorphism,
        [ IsCapCategory, IsCapCategoryObject ],
        
  function( C, a )
    local Pa, PPa, canonical_order_PPa, upper_segment_PPa,
          canonical_order_Pa, upper_segment_Pa, P_upper_segment_Pa, P_sing_a;
    
    ## P(a)
    Pa := PowerObject( C, a );
    
    ## P(P(a))
    PPa := PowerObject( C, Pa );
    
    ## R' ↪ P(P(a)) × P(P(a))
    canonical_order_PPa := CanonicalOrderRelationOnPowerObject( C, Pa );
    
    ## ↑seg_PPa: P(P(a)) → P(P(P(a)))
    upper_segment_PPa := UpperSegmentOfRelation( C, PPa, PPa, canonical_order_PPa );
    
    ## R ↪ P(a) × P(a)
    canonical_order_Pa := CanonicalOrderRelationOnPowerObject( C, a );
    
    ## ↑seg_Pa: P(a) → P(P(a))
    upper_segment_Pa := UpperSegmentOfRelation( C, Pa, Pa, canonical_order_Pa );
    
    ## P(↑seg_Pa): P(P(P(a))) → P(P(a))
    P_upper_segment_Pa := PowerObjectFunctorial( C, upper_segment_Pa );
    
    ## P({}ₐ)
    P_sing_a := PowerObjectFunctorial( C, SingletonMorphism( C, a ) );
    
    ## ⋂_a
    return PreComposeList( C,
                   [ upper_segment_PPa,
                     P_upper_segment_Pa,
                     P_sing_a ] );
    
end );

##
InstallMethod( SubobjectIntersectionMorphism,
        [ IsCapCategoryObject ],
        
  function( a )
    
    return SubobjectIntersectionMorphism( CapCategory( a ), a );
    
end );

##
InstallOtherMethodForCompilerForCAP( ExistentialQuantifierOfMorphism,
        [ IsCapCategory, IsCapCategoryMorphism ],
        
  function( C, f )
    local a, b, Pa, canonical_order_Pa, upper_segment_Pa, PPf, cap_b;
    
    a := Source( f );
    b := Range( f );
    
    ## P(a)
    Pa := PowerObject( C, a );

    ## R ↪ P(a) × P(a)
    canonical_order_Pa := CanonicalOrderRelationOnPowerObject( C, a );
    
    ## ↑seg_Pa: P(a) → P(P(a))
    upper_segment_Pa := UpperSegmentOfRelation( C, Pa, Pa, canonical_order_Pa );
    
    ## P(P(f)): P(P(a)) → P(P(b))
    PPf := PowerObjectFunctorial( C, PowerObjectFunctorial( C, f ) );

    ## ⋂_b: P(P(b)) → P(b)
    cap_b := SubobjectIntersectionMorphism( C, b );
    
    ## ∃_f: P(a) → P(b)
    return PreComposeList( C,
                   [ upper_segment_Pa,
                     PPf,
                     cap_b ] );
    
end );

##
InstallMethod( ExistentialQuantifierOfMorphism,
        [ IsCapCategoryMorphism ],
        
  function( f )
    
    return ExistentialQuantifierOfMorphism( CapCategory( f ), f );
    
end );
