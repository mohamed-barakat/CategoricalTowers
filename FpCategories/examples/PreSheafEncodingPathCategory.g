LoadPackage( "FpCategories", false );
#! true
q := FinQuiver( "q(1,2,3)[a:1->2,b:2->3,c:3->1]" );
#! 
P := PreSheafEncodingPathCategory( q );
