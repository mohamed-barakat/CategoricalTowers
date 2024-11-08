LoadPackage( "FpCategories", false );
#! true
q := FinQuiver( "q(1,2,3)[a:1->2,b:2->3,c:3->1,d:1->3]" );
#! 
P := PreSheafEncodingPathCategory( q );

## L := List( [ -(m-1) .. (n-1) ], i -> [ [ Maximum( -i, 0 ), Maximum( i+m-n, 0 ) ], [ Maximum( -i-m+n, 0 ), Maximum( i, 0 ) ] ] );