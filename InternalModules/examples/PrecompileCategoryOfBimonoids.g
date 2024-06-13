#! @Chapter Precompilation

#! @Section Precompiling the category of bimonoids

#! @Example

#! #@if ValueOption( "no_precompiled_code" ) <> true

LoadPackage( "InternalModules", false );
#! true

LoadPackage( "CompilerForCAP", false );
#! true

ReadPackageOnce( "InternalModules", "gap/CompilerLogic.gi" );
#! true

dummy := DummyCategoryInDoctrines( "IsSymmetricMonoidalCategory" );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

category_constructor := symmoncat -> CategoryOfBimonoids( symmoncat );;
given_arguments := [ dummy ];;
compiled_category_name := "CategoryOfBimonoidsPrecompiled";;
package_name := "InternalModules";;

CapJitPrecompileCategoryAndCompareResult(
        category_constructor,
        given_arguments,
        package_name,
        compiled_category_name
        : operations :=
          [ "TensorUnit",
            "TensorProductOnObjects",
            ],
          number_of_objectified_objects_in_data_structure_of_object := 3,
          number_of_objectified_morphisms_in_data_structure_of_object := 4,
          number_of_objectified_objects_in_data_structure_of_morphism := 2,
          number_of_objectified_morphisms_in_data_structure_of_morphism := 1
);;

CategoryOfBimonoids( dummy )!.precompiled_functions_added;
#! true

#! #@fi

#! @EndExample
