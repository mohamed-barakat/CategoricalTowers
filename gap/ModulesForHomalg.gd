#
# M2: Intrinsic modules with elements for the CAP based &homalg;
#
# Declarations
#

#! @Chapter Categories of finitely presented modules

#! @Section Constructors

#! @Description
#!  Construct the category of finitely presented left &homalg; modules
#!  over the computable &homalg; ring <A>R</A>.
#! @Arguments R
#! @Returns an intrinsic cateogry of left modules
DeclareAttribute( "CategoryOfHomalgLeftModules",
        IsHomalgRing );

#! @Description
#!  Construct the category of finitely presented right &homalg; modules
#!  over the computable &homalg; ring <A>R</A>.
#! @Arguments R
#! @Returns an intrinsic cateogry of right modules
DeclareAttribute( "CategoryOfHomalgRightModules",
        IsHomalgRing );
