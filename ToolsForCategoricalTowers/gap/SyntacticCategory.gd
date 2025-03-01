# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForCategoricalTowers: Tools for CategoricalTowers
#
# Declarations
#
#! @Chapter Syntactic category

########################################
#
#! @Section &GAP; Categories
#
########################################

#! @Description
#!  The &GAP; type of a syntactic category of a doctrine.
#! @Arguments T
DeclareCategory( "IsSyntacticCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; type of a cell in a syntactic category of a doctrine.
#! @Arguments T
DeclareCategory( "IsCellInSyntacticCategory",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; type of an object in a syntactic category of a doctrine.
#! @Arguments T
DeclareCategory( "IsObjectInSyntacticCategory",
        IsCellInSyntacticCategory and IsCapCategoryObject );

#! @Description
#!  The &GAP; type of a morphism in a syntactic category of a doctrine.
#! @Arguments T
DeclareCategory( "IsMorphismInSyntacticCategory",
        IsCellInSyntacticCategory and IsCapCategoryMorphism );

####################################
#
#! @Section Attributes
#
####################################

#!
DeclareAttribute( "PairOfOperationNameAndArguments",
        IsObjectInSyntacticCategory );

#!
DeclareAttribute( "PairOfOperationNameAndArguments",
        IsMorphismInSyntacticCategory );

#!
DeclareAttribute( "ListOfEvaluationNodes",
        IsCellInSyntacticCategory );

#!
DeclareAttribute( "DigraphOfEvaluation",
        IsCellInSyntacticCategory );

#!
DeclareAttribute( "UnderlyingQuiver",
        IsSyntacticCategory );

#!
DeclareAttribute( "UnderlyingCategory",
        IsSyntacticCategory );

DeclareAttribute( "EmbeddingOfUnderlyingQuiverData",
        IsSyntacticCategory );

#! @Description
#!  The full embedding functor from the quiver $q$ = <C>UnderlyingQuiver</C>( <A>S</A> )
#!  underlying the syntactic category <A>S</A>.
#!  The package <C>FpCategories</C> must be loaded.
#! @Arguments S
#! @Returns a &CAP; functor
DeclareAttribute( "EmbeddingOfUnderlyingQuiver",
        IsSyntacticCategory );

DeclareAttribute( "EmbeddingOfUnderlyingCategoryData",
        IsSyntacticCategory );

#! @Description
#!  The full embedding functor from the path category $P$ = <C>UnderlyingCategory</C>( <A>S</A> )
#!  underlying the syntactic category <A>S</A>.
#!  The package <C>FpCategories</C> must be loaded.
#! @Arguments S
#! @Returns a &CAP; functor
DeclareAttribute( "EmbeddingOfUnderlyingCategory",
        IsSyntacticCategory );

########################################
#
#! @Section Constructors
#
########################################

#! @Description
#!  Creates a syntactic category subject to the options given via <A>options</A>, which is a record passed on to <Ref Oper="CategoryConstructor" Label="for IsRecord" />.
#!  Note that the options
#!  * `{category,object,morphism}_filter` will be set to `IsSyntacticCategory{,Object,Morphism}` and the options `{object,morphism}_{constructor,datum}` and
#!  * `create_func_bool` will be set to a dummy implementation (throwing an error when actually called).
#!  * `create_func_{object,morphism}` will be set to a syntactic implementation that returns an object with its object datum being a pair. Its first entry is the name of the operation used to construct the object/morphism and its second entry the list of arguments.
#!  The syntactic category will pretend to support empty (co)limits if it can "compute" (co)limits.
#! @Arguments options
#! @Returns a category
DeclareOperation( "SyntacticCategory",
        [ IsRecord ] );

########################################
#
#! @Section Operations
#
########################################

#!
DeclareOperation( "IsEqualForSyntacticCells",
        [ IsObject, IsObject ] );

#!
DeclareOperation( "Visualize",
        [ IsCellInSyntacticCategory ] );

####################################
#
#! @Section Tools
#
####################################

DeclareGlobalFunction( "AreEqualForSyntacticCells" );

DeclareOperation( "PositionsOfParentsOfASyntacticCell",
        [ IsList, IsCellInSyntacticCategory ] );

DeclareOperation( "PositionsOfParentsOfASyntacticCell",
        [ IsList, IsList ] );

DeclareOperation( "LambdaAbstractionByLines",
        [ IsCellInSyntacticCategory, IsList ] );

DeclareOperation( "LambdaAbstractionAsString",
        [ IsCellInSyntacticCategory, IsList ] );

DeclareOperation( "LambdaAbstraction",
        [ IsCellInSyntacticCategory, IsList ] );
