# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Declarations
#

#! @Chapter Finitely presented categories generated by enhanced quivers

####################################
#
#! @Section Global functions
#
####################################

#! @Description
#!  The full subcategory of the simplicial category $\Delta$ on the objects $[0], \ldots, [n]$.
#! @Arguments n
#! @Returns a &CAP; category
DeclareGlobalFunction( "SimplicialCategoryTruncatedInDegree" );