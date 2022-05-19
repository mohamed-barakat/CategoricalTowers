#! @Chapter Precompilation

#! @Section Precompiling the poset of single differences of Zariski (co)frames

#! @Example

LoadPackage( "ZariskiFrames", false );
#! true

LoadPackage( "CompilerForCAP", false );
#! true

ReadPackageOnce( "Locales", "gap/CompilerLogic.gi" );
#! true

ReadPackageOnce( "ZariskiFrames", "gap/CompilerLogic.gi" );
#! true

MeetSemilatticeOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows :=
  function( R )
    local ZC;
    
    ZC := ZariskiCoframeOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows( R : FinalizeCategory := true );
    
    return MeetSemilatticeOfSingleDifferences( ZC );
    
end;

ring := HomalgFieldOfRationalsInSingular( )["x,y"];;

precompile_MeetSemilatticeOfDifferencesOfLocallyClosedSubsets :=
  function( name, ring )
    
    CapJitPrecompileCategoryAndCompareResult(
            ValueGlobal( name ),
            [ ring ],
            "ZariskiFrames",
            Concatenation( name, "Precompiled" )
            : operations := "primitive" );
    
end;

precompile_MeetSemilatticeOfDifferencesOfLocallyClosedSubsets( "MeetSemilatticeOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows", ring );
#! 

cat := ValueGlobal( Concatenation( "MeetSemilatticeOfDifferencesOfLocallyClosedSubsetsOfAffineSpectrumAsOppositeOfStablePosetOfSliceCategoryOverTensorUnitOfCategoryOfRows", "Precompiled" ) )( ring );
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
