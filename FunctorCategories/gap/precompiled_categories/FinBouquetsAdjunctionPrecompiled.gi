# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_FinBouquetsAdjunctionPrecompiled", function ( cat )
    
    ##
    AddDirectProductToExponentialAdjunctionMapWithGivenExponential( cat,
        
########
function ( cat_1, a_1, b_1, f_1, i_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, hoisted_6_1, hoisted_9_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, hoisted_17_1, deduped_18_1, hoisted_20_1, hoisted_21_1, hoisted_22_1, hoisted_25_1, hoisted_26_1, hoisted_27_1, hoisted_28_1, hoisted_29_1, hoisted_32_1, hoisted_36_1, deduped_37_1, hoisted_39_1, hoisted_44_1, hoisted_47_1, deduped_48_1, hoisted_50_1, deduped_53_1, deduped_54_1, hoisted_60_1, deduped_61_1, hoisted_62_1, deduped_63_1, hoisted_65_1, hoisted_66_1, hoisted_69_1, hoisted_70_1, deduped_71_1, hoisted_72_1, hoisted_73_1, hoisted_74_1, hoisted_77_1, deduped_78_1, hoisted_79_1, deduped_80_1, hoisted_82_1, hoisted_83_1, hoisted_84_1, hoisted_86_1, hoisted_87_1, hoisted_88_1, deduped_89_1, hoisted_90_1, hoisted_91_1, hoisted_92_1, hoisted_93_1, hoisted_94_1, hoisted_95_1, hoisted_97_1, hoisted_99_1, hoisted_100_1, hoisted_102_1, hoisted_104_1, hoisted_106_1, deduped_107_1, deduped_108_1, deduped_109_1, deduped_110_1, deduped_111_1, deduped_112_1, deduped_113_1, deduped_114_1, deduped_115_1, deduped_116_1, deduped_117_1, deduped_118_1, deduped_119_1, deduped_120_1, deduped_121_1, deduped_122_1, deduped_123_1, deduped_124_1, deduped_125_1, deduped_126_1, deduped_127_1, deduped_128_1, deduped_129_1, deduped_130_1, deduped_131_1, deduped_132_1, deduped_133_1, deduped_134_1, deduped_135_1, deduped_136_1, deduped_137_1, deduped_138_1, deduped_139_1, deduped_140_1, deduped_141_1, deduped_142_1, deduped_143_1, deduped_144_1, deduped_145_1, deduped_146_1, deduped_147_1, deduped_148_1, deduped_149_1, deduped_150_1, deduped_151_1, deduped_152_1, deduped_153_1, deduped_154_1, deduped_155_1, deduped_156_1, deduped_157_1, deduped_158_1, deduped_159_1, deduped_160_1, deduped_161_1, deduped_162_1, deduped_163_1, deduped_164_1, deduped_165_1, deduped_166_1, deduped_167_1, deduped_168_1, deduped_169_1, deduped_170_1, deduped_171_1, deduped_172_1, deduped_173_1, deduped_174_1, deduped_175_1, deduped_176_1, deduped_177_1, deduped_178_1, deduped_179_1, deduped_180_1, deduped_181_1, deduped_182_1, deduped_183_1, deduped_184_1, deduped_185_1, deduped_186_1, deduped_187_1, deduped_188_1, deduped_189_1, deduped_190_1, deduped_191_1, deduped_192_1;
    deduped_192_1 := [  ];
    deduped_191_1 := [ 2 ];
    deduped_190_1 := [ 1 ];
    deduped_189_1 := [ 0 ];
    deduped_188_1 := DefiningPairOfBouquetMorphismEnrichedOverSkeletalFinSets( f_1 );
    deduped_187_1 := DefiningTripleOfBouquetEnrichedOverSkeletalFinSets( b_1 );
    deduped_186_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    deduped_185_1 := DefiningTripleOfBouquetEnrichedOverSkeletalFinSets( a_1 );
    deduped_184_1 := deduped_187_1[3];
    deduped_183_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, 3 );
    deduped_182_1 := deduped_185_1[3];
    deduped_181_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, 0 );
    deduped_180_1 := DefiningTripleOfBouquetEnrichedOverSkeletalFinSets( Source( f_1 ) );
    deduped_179_1 := DefiningTripleOfBouquetEnrichedOverSkeletalFinSets( Range( f_1 ) );
    deduped_178_1 := deduped_187_1[2];
    deduped_177_1 := deduped_187_1[1];
    deduped_176_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, 2 );
    deduped_175_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, 1 );
    deduped_174_1 := ModelingCategory( ModelingCategory( cat_1 ) );
    deduped_173_1 := deduped_185_1[2];
    deduped_172_1 := deduped_185_1[1];
    deduped_171_1 := deduped_177_1 + deduped_178_1;
    deduped_170_1 := deduped_179_1[3];
    deduped_169_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_178_1 );
    deduped_168_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_173_1 );
    deduped_167_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_172_1 );
    deduped_166_1 := deduped_180_1[3];
    deduped_165_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_177_1 );
    deduped_164_1 := deduped_173_1 * deduped_178_1;
    deduped_163_1 := Source( deduped_174_1 );
    deduped_162_1 := [ 0 .. deduped_178_1 - 1 ];
    deduped_161_1 := [ 0 .. deduped_177_1 - 1 ];
    deduped_160_1 := CreateCapCategoryObjectWithAttributes( deduped_163_1, MapOfObject, CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_175_1, deduped_176_1, AsList, deduped_190_1 ) );
    deduped_159_1 := CreateCapCategoryObjectWithAttributes( deduped_163_1, MapOfObject, CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_175_1, deduped_176_1, AsList, deduped_189_1 ) );
    deduped_158_1 := [ 0 .. deduped_171_1 - 1 ];
    deduped_157_1 := ListWithIdenticalEntries( deduped_178_1, deduped_160_1 );
    deduped_156_1 := CreateCapCategoryMorphismWithAttributes( deduped_163_1, deduped_160_1, deduped_160_1, MapOfMorphism, CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_175_1, deduped_183_1, AsList, deduped_191_1 ) );
    deduped_155_1 := CreateCapCategoryMorphismWithAttributes( deduped_163_1, deduped_159_1, deduped_160_1, MapOfMorphism, CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_175_1, deduped_183_1, AsList, deduped_190_1 ) );
    deduped_154_1 := CreateCapCategoryMorphismWithAttributes( deduped_163_1, deduped_159_1, deduped_159_1, MapOfMorphism, CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_175_1, deduped_183_1, AsList, deduped_189_1 ) );
    deduped_153_1 := ListWithIdenticalEntries( 0, deduped_160_1 );
    deduped_152_1 := ListWithIdenticalEntries( deduped_177_1, deduped_159_1 );
    deduped_151_1 := CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_165_1, deduped_165_1, AsList, List( deduped_161_1, function ( logic_new_func_x_2 )
              return REM_INT( logic_new_func_x_2, deduped_177_1 );
          end ) );
    deduped_150_1 := [ 0 .. Length( deduped_162_1 ) - 1 ];
    deduped_149_1 := CreateCapCategoryObjectWithAttributes( deduped_174_1, Source, deduped_163_1, Range, deduped_186_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_175_1, deduped_175_1 ], [ CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_175_1, deduped_175_1, AsList, deduped_189_1 ) ] ) );
    deduped_148_1 := ListWithIdenticalEntries( deduped_178_1, deduped_155_1 );
    deduped_2_1 := [ deduped_172_1 * deduped_177_1, deduped_164_1 ];
    deduped_1_1 := [ deduped_159_1, deduped_160_1 ];
    deduped_147_1 := List( deduped_152_1, function ( logic_new_func_x_2 )
            return deduped_2_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
        end );
    deduped_146_1 := CreateCapCategoryObjectWithAttributes( deduped_174_1, Source, deduped_163_1, Range, deduped_186_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_175_1, deduped_181_1 ], [ CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_181_1, deduped_175_1, AsList, deduped_192_1 ) ] ) );
    deduped_3_1 := [ deduped_179_1[1], deduped_179_1[2] ];
    deduped_145_1 := List( deduped_152_1, function ( logic_new_func_x_2 )
            return deduped_3_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
        end );
    deduped_4_1 := [ deduped_180_1[1], deduped_180_1[2] ];
    deduped_144_1 := List( deduped_152_1, function ( logic_new_func_x_2 )
            return deduped_4_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
        end );
    deduped_5_1 := [ deduped_188_1[1], deduped_188_1[2] ];
    deduped_143_1 := List( deduped_152_1, function ( logic_new_func_x_2 )
            return deduped_5_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
        end );
    deduped_142_1 := deduped_146_1( deduped_160_1 );
    deduped_141_1 := Concatenation( deduped_144_1, List( deduped_157_1, function ( logic_new_func_x_2 )
              return deduped_4_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
          end ) );
    deduped_140_1 := Concatenation( deduped_145_1, List( deduped_157_1, function ( logic_new_func_x_2 )
              return deduped_3_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
          end ) );
    deduped_139_1 := Concatenation( deduped_147_1, List( deduped_157_1, function ( logic_new_func_x_2 )
              return deduped_2_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
          end ) );
    deduped_138_1 := CreateCapCategoryObjectWithAttributes( deduped_174_1, Source, deduped_163_1, Range, deduped_186_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_165_1, deduped_169_1 ], [ CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_169_1, deduped_165_1, AsList, deduped_184_1 ) ] ) );
    deduped_137_1 := CreateCapCategoryObjectWithAttributes( deduped_174_1, Source, deduped_163_1, Range, deduped_186_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_167_1, deduped_168_1 ], [ CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_168_1, deduped_167_1, AsList, deduped_182_1 ) ] ) );
    deduped_136_1 := Concatenation( deduped_145_1, List( deduped_153_1, function ( logic_new_func_x_2 )
              return deduped_3_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
          end ) );
    deduped_135_1 := Concatenation( deduped_144_1, List( deduped_153_1, function ( logic_new_func_x_2 )
              return deduped_4_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
          end ) );
    deduped_134_1 := Length( deduped_149_1( deduped_160_1 ) );
    deduped_133_1 := Length( deduped_149_1( deduped_159_1 ) );
    deduped_132_1 := ListOfValues( [ deduped_151_1, CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_169_1, deduped_169_1, AsList, List( deduped_162_1, function ( logic_new_func_x_2 )
                    return REM_INT( logic_new_func_x_2, deduped_178_1 );
                end ) ) ] );
    deduped_131_1 := Length( deduped_142_1 );
    deduped_130_1 := Length( deduped_146_1( deduped_159_1 ) );
    deduped_129_1 := ListOfValues( [ deduped_151_1, CreateCapCategoryMorphismWithAttributes( deduped_186_1, deduped_181_1, deduped_181_1, AsList, deduped_192_1 ) ] );
    deduped_128_1 := Length( deduped_137_1( deduped_160_1 ) );
    deduped_127_1 := Length( deduped_138_1( deduped_160_1 ) );
    deduped_126_1 := Length( deduped_137_1( deduped_159_1 ) );
    deduped_125_1 := Length( deduped_138_1( deduped_159_1 ) );
    deduped_124_1 := [ 1 .. Length( deduped_132_1 ) ];
    deduped_123_1 := [ 1 .. Length( deduped_129_1 ) ];
    deduped_122_1 := List( [ 0 .. deduped_164_1 - 1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := CAP_JIT_INCOMPLETE_LOGIC( i_2 );
            return deduped_182_1[1 + REM_INT( deduped_1_2, deduped_173_1 )] + deduped_184_1[(1 + REM_INT( QUO_INT( deduped_1_2, deduped_173_1 ), deduped_178_1 ))] * deduped_172_1;
        end );
    deduped_121_1 := [ 0 .. Product( deduped_141_1 ) - 1 ];
    deduped_120_1 := [ 0 .. Product( deduped_140_1 ) - 1 ];
    deduped_119_1 := [ 0 .. Product( deduped_139_1 ) - 1 ];
    deduped_118_1 := [ 0 .. Product( deduped_135_1 ) - 1 ];
    deduped_117_1 := deduped_134_1 * deduped_127_1;
    deduped_116_1 := deduped_133_1 * deduped_125_1;
    deduped_115_1 := deduped_131_1 * deduped_127_1;
    deduped_114_1 := deduped_130_1 * deduped_125_1;
    deduped_15_1 := [ deduped_189_1, deduped_190_1, deduped_191_1 ];
    deduped_14_1 := [ deduped_189_1, deduped_190_1, deduped_190_1 ];
    deduped_13_1 := [ deduped_189_1, deduped_189_1, deduped_190_1 ];
    deduped_12_1 := [ 0, 2 ];
    hoisted_65_1 := List( deduped_148_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2;
            deduped_3_2 := Source( logic_new_func_x_2 );
            deduped_2_2 := AsList( MapOfObject( deduped_3_2 ) );
            deduped_1_2 := 1 + deduped_12_1[(1 + deduped_2_2[1])];
            if IdFunc( function (  )
                        if deduped_2_2 = deduped_13_1[deduped_1_2] and AsList( MapOfObject( Range( logic_new_func_x_2 ) ) ) = deduped_14_1[deduped_1_2] then
                            return AsList( MapOfMorphism( logic_new_func_x_2 ) ) = deduped_15_1[deduped_1_2];
                        else
                            return false;
                        fi;
                        return;
                    end )(  ) then
                return [ 0 .. deduped_2_1[SafePosition( deduped_1_1, deduped_3_2 )] - 1 ];
            else
                return deduped_122_1;
            fi;
            return;
        end );
    hoisted_66_1 := List( deduped_150_1, function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2;
            deduped_4_2 := CAP_JIT_INCOMPLETE_LOGIC( logic_new_func_x_2 ) + deduped_177_1;
            hoisted_3_2 := hoisted_65_1[1 + logic_new_func_x_2];
            hoisted_2_2 := deduped_139_1[1 + deduped_4_2];
            hoisted_1_2 := Product( deduped_139_1{[ 1 .. deduped_4_2 ]} );
            return List( deduped_119_1, function ( i_3 )
                    return hoisted_3_2[1 + REM_INT( QUO_INT( CAP_JIT_INCOMPLETE_LOGIC( i_3 ), hoisted_1_2 ), hoisted_2_2 )];
                end );
        end );
    deduped_61_1 := Concatenation( deduped_152_1, deduped_157_1 );
    deduped_53_1 := List( deduped_162_1, function ( logic_new_func_x_2 )
            return deduped_184_1[1 + REM_INT( logic_new_func_x_2, deduped_178_1 )];
        end );
    hoisted_62_1 := List( deduped_162_1, function ( logic_new_func_x_2 )
            return deduped_2_1[SafePosition( deduped_1_1, deduped_61_1[1 + deduped_53_1[(1 + logic_new_func_x_2)]] )];
        end );
    deduped_63_1 := List( deduped_150_1, function ( j_2 )
            return Product( hoisted_62_1{[ 1 .. j_2 ]} );
        end );
    deduped_54_1 := Concatenation( List( deduped_152_1, function ( logic_new_func_x_2 )
              return AsList( MapOfObject( logic_new_func_x_2 ) );
          end ), List( deduped_157_1, function ( logic_new_func_x_2 )
              return AsList( MapOfObject( logic_new_func_x_2 ) );
          end ) );
    deduped_16_1 := [ deduped_159_1, deduped_159_1, deduped_160_1 ];
    hoisted_60_1 := List( deduped_150_1, function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2;
            deduped_8_2 := deduped_53_1[1 + CAP_JIT_INCOMPLETE_LOGIC( logic_new_func_x_2 )];
            deduped_7_2 := 1 + deduped_8_2;
            deduped_6_2 := 1 + deduped_12_1[(1 + deduped_54_1[deduped_7_2][1])];
            deduped_5_2 := deduped_13_1[deduped_6_2];
            deduped_4_2 := 1 + deduped_12_1[(1 + deduped_5_2[1])];
            if IdFunc( function (  )
                        if deduped_5_2 = deduped_13_1[deduped_4_2] and deduped_14_1[deduped_6_2] = deduped_14_1[deduped_4_2] then
                            return deduped_15_1[deduped_6_2] = deduped_15_1[deduped_4_2];
                        else
                            return false;
                        fi;
                        return;
                    end )(  ) then
                hoisted_3_2 := [ 0 .. deduped_2_1[SafePosition( deduped_1_1, deduped_16_1[deduped_6_2] )] - 1 ];
            else
                hoisted_3_2 := deduped_122_1;
            fi;
            hoisted_2_2 := deduped_139_1[deduped_7_2];
            hoisted_1_2 := Product( deduped_139_1{[ 1 .. deduped_8_2 ]} );
            return List( deduped_119_1, function ( i_3 )
                    return hoisted_3_2[1 + REM_INT( QUO_INT( CAP_JIT_INCOMPLETE_LOGIC( i_3 ), hoisted_1_2 ), hoisted_2_2 )];
                end );
        end );
    deduped_113_1 := Filtered( deduped_119_1, function ( x_2 )
            local deduped_1_2;
            deduped_1_2 := 1 + CAP_JIT_INCOMPLETE_LOGIC( x_2 );
            return Sum( deduped_150_1, function ( j_3 )
                      local deduped_1_3;
                      deduped_1_3 := 1 + j_3;
                      return hoisted_60_1[deduped_1_3][deduped_1_2] * deduped_63_1[deduped_1_3];
                  end ) = Sum( deduped_150_1, function ( j_3 )
                      local deduped_1_3;
                      deduped_1_3 := 1 + j_3;
                      return hoisted_66_1[deduped_1_3][deduped_1_2] * deduped_63_1[deduped_1_3];
                  end );
        end );
    deduped_112_1 := Filtered( [ 0 .. Product( Concatenation( deduped_147_1, List( deduped_153_1, function ( logic_new_func_x_2 )
                        return deduped_2_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
                    end ) ) ) - 1 ], function ( x_2 )
            return true;
        end );
    deduped_111_1 := [ 0 .. deduped_117_1 - 1 ];
    deduped_110_1 := [ 0 .. deduped_116_1 - 1 ];
    deduped_109_1 := [ 0 .. deduped_115_1 - 1 ];
    deduped_108_1 := [ 0 .. deduped_114_1 - 1 ];
    deduped_107_1 := List( deduped_152_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2;
            deduped_3_2 := 1 + deduped_12_1[(1 + AsList( MapOfObject( logic_new_func_x_2 ) )[1])];
            deduped_2_2 := deduped_13_1[deduped_3_2];
            deduped_1_2 := 1 + deduped_12_1[(1 + deduped_2_2[1])];
            if IdFunc( function (  )
                        if deduped_2_2 = deduped_13_1[deduped_1_2] and deduped_14_1[deduped_3_2] = deduped_14_1[deduped_1_2] then
                            return deduped_15_1[deduped_3_2] = deduped_15_1[deduped_1_2];
                        else
                            return false;
                        fi;
                        return;
                    end )(  ) then
                return [ 0 .. deduped_4_1[SafePosition( deduped_1_1, deduped_16_1[deduped_3_2] )] - 1 ];
            else
                return deduped_166_1;
            fi;
            return;
        end );
    hoisted_72_1 := List( deduped_148_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2;
            deduped_3_2 := Source( logic_new_func_x_2 );
            deduped_2_2 := AsList( MapOfObject( deduped_3_2 ) );
            deduped_1_2 := 1 + deduped_12_1[(1 + deduped_2_2[1])];
            if IdFunc( function (  )
                        if deduped_2_2 = deduped_13_1[deduped_1_2] and AsList( MapOfObject( Range( logic_new_func_x_2 ) ) ) = deduped_14_1[deduped_1_2] then
                            return AsList( MapOfMorphism( logic_new_func_x_2 ) ) = deduped_15_1[deduped_1_2];
                        else
                            return false;
                        fi;
                        return;
                    end )(  ) then
                return [ 0 .. deduped_3_1[SafePosition( deduped_1_1, deduped_3_2 )] - 1 ];
            else
                return deduped_170_1;
            fi;
            return;
        end );
    hoisted_73_1 := List( deduped_150_1, function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2;
            deduped_4_2 := CAP_JIT_INCOMPLETE_LOGIC( logic_new_func_x_2 ) + deduped_177_1;
            hoisted_3_2 := hoisted_72_1[1 + logic_new_func_x_2];
            hoisted_2_2 := deduped_140_1[1 + deduped_4_2];
            hoisted_1_2 := Product( deduped_140_1{[ 1 .. deduped_4_2 ]} );
            return List( deduped_120_1, function ( i_3 )
                    return hoisted_3_2[1 + REM_INT( QUO_INT( CAP_JIT_INCOMPLETE_LOGIC( i_3 ), hoisted_1_2 ), hoisted_2_2 )];
                end );
        end );
    hoisted_70_1 := List( deduped_162_1, function ( logic_new_func_x_2 )
            return deduped_3_1[SafePosition( deduped_1_1, deduped_61_1[1 + deduped_53_1[(1 + logic_new_func_x_2)]] )];
        end );
    deduped_71_1 := List( deduped_150_1, function ( j_2 )
            return Product( hoisted_70_1{[ 1 .. j_2 ]} );
        end );
    hoisted_69_1 := List( deduped_150_1, function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2;
            deduped_8_2 := deduped_53_1[1 + CAP_JIT_INCOMPLETE_LOGIC( logic_new_func_x_2 )];
            deduped_7_2 := 1 + deduped_8_2;
            deduped_6_2 := 1 + deduped_12_1[(1 + deduped_54_1[deduped_7_2][1])];
            deduped_5_2 := deduped_13_1[deduped_6_2];
            deduped_4_2 := 1 + deduped_12_1[(1 + deduped_5_2[1])];
            if IdFunc( function (  )
                        if deduped_5_2 = deduped_13_1[deduped_4_2] and deduped_14_1[deduped_6_2] = deduped_14_1[deduped_4_2] then
                            return deduped_15_1[deduped_6_2] = deduped_15_1[deduped_4_2];
                        else
                            return false;
                        fi;
                        return;
                    end )(  ) then
                hoisted_3_2 := [ 0 .. deduped_3_1[SafePosition( deduped_1_1, deduped_16_1[deduped_6_2] )] - 1 ];
            else
                hoisted_3_2 := deduped_170_1;
            fi;
            hoisted_2_2 := deduped_140_1[deduped_7_2];
            hoisted_1_2 := Product( deduped_140_1{[ 1 .. deduped_8_2 ]} );
            return List( deduped_120_1, function ( i_3 )
                    return hoisted_3_2[1 + REM_INT( QUO_INT( CAP_JIT_INCOMPLETE_LOGIC( i_3 ), hoisted_1_2 ), hoisted_2_2 )];
                end );
        end );
    hoisted_94_1 := Filtered( deduped_120_1, function ( x_2 )
            local deduped_1_2;
            deduped_1_2 := 1 + CAP_JIT_INCOMPLETE_LOGIC( x_2 );
            return Sum( deduped_150_1, function ( j_3 )
                      local deduped_1_3;
                      deduped_1_3 := 1 + j_3;
                      return hoisted_69_1[deduped_1_3][deduped_1_2] * deduped_71_1[deduped_1_3];
                  end ) = Sum( deduped_150_1, function ( j_3 )
                      local deduped_1_3;
                      deduped_1_3 := 1 + j_3;
                      return hoisted_73_1[deduped_1_3][deduped_1_2] * deduped_71_1[deduped_1_3];
                  end );
        end );
    hoisted_86_1 := List( deduped_158_1, function ( j_2 )
            return Product( deduped_140_1{[ 1 .. j_2 ]} );
        end );
    hoisted_84_1 := List( deduped_158_1, function ( j_2 )
            return Product( deduped_141_1{[ 1 .. j_2 ]} );
        end );
    deduped_80_1 := List( deduped_132_1, function ( logic_new_func_x_2 )
            return Length( Range( logic_new_func_x_2 ) );
        end );
    deduped_78_1 := List( deduped_132_1, function ( logic_new_func_x_2 )
            return Length( Source( logic_new_func_x_2 ) );
        end );
    hoisted_82_1 := Concatenation( List( deduped_124_1, function ( logic_new_func_x_2 )
              local hoisted_1_2, hoisted_2_2, deduped_3_2;
              deduped_3_2 := Sum( deduped_80_1{[ 1 .. logic_new_func_x_2 - 1 ]} );
              hoisted_2_2 := [ deduped_3_2 .. deduped_3_2 + deduped_80_1[logic_new_func_x_2] - 1 ];
              hoisted_1_2 := AsList( CAP_JIT_INCOMPLETE_LOGIC( deduped_132_1[logic_new_func_x_2] ) );
              return List( [ 0 .. deduped_78_1[logic_new_func_x_2] - 1 ], function ( logic_new_func_x_3 )
                      local hoisted_1_3, hoisted_2_3, deduped_3_3;
                      deduped_3_3 := hoisted_2_2[1 + hoisted_1_2[(1 + logic_new_func_x_3)]];
                      hoisted_2_3 := deduped_141_1[1 + deduped_3_3];
                      hoisted_1_3 := Product( deduped_141_1{[ 1 .. deduped_3_3 ]} );
                      return List( deduped_121_1, function ( i_4 )
                              return REM_INT( QUO_INT( i_4, hoisted_1_3 ), hoisted_2_3 );
                          end );
                  end );
          end ) );
    hoisted_79_1 := Concatenation( deduped_107_1, List( deduped_157_1, function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2;
              deduped_3_2 := 1 + deduped_12_1[(1 + AsList( MapOfObject( logic_new_func_x_2 ) )[1])];
              deduped_2_2 := deduped_13_1[deduped_3_2];
              deduped_1_2 := 1 + deduped_12_1[(1 + deduped_2_2[1])];
              if IdFunc( function (  )
                          if deduped_2_2 = deduped_13_1[deduped_1_2] and deduped_14_1[deduped_3_2] = deduped_14_1[deduped_1_2] then
                              return deduped_15_1[deduped_3_2] = deduped_15_1[deduped_1_2];
                          else
                              return false;
                          fi;
                          return;
                      end )(  ) then
                  return [ 0 .. deduped_4_1[SafePosition( deduped_1_1, deduped_16_1[deduped_3_2] )] - 1 ];
              else
                  return deduped_166_1;
              fi;
              return;
          end ) );
    hoisted_83_1 := List( [ 0 .. Sum( List( deduped_124_1, function ( logic_new_func_x_2 )
                      return Length( [ 0 .. deduped_78_1[logic_new_func_x_2] - 1 ] );
                  end ) ) - 1 ], function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, deduped_3_2;
            deduped_3_2 := 1 + logic_new_func_x_2;
            hoisted_2_2 := hoisted_79_1[deduped_3_2];
            hoisted_1_2 := hoisted_82_1[deduped_3_2];
            return List( deduped_121_1, function ( i_3 )
                    return hoisted_2_2[1 + hoisted_1_2[(1 + i_3)]];
                end );
        end );
    hoisted_74_1 := Concatenation( deduped_143_1, List( deduped_157_1, function ( logic_new_func_x_2 )
              return deduped_5_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
          end ) );
    hoisted_77_1 := List( [ 1 .. deduped_171_1 ], function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2;
            hoisted_3_2 := hoisted_74_1[logic_new_func_x_2];
            hoisted_2_2 := deduped_141_1[logic_new_func_x_2];
            hoisted_1_2 := Product( deduped_141_1{[ 1 .. logic_new_func_x_2 - 1 ]} );
            return List( deduped_121_1, function ( logic_new_func_x_3 )
                    return hoisted_3_2[1 + REM_INT( QUO_INT( logic_new_func_x_3, hoisted_1_2 ), hoisted_2_2 )];
                end );
        end );
    hoisted_93_1 := List( deduped_121_1, function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2;
            hoisted_1_2 := 1 + logic_new_func_x_2;
            hoisted_2_2 := 1 + CAP_JIT_INCOMPLETE_LOGIC( Sum( deduped_158_1, function ( j_3 )
                        local deduped_1_3;
                        deduped_1_3 := (1 + j_3);
                        return hoisted_83_1[deduped_1_3][hoisted_1_2] * hoisted_84_1[deduped_1_3];
                    end ) );
            return Sum( deduped_158_1, function ( j_3 )
                    local deduped_1_3;
                    deduped_1_3 := 1 + j_3;
                    return hoisted_77_1[deduped_1_3][hoisted_2_2] * hoisted_86_1[deduped_1_3];
                end );
        end );
    hoisted_90_1 := List( deduped_148_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2;
            deduped_3_2 := Source( logic_new_func_x_2 );
            deduped_2_2 := AsList( MapOfObject( deduped_3_2 ) );
            deduped_1_2 := 1 + deduped_12_1[(1 + deduped_2_2[1])];
            if IdFunc( function (  )
                        if deduped_2_2 = deduped_13_1[deduped_1_2] and AsList( MapOfObject( Range( logic_new_func_x_2 ) ) ) = deduped_14_1[deduped_1_2] then
                            return AsList( MapOfMorphism( logic_new_func_x_2 ) ) = deduped_15_1[deduped_1_2];
                        else
                            return false;
                        fi;
                        return;
                    end )(  ) then
                return [ 0 .. deduped_4_1[SafePosition( deduped_1_1, deduped_3_2 )] - 1 ];
            else
                return deduped_166_1;
            fi;
            return;
        end );
    hoisted_91_1 := List( deduped_150_1, function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2;
            deduped_4_2 := CAP_JIT_INCOMPLETE_LOGIC( logic_new_func_x_2 ) + deduped_177_1;
            hoisted_3_2 := hoisted_90_1[1 + logic_new_func_x_2];
            hoisted_2_2 := deduped_141_1[1 + deduped_4_2];
            hoisted_1_2 := Product( deduped_141_1{[ 1 .. deduped_4_2 ]} );
            return List( deduped_121_1, function ( i_3 )
                    return hoisted_3_2[1 + REM_INT( QUO_INT( CAP_JIT_INCOMPLETE_LOGIC( i_3 ), hoisted_1_2 ), hoisted_2_2 )];
                end );
        end );
    hoisted_88_1 := List( deduped_162_1, function ( logic_new_func_x_2 )
            return deduped_4_1[SafePosition( deduped_1_1, deduped_61_1[1 + deduped_53_1[(1 + logic_new_func_x_2)]] )];
        end );
    deduped_89_1 := List( deduped_150_1, function ( j_2 )
            return Product( hoisted_88_1{[ 1 .. j_2 ]} );
        end );
    hoisted_87_1 := List( deduped_150_1, function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2;
            deduped_8_2 := deduped_53_1[1 + CAP_JIT_INCOMPLETE_LOGIC( logic_new_func_x_2 )];
            deduped_7_2 := 1 + deduped_8_2;
            deduped_6_2 := 1 + deduped_12_1[(1 + deduped_54_1[deduped_7_2][1])];
            deduped_5_2 := deduped_13_1[deduped_6_2];
            deduped_4_2 := 1 + deduped_12_1[(1 + deduped_5_2[1])];
            if IdFunc( function (  )
                        if deduped_5_2 = deduped_13_1[deduped_4_2] and deduped_14_1[deduped_6_2] = deduped_14_1[deduped_4_2] then
                            return deduped_15_1[deduped_6_2] = deduped_15_1[deduped_4_2];
                        else
                            return false;
                        fi;
                        return;
                    end )(  ) then
                hoisted_3_2 := [ 0 .. deduped_4_1[SafePosition( deduped_1_1, deduped_16_1[deduped_6_2] )] - 1 ];
            else
                hoisted_3_2 := deduped_166_1;
            fi;
            hoisted_2_2 := deduped_141_1[deduped_7_2];
            hoisted_1_2 := Product( deduped_141_1{[ 1 .. deduped_8_2 ]} );
            return List( deduped_121_1, function ( i_3 )
                    return hoisted_3_2[1 + REM_INT( QUO_INT( CAP_JIT_INCOMPLETE_LOGIC( i_3 ), hoisted_1_2 ), hoisted_2_2 )];
                end );
        end );
    hoisted_92_1 := Filtered( deduped_121_1, function ( x_2 )
            local deduped_1_2;
            deduped_1_2 := 1 + CAP_JIT_INCOMPLETE_LOGIC( x_2 );
            return Sum( deduped_150_1, function ( j_3 )
                      local deduped_1_3;
                      deduped_1_3 := 1 + j_3;
                      return hoisted_87_1[deduped_1_3][deduped_1_2] * deduped_89_1[deduped_1_3];
                  end ) = Sum( deduped_150_1, function ( j_3 )
                      local deduped_1_3;
                      deduped_1_3 := 1 + j_3;
                      return hoisted_91_1[deduped_1_3][deduped_1_2] * deduped_89_1[deduped_1_3];
                  end );
        end );
    hoisted_106_1 := List( [ 0 .. Length( deduped_113_1 ) - 1 ], function ( x_2 )
            return -1 + SafePosition( hoisted_94_1, hoisted_93_1[(1 + hoisted_92_1[(1 + CAP_JIT_INCOMPLETE_LOGIC( x_2 ))])] );
        end );
    hoisted_104_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_117_1 );
    hoisted_102_1 := List( deduped_111_1, function ( logic_new_func_x_2 )
            return REM_INT( QUO_INT( logic_new_func_x_2, deduped_134_1 ), deduped_127_1 );
        end );
    hoisted_100_1 := deduped_137_1( deduped_156_1 );
    hoisted_99_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_116_1 );
    hoisted_97_1 := List( deduped_110_1, function ( logic_new_func_x_2 )
            return REM_INT( QUO_INT( logic_new_func_x_2, deduped_133_1 ), deduped_125_1 );
        end );
    hoisted_95_1 := deduped_137_1( deduped_155_1 );
    hoisted_28_1 := Filtered( [ 0 .. Product( deduped_136_1 ) - 1 ], function ( x_2 )
            return true;
        end );
    hoisted_25_1 := List( deduped_161_1, function ( j_2 )
            return Product( deduped_136_1{[ 1 .. j_2 ]} );
        end );
    hoisted_22_1 := List( deduped_161_1, function ( j_2 )
            return Product( deduped_135_1{[ 1 .. j_2 ]} );
        end );
    deduped_18_1 := List( deduped_129_1, function ( logic_new_func_x_2 )
            return Length( Range( logic_new_func_x_2 ) );
        end );
    deduped_11_1 := List( deduped_129_1, function ( logic_new_func_x_2 )
            return Length( Source( logic_new_func_x_2 ) );
        end );
    hoisted_20_1 := Concatenation( List( deduped_123_1, function ( logic_new_func_x_2 )
              local hoisted_1_2, hoisted_2_2, deduped_3_2;
              deduped_3_2 := Sum( deduped_18_1{[ 1 .. logic_new_func_x_2 - 1 ]} );
              hoisted_2_2 := [ deduped_3_2 .. deduped_3_2 + deduped_18_1[logic_new_func_x_2] - 1 ];
              hoisted_1_2 := AsList( CAP_JIT_INCOMPLETE_LOGIC( deduped_129_1[logic_new_func_x_2] ) );
              return List( [ 0 .. deduped_11_1[logic_new_func_x_2] - 1 ], function ( logic_new_func_x_3 )
                      local hoisted_1_3, hoisted_2_3, deduped_3_3;
                      deduped_3_3 := hoisted_2_2[1 + hoisted_1_2[(1 + logic_new_func_x_3)]];
                      hoisted_2_3 := deduped_135_1[1 + deduped_3_3];
                      hoisted_1_3 := Product( deduped_135_1{[ 1 .. deduped_3_3 ]} );
                      return List( deduped_118_1, function ( i_4 )
                              return REM_INT( QUO_INT( i_4, hoisted_1_3 ), hoisted_2_3 );
                          end );
                  end );
          end ) );
    hoisted_17_1 := Concatenation( deduped_107_1, List( deduped_153_1, function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2;
              deduped_3_2 := 1 + deduped_12_1[(1 + AsList( MapOfObject( logic_new_func_x_2 ) )[1])];
              deduped_2_2 := deduped_13_1[deduped_3_2];
              deduped_1_2 := 1 + deduped_12_1[(1 + deduped_2_2[1])];
              if IdFunc( function (  )
                          if deduped_2_2 = deduped_13_1[deduped_1_2] and deduped_14_1[deduped_3_2] = deduped_14_1[deduped_1_2] then
                              return deduped_15_1[deduped_3_2] = deduped_15_1[deduped_1_2];
                          else
                              return false;
                          fi;
                          return;
                      end )(  ) then
                  return [ 0 .. deduped_4_1[SafePosition( deduped_1_1, deduped_16_1[deduped_3_2] )] - 1 ];
              else
                  return deduped_166_1;
              fi;
              return;
          end ) );
    hoisted_21_1 := List( [ 0 .. Sum( List( deduped_123_1, function ( logic_new_func_x_2 )
                      return Length( [ 0 .. deduped_11_1[logic_new_func_x_2] - 1 ] );
                  end ) ) - 1 ], function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, deduped_3_2;
            deduped_3_2 := 1 + logic_new_func_x_2;
            hoisted_2_2 := hoisted_17_1[deduped_3_2];
            hoisted_1_2 := hoisted_20_1[deduped_3_2];
            return List( deduped_118_1, function ( i_3 )
                    return hoisted_2_2[1 + hoisted_1_2[(1 + i_3)]];
                end );
        end );
    hoisted_6_1 := Concatenation( deduped_143_1, List( deduped_153_1, function ( logic_new_func_x_2 )
              return deduped_5_1[SafePosition( deduped_1_1, logic_new_func_x_2 )];
          end ) );
    hoisted_9_1 := List( [ 1 .. deduped_177_1 ], function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2;
            hoisted_3_2 := hoisted_6_1[logic_new_func_x_2];
            hoisted_2_2 := deduped_135_1[logic_new_func_x_2];
            hoisted_1_2 := Product( deduped_135_1{[ 1 .. logic_new_func_x_2 - 1 ]} );
            return List( deduped_118_1, function ( logic_new_func_x_3 )
                    return hoisted_3_2[1 + REM_INT( QUO_INT( logic_new_func_x_3, hoisted_1_2 ), hoisted_2_2 )];
                end );
        end );
    hoisted_27_1 := List( deduped_118_1, function ( logic_new_func_x_2 )
            local hoisted_1_2, hoisted_2_2;
            hoisted_1_2 := 1 + logic_new_func_x_2;
            hoisted_2_2 := 1 + CAP_JIT_INCOMPLETE_LOGIC( Sum( deduped_161_1, function ( j_3 )
                        local deduped_1_3;
                        deduped_1_3 := (1 + j_3);
                        return hoisted_21_1[deduped_1_3][hoisted_1_2] * hoisted_22_1[deduped_1_3];
                    end ) );
            return Sum( deduped_161_1, function ( j_3 )
                    local deduped_1_3;
                    deduped_1_3 := 1 + j_3;
                    return hoisted_9_1[deduped_1_3][hoisted_2_2] * hoisted_25_1[deduped_1_3];
                end );
        end );
    hoisted_26_1 := Filtered( deduped_118_1, function ( x_2 )
            return true;
        end );
    hoisted_50_1 := List( [ 0 .. Length( deduped_112_1 ) - 1 ], function ( x_2 )
            return -1 + SafePosition( hoisted_28_1, hoisted_27_1[(1 + hoisted_26_1[(1 + CAP_JIT_INCOMPLETE_LOGIC( x_2 ))])] );
        end );
    deduped_48_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_128_1 * deduped_127_1 );
    hoisted_47_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_115_1 );
    hoisted_44_1 := List( deduped_109_1, function ( logic_new_func_x_2 )
            return REM_INT( QUO_INT( logic_new_func_x_2, deduped_131_1 ), deduped_127_1 );
        end );
    hoisted_39_1 := [ deduped_154_1, deduped_155_1, deduped_156_1 ];
    deduped_37_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_126_1 * deduped_125_1 );
    hoisted_36_1 := CreateCapCategoryObjectWithAttributes( deduped_186_1, Length, deduped_114_1 );
    hoisted_32_1 := List( deduped_108_1, function ( logic_new_func_x_2 )
            return REM_INT( QUO_INT( logic_new_func_x_2, deduped_130_1 ), deduped_125_1 );
        end );
    hoisted_29_1 := deduped_137_1( deduped_154_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, i_1, DefiningPairOfBouquetMorphismEnrichedOverSkeletalFinSets, NTuple( 2, List( [ 0 .. deduped_172_1 - 1 ], function ( logic_new_func_x_2 )
                local hoisted_1_2, hoisted_2_2, hoisted_4_2, deduped_5_2;
                hoisted_2_2 := List( deduped_142_1, function ( logic_new_func_x_3 )
                        return deduped_137_1( hoisted_39_1[1 + deduped_192_1[(1 + logic_new_func_x_3)]] )( logic_new_func_x_2 );
                    end );
                hoisted_1_2 := hoisted_29_1( logic_new_func_x_2 );
                deduped_5_2 := ListOfValues( [ CreateCapCategoryMorphismWithAttributes( deduped_186_1, hoisted_36_1, deduped_37_1, AsList, List( deduped_108_1, function ( i_3 )
                                return hoisted_1_2 + hoisted_32_1[(1 + i_3)] * deduped_126_1;
                            end ) ), CreateCapCategoryMorphismWithAttributes( deduped_186_1, hoisted_47_1, deduped_48_1, AsList, List( deduped_109_1, function ( i_3 )
                                return hoisted_2_2[1 + REM_INT( CAP_JIT_INCOMPLETE_LOGIC( i_3 ), deduped_131_1 )] + hoisted_44_1[(1 + i_3)] * deduped_128_1;
                            end ) ) ] );
                hoisted_4_2 := List( deduped_5_2, function ( logic_new_func_x_3 )
                        return Length( Range( logic_new_func_x_3 ) ) ^ Length( Source( logic_new_func_x_3 ) );
                    end );
                return hoisted_50_1[SafePosition( deduped_112_1, Sum( [ 0 .. Length( deduped_5_2 ) - 1 ], function ( j_3 )
                           local hoisted_2_3, hoisted_3_3, hoisted_4_3, deduped_5_3, deduped_6_3;
                           deduped_6_3 := CAP_JIT_INCOMPLETE_LOGIC( deduped_5_2[1 + j_3] );
                           deduped_5_3 := Length( Source( deduped_6_3 ) );
                           hoisted_4_3 := Length( Range( deduped_6_3 ) );
                           hoisted_3_3 := AsList( deduped_6_3 );
                           hoisted_2_3 := CAP_JIT_INCOMPLETE_LOGIC( deduped_5_3 * GeometricSumDiff1( deduped_5_3, deduped_5_3 ) );
                           return [ Sum( List( [ 0 .. (deduped_5_3 - 1) ], function ( k_4 )
                                             return hoisted_3_3[(1 + CAP_JIT_INCOMPLETE_LOGIC( REM_INT( QUO_INT( hoisted_2_3, deduped_5_3 ^ CAP_JIT_INCOMPLETE_LOGIC( k_4 ) ), deduped_5_3 ) ))] * hoisted_4_3 ^ k_4;
                                         end ) ) ][1] * Product( hoisted_4_2{[ 1 .. CAP_JIT_INCOMPLETE_LOGIC( j_3 ) ]} );
                       end ) )];
            end ), List( [ 0 .. deduped_173_1 - 1 ], function ( logic_new_func_x_2 )
                local hoisted_1_2, hoisted_2_2, hoisted_4_2, deduped_5_2;
                hoisted_2_2 := hoisted_100_1( logic_new_func_x_2 );
                hoisted_1_2 := hoisted_95_1( logic_new_func_x_2 );
                deduped_5_2 := ListOfValues( [ CreateCapCategoryMorphismWithAttributes( deduped_186_1, hoisted_99_1, deduped_37_1, AsList, List( deduped_110_1, function ( i_3 )
                                return hoisted_1_2 + hoisted_97_1[(1 + i_3)] * deduped_126_1;
                            end ) ), CreateCapCategoryMorphismWithAttributes( deduped_186_1, hoisted_104_1, deduped_48_1, AsList, List( deduped_111_1, function ( i_3 )
                                return hoisted_2_2 + hoisted_102_1[(1 + i_3)] * deduped_128_1;
                            end ) ) ] );
                hoisted_4_2 := List( deduped_5_2, function ( logic_new_func_x_3 )
                        return Length( Range( logic_new_func_x_3 ) ) ^ Length( Source( logic_new_func_x_3 ) );
                    end );
                return hoisted_106_1[SafePosition( deduped_113_1, Sum( [ 0 .. Length( deduped_5_2 ) - 1 ], function ( j_3 )
                           local hoisted_2_3, hoisted_3_3, hoisted_4_3, deduped_5_3, deduped_6_3;
                           deduped_6_3 := CAP_JIT_INCOMPLETE_LOGIC( deduped_5_2[1 + j_3] );
                           deduped_5_3 := Length( Source( deduped_6_3 ) );
                           hoisted_4_3 := Length( Range( deduped_6_3 ) );
                           hoisted_3_3 := AsList( deduped_6_3 );
                           hoisted_2_3 := CAP_JIT_INCOMPLETE_LOGIC( deduped_5_3 * GeometricSumDiff1( deduped_5_3, deduped_5_3 ) );
                           return [ Sum( List( [ 0 .. (deduped_5_3 - 1) ], function ( k_4 )
                                             return hoisted_3_3[(1 + CAP_JIT_INCOMPLETE_LOGIC( REM_INT( QUO_INT( hoisted_2_3, deduped_5_3 ^ CAP_JIT_INCOMPLETE_LOGIC( k_4 ) ), deduped_5_3 ) ))] * hoisted_4_3 ^ k_4;
                                         end ) ) ][1] * Product( hoisted_4_2{[ 1 .. CAP_JIT_INCOMPLETE_LOGIC( j_3 ) ]} );
                       end ) )];
            end ) ) );
end
########
        
    , 602 : IsPrecompiledDerivation := true );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        #Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "FinBouquetsAdjunctionPrecompiled", function (  )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function (  )
    return CategoryOfBouquetsEnrichedOver( CategoryOfSkeletalFinSets(  : FinalizeCategory := true ) );
end;
        
        
    
    cat := category_constructor(  : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_FinBouquetsAdjunctionPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
