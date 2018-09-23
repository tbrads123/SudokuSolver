my @aoa = (
    [('a'..'z')],
    [('A'..'Z')],
    [(1..26)],
);


my $iter = make_permutator(@aoa);


while (my @els = $iter->() ){
    print @els,"\n";
}


sub make_permutator{
    my @arefs = @_;
    my @arrayindexes = ();
    foreach (@arefs){
        push @arrayindexes,[$_,0,$#{$_}];
    }
    
    return sub {
            return if $arrayindexes[0]->[1] > $arrayindexes[0]->[2]; 
            my @els =  map { $_->[0]->[ $_->[1]] } @arrayindexes;
            # Check for out of bounds....
            $arrayindexes[$#arrayindexes]->[1]++;
            for (my $i = $#arrayindexes; $i > 0; $i--){
                    if ($arrayindexes[$i]->[1] > $arrayindexes[$i]->[2]){
                        $arrayindexes[$i]->[1] = 0;
                        $arrayindexes[$i-1]->[1]++;
                    }else{
                        last;
                    }
            }
            return @els;
            
    };
}