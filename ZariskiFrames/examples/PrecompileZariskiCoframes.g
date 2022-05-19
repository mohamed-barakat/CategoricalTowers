#! @Chapter Precompilation

#! @Section Precompiling a Zariski coframe

#! @Example

LoadPackage( "ZariskiFrames", false );
#! true

LoadPackage( "CompilerForCAP", false );
#! true

ReadPackageOnce( "ZariskiFrames", "gap/CompilerLogic.gi" );
#! true

ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows_KeepTower :=
  function( R )
    local F, S, P, T, O, ZC;
    
    F := CategoryOfRows( R : FinalizeCategory := true );
    
    S := SliceCategoryOverTensorUnit( F : FinalizeCategory := true );
    
    P := PosetOfCategory( S : FinalizeCategory := true );
    
    T := StablePosetOfCategory( P : FinalizeCategory := true );
    
    ## the last instance before the wrapper category has to be finalized for the compiler to work properly
    O := OppositeCategory( T : only_primitive_operations := true, FinalizeCategory := true );
    
    ZC := ReinterpretationOfCategory( O,
                 rec( name := Concatenation( "The coframe of Zariski closed subsets of the affine spectrum of ", RingName( R ) ),
                      category_filter := IsZariskiCoframeOfAnAffineVariety,
                      category_object_filter := IsWrapperCapCategoryObject and IsObjectInZariskiCoframeOfAnAffineVariety, # and IsObjectInThinCategory,
                      category_morphism_filter := IsWrapperCapCategoryMorphism and IsMorphismInZariskiCoframeOfAnAffineVariety ) ); # and IsMorphismInThinCategory );
    
    SetUnderlyingRing( ZC, R );
    
    return ZC;
    
end;

ring := HomalgFieldOfRationalsInSingular( )["x,y"];;

precompile_ZariskiCoframe :=
  function( name, ring )
    
    CapJitPrecompileCategoryAndCompareResult(
            ValueGlobal( name ),
            [ ring ],
            "ZariskiFrames",
            Concatenation( name, "Precompiled" )
            : operations := "primitive" );
    
end;

precompile_ZariskiCoframe( "ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows", ring );
#! 

cat := ValueGlobal( Concatenation( "ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows", "Precompiled" ) )( ring );
#! 

# Now we check whether the compiled code is loaded automatically.
# For this we use the name of the argument of `InitialObject`;
# for non-compiled code it is "cat", while for compiled code it is "cat_1":
argument_name := NamesLocalVariablesFunction(
    Last( cat!.added_functions.InitialObject )[1] )[1];;

(ValueOption( "no_precompiled_code" ) = true and argument_name = "cat") or
    (ValueOption( "no_precompiled_code" ) = fail and argument_name = "cat_1");
#! true

#! @EndExample
