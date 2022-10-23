# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Logoses
##
####################################

####################################
##
#! @Section Subobject Classifier
##
####################################

DeclareGlobalVariable( "TOPOS_METHOD_NAME_RECORD" );

#! @Section Subobject Classifier

AddCategoricalProperty( [ "IsElementaryLogos", "IsElementaryTopos" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsElementaryLogos :=
  SortedList(
          Concatenation( [
                  "SubobjectClassifier",
                  "ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  #"TruthMorphismOfTrueWithGivenObjects", ## derived from SubobjectClassifier & ClassifyingMorphismOfSubobjectWithGiven... & IdentityMorphism
                  "SubobjectOfClassifyingMorphism", ## can be derived from SubobjectClassifier & TruthMorphismOfTrueWithGivenObjects & ProjectionInFactorOfFiberProduct
                  ],
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCoclosedCategory,
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFiniteCompleteCategory,
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFiniteCocompleteCategory,
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsDistributiveCategory ) );

#! @Description
#! The argument is a category $C$.
#! The output is a quotient-object coclassifier object $Q$ of the category $C$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "QuotientObjectCoclassifier",
                  IsCapCategory );

#! @Description
#! The argument is a monomorphism $m : A \rightarrow S$.
#! The output is its classifying morphism
#! $\chi_m : S \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Range}(m), \mathrm{SubobjectClassifier} )$
#! @Arguments m
DeclareOperation( "ClassifyingMorphismOfSubobject",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a monomorphism $m : A \rightarrow S$ and
#! a subobject classifier $\Omega$. The output is the classifying morphism
#! of the monomorphism $\chi_m : S \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Range}(m), \mathrm{SubobjectClassifier} )$
#! @Arguments m, omega
DeclareOperation( "ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is a classifying morphism $\chi : S \rightarrow \Omega$.
#! The output is the subobject monomorphism of the classifying morphism,
#! $m : A \rightarrow S$.
#! @Returns a monomorphism in $\mathrm{Hom}( A, S )$
#! @Arguments chi
DeclareOperation( "SubobjectOfClassifyingMorphism",
                  [ IsCapCategoryMorphism ] );

