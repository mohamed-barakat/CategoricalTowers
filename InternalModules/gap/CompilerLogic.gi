# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "obj" ],
        src_template := "IS_IDENTICAL_OBJ( obj, obj )",
        dst_template := "true",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "object" ],
        src_template := "IsCapCategoryObject( CreateCapCategoryObjectWithAttributes( cat, Opposite, object ) )",
        dst_template := "true",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "object" ],
        src_template := "IsCapCategoryMorphism( CreateCapCategoryMorphismWithAttributes( cat, source, target, Opposite, object ) )",
        dst_template := "true",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "statement" ],
        src_template := "statement and true",
        dst_template := "true",
    )
);
