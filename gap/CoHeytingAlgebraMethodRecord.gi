# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

InstallValue( COHEYTING_ALGEBRA_METHOD_NAME_RECORD,
        rec(
ConegationOnObjects := rec(
  filter_list := [ "category", "object" ],
  return_type := "object" ),

ConegationOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "ConegationOnObjects( cat, Range( alpha ) )",
  output_range_getter_string := "ConegationOnObjects( cat, Source( alpha ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

ConegationOnMorphismsWithGivenConegations := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

MorphismFromDoubleConegation := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "ConegationOnObjects( cat, ConegationOnObjects( cat, a ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

MorphismFromDoubleConegationWithGivenDoubleConegation := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "r", "a" ] ],
  return_type := "morphism" ),

            ) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COHEYTING_ALGEBRA_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    COHEYTING_ALGEBRA_METHOD_NAME_RECORD,
    "Locales",
    "CoHeytingAlgebra.autogen.gd",
    "Co-Heyting algebras",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( COHEYTING_ALGEBRA_METHOD_NAME_RECORD, "Locales" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COHEYTING_ALGEBRA_METHOD_NAME_RECORD );
