#! @Chunk SyntacticCategoryInDoctrines

#! @Example
LoadPackage( "ToolsForCategoricalTowers", false );
#! true
D1 := SyntacticCategoryInDoctrines( "IsAbCategory" );
#! SyntacticCategoryInDoctrines( [ "IsAbCategory" ] )
Display( D1 );
#! A CAP category with name SyntacticCategoryInDoctrines( [ "IsAbCategory" ] ):
#! 
#! 16 primitive operations were used to derive 28 operations for this category
#! which algorithmically
#! * IsAbCategory
D2 := SyntacticCategoryInDoctrines( [ "IsAbCategory", "IsAbelianCategory" ] );
#! SyntacticCategoryInDoctrines( [ "IsAbelianCategory" ] )
Display( D2 );
#! A CAP category with name SyntacticCategoryInDoctrines( [ "IsAbelianCategory" ] ):
#! 
#! 32 primitive operations were used to derive 291 operations for this category
#! which algorithmically
#! * IsAbelianCategory
D3 := SyntacticCategoryInDoctrines(
              [ "IsCategoryWithInitialObject",
                "IsCategoryWithTerminalObject",
                "IsCategoryWithZeroObject" ] );
#! SyntacticCategoryInDoctrines(
#! [ "IsCategoryWithInitialObject", "IsCategoryWithTerminalObject",
#!   "IsCategoryWithZeroObject" ] )
Display( D3 );
#! A CAP category with name SyntacticCategoryInDoctrines(
#! [ "IsCategoryWithInitialObject", "IsCategoryWithTerminalObject",
#!   "IsCategoryWithZeroObject" ] ):
#! 
#! 18 primitive operations were used to derive 41 operations for this category
#! which algorithmically
#! * IsCategoryWithZeroObject
D4 := SyntacticCategoryInDoctrines(
              [ "IsCategoryWithInitialObject",
                "IsCategoryWithTerminalObject",
                "IsCategoryWithZeroObject" ] : minimal := true );
#! SyntacticCategoryInDoctrines( [ "IsCategoryWithZeroObject" ] )
Display( D4 );
#! A CAP category with name SyntacticCategoryInDoctrines(
#! [ "IsCategoryWithZeroObject" ] ):
#! 
#! 14 primitive operations were used to derive 41 operations for this category
#! which algorithmically
#! * IsCategoryWithZeroObject
#! @EndExample
