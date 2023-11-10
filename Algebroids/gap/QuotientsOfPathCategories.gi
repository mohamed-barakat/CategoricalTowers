# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Implementations
#

##
InstallOtherMethod( QuotientCategory,
        [ IsPathCategory, IsDenseList ],
  
  function ( C, relations )
    local reduced_gb, leading_monomials, congruence_function, name, quo_C, q, hom_quo_C;
    
    reduced_gb := ReducedGroebnerBasis( C, relations );
    
    congruence_function :=
      { mor_1, mor_2 } -> IsEqualForMorphisms( C,
                              ReductionOfMorphism( C, mor_1, reduced_gb ),
                              ReductionOfMorphism( C, mor_2, reduced_gb ) );
    
    name := List( relations{[ 1 .. Minimum( 3, Length( relations ) ) ]},
              rel -> Concatenation( MorphismLabel( rel[1] ), " = ", MorphismLabel( rel[2] ) ) );
    
    if Length( relations ) > 3 then
          Add( name, "..." );
    fi;
    
    name := Concatenation( Name( C ), " / [ ", JoinStringsWithSeparator( name, ", " ), " ]" );
    
    quo_C := QuotientCategory(
                rec( name := name,
                     category_filter := IsQuotientOfPathCategory,
                     category_object_filter := IsQuotientOfPathCategoryObject,
                     category_morphism_filter := IsQuotientOfPathCategoryMorphism,
                     nr_arguments_of_congruence_function := 2,
                     congruence_function := congruence_function,
                     underlying_category := C ) : FinalizeCategory := false, overhead := false );
    
    SetDefiningRelations( quo_C, relations );
    
    SetGroebnerBasisOfDefiningRelations( quo_C, reduced_gb );
    
    SetSetOfObjects( quo_C, List( SetOfObjects( C ), o -> ObjectConstructor( quo_C, o ) ) );
    
    SetSetOfGeneratingMorphisms( quo_C,
            List( SetOfGeneratingMorphisms( C ),
              m -> MorphismConstructor( quo_C,
                      SetOfObjects( quo_C )[ObjectIndex( Source( m ) )],
                      m,
                      SetOfObjects( quo_C )[ObjectIndex( Target( m ) )] ) ) );
    
    leading_monomials := List( reduced_gb, g -> g[1] );
    
    if HasFiniteNumberOfNonMultiples( C, leading_monomials ) then
        
        q := CapQuiver( C );
        
        hom_quo_C := ExternalHoms( C, leading_monomials );
        
        SetExternalHoms( quo_C,
              LazyHList( [ 1 .. NumberOfObjects( q ) ],
                s -> LazyHList( [ 1 .. NumberOfObjects( q ) ],
                  t -> List( hom_quo_C[s][t],
                    m -> MorphismConstructor( quo_C,
                              SetOfObjects( quo_C )[s],
                              m,
                              SetOfObjects( quo_C )[t] ) ) ) ) );
        
        SetIsEquippedWithHomomorphismStructure( quo_C, true );
        
        SetRangeCategoryOfHomomorphismStructure( quo_C, SkeletalFinSets );
        
        ##
        AddMorphismsOfExternalHom( quo_C,
          function ( quo_C, obj_1, obj_2 )
            local s, t;
            
            s := ObjectIndex( ObjectDatum( obj_1 ) );
            t := ObjectIndex( ObjectDatum( obj_2 ) );
            
            return ExternalHoms( quo_C )[s][t];
            
        end );
        
    fi;
    
    Finalize( quo_C );
    
    return quo_C;
    
end );

##
InstallOtherMethod( \/,
        [ IsPathCategory, IsDenseList ],
  
  QuotientCategory
);

##
InstallMethod( CanonicalRepresentative,
        [ IsQuotientOfPathCategoryMorphism ],
  
  function ( mor )
    local qC;
    
    qC := CapCategory( mor );
    
    return ReductionOfMorphism( UnderlyingCategory( qC ), MorphismDatum( qC, mor ), GroebnerBasisOfDefiningRelations( qC ) );
    
end );

InstallMethod( ObjectIndex,
          [ IsQuotientOfPathCategoryObject ],
  
  function ( obj )
    
    return ObjectIndex( ObjectDatum( obj ) );
    
end );

##
InstallMethod( DisplayString,
          [ IsQuotientOfPathCategoryObject ],
  
  function ( obj )
    
    return Concatenation( ViewString( obj ), "\n" );
    
end );

##
InstallMethod( ViewString,
          [ IsQuotientOfPathCategoryObject ],
  
  function ( obj )
    
    return ViewString( UnderlyingCell( obj ) );
    
end );

##
InstallMethod( DisplayString,
          [ IsQuotientOfPathCategoryMorphism ],
  
  function ( mor )
    
    return Concatenation( ViewString( mor ), "\n" );
    
end );

##
InstallMethod( ViewString,
          [ IsQuotientOfPathCategoryMorphism ],
  function ( mor )
    local colors, str;
    
    colors := CapQuiver( UnderlyingCategory( CapCategory( mor ) ) )!.colors;
    
    str := ViewString( CanonicalRepresentative( mor ) );
    
    str := Concatenation( "[", str );
    
    str := ReplacedString(
                  str,
                  Concatenation( colors!.other, ":" ),
                  Concatenation( colors.reset, "]", colors.other, ":") );
    
    return str;
    
end );
