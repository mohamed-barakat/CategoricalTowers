CapJitAddLogicTemplate(
    rec(
        variable_names := [ "R" ],
        src_template := "OneImmutable( R )",
        dst_template := "1",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "func" ],
        src_template := "ListN( [ ], [ ], func )",
        dst_template := "[ ]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "T", "r", "mor" ],
        src_template := "ListN( [ r ], [ mor ], { a, m } -> MultiplyWithElementOfCommutativeRingForMorphisms( T, a, m ) )",
        dst_template := "[ MultiplyWithElementOfCommutativeRingForMorphisms( T, r, mor ) ]",
    )
);

# TODO: the following two logic templates only hold up to congruence

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "T", "mor" ],
        src_template := "MultiplyWithElementOfCommutativeRingForMorphisms( T, 1, mor )",
        dst_template := "mor",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "obj", "beta" ],
        src_template := "PreCompose( cat, IdentityMorphism( cat, obj ), beta )",
        dst_template := "beta",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "obj" ],
        src_template := "PreCompose( cat, alpha, IdentityMorphism( cat, obj ) )",
        dst_template := "alpha",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "mor" ],
        src_template := "AdditionForMorphisms( cat, ZeroMorphism( cat, source, target ), mor )",
        dst_template := "mor",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "mor" ],
        src_template := "MultiplyWithElementOfCommutativeRingForMorphisms( cat, -1, mor )",
        dst_template := "AdditiveInverseForMorphisms( cat, mor )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "obj" ],
        src_template := "DirectSum( cat, [ obj ] )",
        dst_template := "obj",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "mor", "target" ],
        src_template := "MorphismBetweenDirectSums( cat, [ source ], [ [ mor ] ], [ target ] )",
        dst_template := "mor",
    )
);
