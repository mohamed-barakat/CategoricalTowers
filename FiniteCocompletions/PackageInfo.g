# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "FiniteCocompletions",
Subtitle := "Finite (co)product/(co)limit (co)completions",
Version := "2025.08-01",
Date := ~.Version{[ 1 .. 10 ]},
Date := (function ( ) if IsBound( GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE ) then return GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE; else return Concatenation( ~.Version{[ 1 .. 4 ]}, "-", ~.Version{[ 6, 7 ]}, "-01" ); fi; end)( ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mohamed",
    LastName := "Barakat",
    WWWHome := "https://mohamed-barakat.github.io",
    Email := "mohamed.barakat@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/CategoricalTowers",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/FiniteCocompletions",
PackageInfoURL  := "https://homalg-project.github.io/CategoricalTowers/FiniteCocompletions/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CategoricalTowers/FiniteCocompletions/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CategoricalTowers/releases/download/FiniteCocompletions-", ~.Version, "/FiniteCocompletions-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "FiniteCocompletions",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Finite (co)product/(co)limit (co)completions",
),

Dependencies := rec(
  GAP := ">= 4.13.0",
  NeededOtherPackages := [
                   [ "GAPDoc", ">= 1.5" ],
                   [ "CAP", ">= 2025.07-04" ],
                   [ "MonoidalCategories", ">= 2025.07-03" ],
                   [ "CartesianCategories", ">= 2025.07-03" ],
                   [ "Toposes", ">= 2024.02-08" ],
                   [ "ToolsForCategoricalTowers", ">= 2025.08-01" ],
                   [ "Toposes", ">= 2024.01-02" ],
                   [ "FinSetsForCAP", ">= 2024.03-01" ],
                   [ "Locales", ">= 2024.03-04" ],
                   [ "QuotientCategories", ">= 2025.03-02" ],
                   [ "FpCategories", ">= 2024.09-06" ],
                   [ "Algebroids", ">= 2024.09-04" ],
                   [ "PreSheaves", ">= 2024.11-02" ],
                   ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

Keywords := [ "finite coproduct cocompletions, finite product completions, finite colimit cocompletions, finite limit completions" ],

));
