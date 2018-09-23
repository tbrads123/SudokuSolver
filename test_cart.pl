sub make_generator {
  my @lists = reverse @_;
  

  my @state = map { 0 } @lists;

  return sub {
    my $i = 0;

    return undef unless defined $state[0];

    while ($i < @lists) {
      $state[$i]++;
      last if $state[$i] < scalar @{$lists[$i]};
      $state[$i] = 0;
      $i++;
    }

    if ($i >= @state) {
      ## Sabotage things so we don't produce any more values
      $state[0] = undef;
      return undef;
    }

    my @out;
    for (0..$#state) {
      push @out, $lists[$_][$state[$_]];
    }

    return [reverse @out];
  };
}

#my $gen = make_generator([qw/foo bar baz/], [qw/cat dog/], [1..4]);


my $gg = 8;
my @aa; 
push(@aa, 8);
push(@aa, 9);
my $hh = 7;
my @ee;


my $gen = make_generator([$aa[0],$aa[1]], [qw/6 9/], [1..4]);

while ($_ = $gen->()) {
  #print join(", ", @$_), "\n";
  print @$_; print "\n";
 # push(@ee, @$_);
}




