# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "object" ],
        src_template := "object <> object",
        dst_template := "false",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "morphism" ],
        src_template := "Source( Opposite( morphism ) )",
        dst_template := "Opposite( Range( morphism ) )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "morphism" ],
        src_template := "Range( Opposite( morphism ) )",
        dst_template := "Opposite( Source( morphism ) )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        src_template := "number * 1",
        dst_template := "number",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        src_template := "0 + number",
        dst_template := "number",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "1 - 1",
        dst_template := "0",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "integer" ],
        src_template := "REM_INT( 0, integer )",
        dst_template := "0",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "integer" ],
        src_template := "QUO_INT( 0, integer )",
        dst_template := "0",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring" ],
        src_template := "HomalgMatrix( PermutationMat( PermList( [ 1 ] ), 1 ), 1, 1, ring )",
        dst_template := "HomalgIdentityMatrix( 1, ring )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "matrix" ],
        src_template := "KroneckerMat( HomalgIdentityMatrix( 1, ring ), matrix )",
        dst_template := "matrix",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "matrix" ],
        src_template := "KroneckerMat( matrix, HomalgIdentityMatrix( 1, ring ) )",
        dst_template := "matrix",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "dimension", "ring" ],
        src_template := "NrColumns( HomalgIdentityMatrix( dimension, ring ) )",
        dst_template := "dimension",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "dimension", "ring" ],
        src_template := "TransposedMatrix( HomalgIdentityMatrix( dimension, ring ) )",
        dst_template := "HomalgIdentityMatrix( dimension, ring )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "dimension", "ring" ],
        src_template := "RightDivide( matrix, HomalgIdentityMatrix( dimension, ring ) )",
        dst_template := "matrix",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "dimension", "ring", "matrix" ],
        variable_filters := [ IsInt, IsHomalgRing, IsHomalgMatrix ],
        src_template := "HomalgIdentityMatrix( dimension, ring ) * matrix",
        dst_template := "matrix",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "dimension", "ring", "matrix" ],
        variable_filters := [ IsInt, IsHomalgRing, IsHomalgMatrix ],
        src_template := "matrix * HomalgIdentityMatrix( dimension, ring )",
        dst_template := "matrix",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring" ],
        src_template := "ConvertMatrixToColumn( HomalgIdentityMatrix( 1, ring ) )",
        dst_template := "HomalgIdentityMatrix( 1, ring )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring" ],
        src_template := "ConvertMatrixToRow( HomalgIdentityMatrix( 1, ring ) )",
        dst_template := "HomalgIdentityMatrix( 1, ring )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "dimension", "ring" ],
        variable_filters := [ IsInt, IsHomalgRing ],
        src_template := "UniqueRightDivide( HomalgIdentityMatrix( dimension, ring ), HomalgIdentityMatrix( dimension, ring ) )",
        dst_template := "HomalgIdentityMatrix( dimension, ring )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "dimension", "ring" ],
        variable_filters := [ IsInt, IsHomalgRing ],
        src_template := "UniqueLeftDivide( HomalgIdentityMatrix( dimension, ring ), HomalgIdentityMatrix( dimension, ring ) )",
        dst_template := "HomalgIdentityMatrix( dimension, ring )",
    )
);
