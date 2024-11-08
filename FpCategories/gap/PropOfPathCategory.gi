# SPDX-License-Identifier: GPL-2.0-or-later
# FpCategories: Finitely presented categories by generating quivers and relations
#
# Implementations
#

##
BindGlobal( "PropOfPathCategory",
  function (  )
    local Prop;
    
    Prop :=
      CreateCapCategoryWithDataTypes( "PropOfPathCategory",
              IsPropOfPathCategory,
              IsObjectInPropOfPathCategory,
              IsMorphismInPropOfPathCategory,
              IsCapCategoryTwoCell,
              IsBigInt,
              CapJitDataTypeOfNTupleOf( 2,
                      IsBigInt,
                      CapJitDataTypeOfListOf(
                              CapJitDataTypeOfNTupleOf( 3,
                                      IsBigInt,
                                      IsInt,
                                      IsBigInt ) ) ),
              fail
              : overhead := false );
    
    SetRangeCategoryOfHomomorphismStructure( Prop, SkeletalFinSets );
    
    Prop!.category_as_first_argument := true;
    
    ##
    AddObjectConstructor( Prop,
      function ( Prop, obj_index )
        
        return CreateCapCategoryObjectWithAttributes( Prop,
                       ObjectIndex, obj_index );
        
    end );
    
    ##
    AddObjectDatum( Prop,
      function ( Prop, obj )
        
        return ObjectIndex( obj );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( Prop,
      function ( Prop, obj )
        local obj_index;
        
        obj_index := ObjectDatum( Prop, obj );
        
        return IsBigInt( obj_index ) and obj_index >= 0;
        
    end );
    
    ##
    AddIsEqualForObjects( Prop,
      function ( Prop, obj_1, obj_2 )
        
        return ObjectDatum( Prop, obj_1 ) = ObjectDatum( Prop, obj_2 );
        
    end );
    
    ##
    AddMorphismConstructor( Prop,
      function ( Prop, source, datum, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsList( datum ) and not IsEmpty( datum ) and ForAll( datum, IsList ) and ForAll( datum, L -> Length( L ) = 3 ) );
        
        return CreateCapCategoryMorphismWithAttributes( Prop,
                       source, target,
                       MorphismListOfTriples, datum );
        
    end );
     
    ##
    AddMorphismDatum( Prop,
      function ( Prop, mor )
        
        return MorphismListOfTriples( mor );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( Prop,
      function ( Prop, mor )
        local datum, l, source_index, target_index;
        
        datum := MorphismDatum( Prop, mor );
        
        l := Length( datum );
        
        source_index := ObjectDatum( Prop, Source( mor ) );
        target_index := ObjectDatum( Prop, Target( mor ) );
        
        return ForAll( datum, L -> IsBigInt( L[1] ) and L[1] >= 0 ) and
               ForAll( datum, L -> IsBigInt( L[3] ) and L[3] >= 0 ) and
               datum[1][1] = source_index and datum[l][3] = target_index and
               ForAll( datum, L -> IsInt( L[2] ) and L[2] in [ 1, 2 ] ) and
               ForAll( [ 1 .. l - 1 ], i -> datum[i][3] = datum[i+1][1] );
        
    end );
    
    ##
    AddIsEqualForMorphisms( Prop,
      function ( Prop, mor_1, mor_2 )
        
        return MorphismDatum( Prop, mor_1 ) = MorphismDatum( Prop, mor_2 );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( Prop,
      function ( Prop, mor_1, mor_2 )
        
        return IsEqualForMorphisms( Prop, mor_1, mor_2 );
        
    end );
    
    AddIdentityMorphism( Prop,
      function ( Prop, obj )
        local obj_index;
        
        obj_index := ObjectDatum( Prop, obj );
        
        return MorphismConstructor( Prop,
                       obj,
                       [ Triple( obj_index, 0, obj_index ) ],
                       obj );
        
    end );
    
    AddPreCompose( Prop,
      function ( Prop, pre_mor, post_mor )
        
        return MorphismConstructor( Prop,
                       Source( pre_mor ),
                       Concatenation( MorphismDatum( Prop, pre_mor ), MorphismDatum( Prop, post_mor ) ),
                       Target( post_mor ) );
        
    end );
    
    Finalize( Prop );
    
    return Prop;
    
end( ) );

##
InstallMethod( \.,
        [ IsPropOfPathCategory, IsPosInt ],
  
  function ( Prop, string_as_int )
    local name, value;
    
    name := NameRNam( string_as_int );
    
    value := EvalString( name );
    
    if IsInt( value ) then
        return ObjectConstructor( Prop, value );
    elif IsList( value ) and ForAll( value, IsInt ) then
        return MorphismConstructor( Prop,
                       ObjectConstructor( Prop, value[1] ),
                       [ value ],
                       ObjectConstructor( Prop, value[3] ) );
    else
        Error( "wrong key: ", name );
    fi;
    
end );

##
InstallMethod( PreSheafEncodingPathCategory,
          [ IsFinQuiver ],
  
  function ( q )
    local Prop, PSh, presheaf_record, obj_func, mor_func, object_func, morphism_func, P;
    
    Prop := PropOfPathCategory;
    
    PSh := PreSheaves( Prop );
    
    presheaf_record :=
      rec( 0 := FinSet( NumberOfObjects( q ) ),
           1 := FinSet( NumberOfMorphisms( q ) ),
           (String( [ 1, 1, 0 ] )) := MapOfFinSets( ~.1, -1 + IndicesOfSources( q ), ~.0 ),
           (String( [ 1, 2, 0 ] )) := MapOfFinSets( ~.1, -1 + IndicesOfTargets( q ), ~.0 ) );
    
    obj_func :=
      function( i )
        local t, s, fiber_product, id_i, si, ti, j;
        
        if IsBound( presheaf_record.(i) ) then
            return presheaf_record.(i);
        fi;
        
        t := mor_func( 1, 2, 0 );
        s := mor_func( i - 1, 1, 0 );
        
        fiber_product := FiberProduct( [ t, s ] );
        
        presheaf_record.(i) := fiber_product;
        id_i := IdentityMorphism( fiber_product );
        presheaf_record.(String( [ i, 1, i ] )) := id_i;
        presheaf_record.(String( [ i, 2, i ] )) := id_i;
        
        si := ProjectionInFactorOfFiberProductWithGivenFiberProduct( [ t, s ], 1, fiber_product );
        
        presheaf_record.(String( [ i, 1, 1 ] )) := si;
        presheaf_record.(String( [ i, 1, 0 ] )) := PreCompose( si, mor_func( 1, 1, 0 ) );
        
        ti := ProjectionInFactorOfFiberProductWithGivenFiberProduct( [ t, s ], 2, fiber_product );
        
        presheaf_record.(String( [ i, 2, i - 1 ] )) := ti;
        
        if i > 2 then
            presheaf_record.(String( [ i, 2, 1 ] )) := PreCompose( ti, mor_func( i - 1, 2, 1 ) );
            if i > 3 then
                for j in [ 2 .. i - 2 ] do
                    presheaf_record.(String( [ i, 2, j ] )) := PreCompose( ti, presheaf_record.(String( [ i - 1, 2, j ] )) );
                od;
            fi;
        fi;
        
        ## we now mirror the construction:
        
        t := mor_func( i - 1, 2, 0 );
        s := mor_func( 1, 1, 0 );
        
        Assert( 0, FiberProduct( [ t, s ] ) = fiber_product );
        
        si := ProjectionInFactorOfFiberProductWithGivenFiberProduct( [ t, s ], 1, fiber_product );
        
        presheaf_record.(String( [ i, 1, i - 1 ] )) := si;
        
        ti := ProjectionInFactorOfFiberProductWithGivenFiberProduct( [ t, s ], 2, fiber_product );
        
        presheaf_record.(String( [ i, 2, 1 ] )) := ti;
        presheaf_record.(String( [ i, 2, 0 ] )) := PreCompose( ti, mor_func( 1, 2, 0 ) );
        
        if i > 2 then
            presheaf_record.(String( [ i, 1, 1 ] )) := PreCompose( si, mor_func( i - 1, 1, 1 ) );
            if i > 3 then
                for j in [ 2 .. i - 2 ] do
                    presheaf_record.(String( [ i, 1, j ] )) := PreCompose( si, presheaf_record.(String( [ i - 1, 1, j ] )) );
                od;
            fi;
        fi;
        
        return fiber_product;
        
    end;
    
    mor_func :=
      function( s, i, t )
        
        obj_func( s );
        
        return presheaf_record.(String( [ s, i, t ] ));
        
    end;
    
    object_func :=
      function( obj )
        
        return obj_func( ObjectDatum( Prop, obj ) );
        
    end;
    
    morphism_func :=
      function( source, mor, target )
        local datum, triple;
        
        datum := MorphismDatum( Prop, mor );
        
        Assert( 0, Length( datum ) = 1 );
        
        triple := datum[1];
        
        Assert( 0, Length( triple ) = 3 );
        
        return mor_func( triple[3], triple[2], triple[1] );
        
    end;
    
    P := ObjectConstructor( PSh,
                 Pair( object_func, morphism_func ) );
    
    P!.presheaf_record := presheaf_record;
    
    return P;
    
end );
