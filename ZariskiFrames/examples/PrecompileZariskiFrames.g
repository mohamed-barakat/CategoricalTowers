#! @Chapter Precompilation

#! @Section Precompiling a Zariski frame

#! @Example

LoadPackage( "ZariskiFrames", false );
#! true

LoadPackage( "CompilerForCAP", false );
#! true

ReadPackageOnce( "ZariskiFrames", "gap/CompilerLogic.gi" );
#! true

ZariskiFrameOfAffineSpectrumAsStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows_KeepTower :=
  function( R )
    local F, S, P, T, ZF;
    
    F := CategoryOfRows( R : FinalizeCategory := true );
    
    S := SliceCategoryOverTensorUnit( F : FinalizeCategory := true );
    
    P := PosetOfCategory( S : FinalizeCategory := true );
    
    ## the last instance before the wrapper category has to be finalized for the compiler to work properly
    T := StablePosetOfCategory( P : FinalizeCategory := true );
    
    ZF := ReinterpretationOfCategory( T,
                  rec( name := Concatenation( "The frame of Zariski open subsets of the affine spectrum of ", RingName( R ) ),
                       category_filter := IsZariskiFrameOfAnAffineVariety,
                       category_object_filter := IsWrapperCapCategoryObject and IsObjectInZariskiFrameOfAnAffineVariety, # and IsObjectInThinCategory,
                       category_morphism_filter := IsWrapperCapCategoryMorphism and IsMorphismInZariskiFrameOfAnAffineVariety ) ); # and IsMorphismInThinCategory );
    
    SetUnderlyingRing( ZF, R );
    
    return ZF;
    
end;

ring := HomalgFieldOfRationalsInSingular( )["x,y"];;

precompile_ZariskiFrame :=
  function( name, ring )
    
    CapJitPrecompileCategoryAndCompareResult(
            ValueGlobal( name ),
            [ ring ],
            "ZariskiFrames",
            Concatenation( name, "Precompiled" )
            : operations := "primitive" );
    
end;

precompile_ZariskiFrame( "ZariskiFrameOfAffineSpectrumAsStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows", ring );
#! 

cat := ValueGlobal( Concatenation( "ZariskiFrameOfAffineSpectrumAsStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows", "Precompiled" ) )( ring );
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
