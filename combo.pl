#!C:\Strawberry\perl\bin

use 5.006;
use strict;
use warnings;


use Math::Combinatorics;


# Quinella Combos 28
 # my @dogs = qw(1 2 3 4 5 6 7 8); 
 # my @c = combine(2, @dogs);
 # print join "\n", map { join " ", @$_ } @c;
 # print "\n";
 
 
 # Trifecta Box Combos
 my @dogs = qw(1 2 3 4 5 6 7 8); 
 my @c = combine(3, @dogs);
 print join "\n", map { join " ", @$_ } @c;
 print "\n";


