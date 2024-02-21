# SPDX-License-Identifier: GPL-2.0-or-later
# FpCategories: Finitely presented categories by generating quivers and relations
#
# Declarations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecord.gi

#! @Chapter Futher CAP operations

#! @Section Add-methods

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `SetOfGeneratingMorphismsOfCategory`.
#! $F: (  ) \mapsto \mathtt{SetOfGeneratingMorphismsOfCategory}()$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSetOfGeneratingMorphismsOfCategory",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSetOfGeneratingMorphismsOfCategory",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSetOfGeneratingMorphismsOfCategory",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSetOfGeneratingMorphismsOfCategory",
                  [ IsCapCategory, IsList ] );