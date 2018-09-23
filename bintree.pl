#!/usr/bin/perl -w
# 

#bintree - binary tree demo program
use strict;
my($root, $n);

#first generate 20 random inserts
#while ($n++ < 10) { insert($root, int(rand(100)))}


insert($root, 3);
insert($root, 5);
insert($root, 8);
insert($root, 6);
insert($root, 4);
insert($root, 9);
insert($root, 3);
insert($root, 7);



# now dump out the tree all three ways
print "Pre order:  ";  pre_order($root);  print "\n";
print "In order:   ";  in_order($root);   print "\n";
print "Post order: ";  post_order($root); print "\n";

# prompt until EOF
for (print "Search? "; <>; print "Search? ") { 
    chomp;
    my $found = search($root, $_);
    if ($found) { print "Found $_ at $found, $found->{VALUE}\n" }
    else        { print "No $_ in tree\n" }
}

exit;

#########################################

# insert given value into proper point of
# provided tree.  If no tree provided, 
# use implicit pass by reference aspect of @_
# to fill one in for our caller.
sub insert {
    my($tree, $value) = @_;
    #printf("value: %s\n", $value);
    unless ($tree) {
        $tree = {};                         # allocate new node
        $tree->{VALUE}  = $value;
        $tree->{LEFT}   = undef;
        $tree->{RIGHT}  = undef;
        $_[0] = $tree;              # $_[0] is reference param!
        return;
    }
    # if    ($tree->{VALUE} > $value) { insert($tree->{LEFT},  $value) }
    # elsif ($tree->{VALUE} < $value) { insert($tree->{RIGHT}, $value) }
    # else                            { warn "dup insert of $value\n"  }
                                    # # XXX: no dups
                                    
     insert($tree->{LEFT},  $value)                               
   
}

# recurse on left child, 
# then show current value, 
# then recurse on right child.
sub in_order {
    my($tree) = @_;
    return unless $tree;
    in_order($tree->{LEFT});
    print $tree->{VALUE}, " ";
    in_order($tree->{RIGHT});
}

# show current value, 
# then recurse on left child, 
# then recurse on right child.
sub pre_order {
    my($tree) = @_;
    return unless $tree;
    print $tree->{VALUE}, " ";
    pre_order($tree->{LEFT});
    pre_order($tree->{RIGHT});
}

# recurse on left child, 
# then recurse on right child,
# then show current value. 
sub post_order {
    my($tree) = @_;
    return unless $tree;
    post_order($tree->{LEFT});
    post_order($tree->{RIGHT});
    print $tree->{VALUE}, " ";
}

# find out whether provided value is in the tree.
# if so, return the node at which the value was found.
# cut down search time by only looking in the correct
# branch, based on current value.
sub search {
    my($tree, $value) = @_;
    return unless $tree;
    if ($tree->{VALUE} == $value) {
        return $tree;
    }
    search($tree->{ ($value < $tree->{VALUE}) ? "LEFT" : "RIGHT"}, $value)
}