#!/apps/perl/bin/perl -w


my $input = '';
while ( $input !~ /^\d{81}$/ )
{
	&usage if( $input =~ /-h/ );
	
	print "\n\n";
	print "Please key in input_string, or type -h for help...\n";
	print "(input_string must be an 81-digit string)\n";

	chomp($input = <STDIN>);
}


print "Solving Sudoku ... Please wait ...\n";

### Tabulate input_string into array table
### --------------------------------------
my @tmp = $input =~ /\d{9}/g;
my $r = 0;
foreach $x (@tmp)
{
	my $c = 0;
	foreach $y ( split(//, $x) )
	{
		$b[$r][$c] = $y;
		$c++;
	} # foreach
	$r++;
} # foreach
### --------------------------------------



my ($fixed, $unfixed) = grep_fixed_block();

my $x = 0;
while ( $x < @$unfixed )
{ 
	my ($r, $c) = split( //, $unfixed->[$x] );
	my $num = possible_number( $b[$r][$c] , $r, $c); 


	$b[$r][$c] = $num;
	if ($num==0) 
	{
		$x--;
		if ($x<0) 
		{
			print "\n\n";
			print "Unsolvable puzzle ..... you ";
			print "STUPID \@\$\$ !!!";
			print "\n\n";
			die();
		} #if
	}
	else
	{
		$x++;
	}

} #foreach

&print_answer;




#-------------------------------------------------------------------
sub print_answer
{
	print "\n\n";

	print "+----+-----+----+\n";

	for ($r=0; $r<9; $r++) 
	{
		for ($c=0; $c<9; $c++) 
		{
			# Left Boundary
			# -------------
			print "|" if ($c==0);

			if ( grep {$_ =~ /$r$c/} @$fixed ) 
			{
				print "$b[$r][$c]";
			}
			else
			{
				print "$b[$r][$c]";
			}

			# Spacing between (left/right) blocks
			# -----------------------------------
			if ($c%3==2   &&   $c!=8) 
			{
				print " | ";
			} #if

			# Right Boundary
			# --------------
			print "|" if ($c==8);

		} #for
		print "\n";

		# Spacing between (left/right) blocks
		# -----------------------------------
		if ($r%3==2   &&   $r!=8) 
		{
			print "+----+-----+----+";
			print "\n";
		} #if
	} #for
	print "+----+-----+----+";
	print "\n\n\n";
	print "Press <Enter> to close program.\n";
	<STDIN>;
}
#-------------------------------------------------------------------
# Solving
sub possible_number
{
	my ($num, $r, $c) = @_;
	$num=$num+1 if ($num==0);

	while ($num<10) 
	{
		if (! is_number_exist($num, $r, $c) )
		{
			return($num);
		} #if
		$num++;
	} #while
	return(0);
} #possible_number
#-------------------------------------------------------------------
sub is_number_exist
{
	my ($num, $r, $c) = @_;
	return(1) if ( is_number_exist_in_block(@_)   ||   is_number_exist_in_row(@_)   ||   is_number_exist_in_col(@_) );
	return(0);
} #is_number_exist
#-------------------------------------------------------------------
sub is_number_exist_in_block
{
	my ($num, $r, $c) = @_;

	my $starting_row = int($r/3) * 3;
	my $starting_col = int($c/3) * 3;

	for (my $row=$starting_row; $row<$starting_row+3; $row++) 
	{
		for (my $col=$starting_col; $col<$starting_col+3; $col++) 
		{
			return(1) if ( $num == $b[$row][$col] );
		}
	} #for
	return(0);
} #is_number_exist_in_block
#-------------------------------------------------------------------
sub is_number_exist_in_row
{
	my ($num, $row, $col) = @_;

	for ($col=0; $col<9; $col++) 
	{
		return(1) if ( $num == $b[$row][$col] );
	}
	return(0);
} #is_number_exist_in_row
#-------------------------------------------------------------------
sub is_number_exist_in_col
{
	my ($num, $row, $col) = @_;

	for ($row=0; $row<9; $row++) 
	{
		return(1) if ( $num == $b[$row][$col] );
	}
	return(0);
} #is_number_exist_in_col
#-------------------------------------------------------------------
sub grep_fixed_block
{	
	my @fixed = ();
	my @unfixed = ();

	for (my $r=0; $r<@b; $r++) 
	{
		for (my $c=0; $c<@{$b[$r]}; $c++) 
		{
			if ( $b[$r][$c]!=0 ) 
			{
				push(@fixed, "$r$c");
			}
			else
			{
				push(@unfixed, "$r$c");
			}
		} #for
	} #for
	return(\@fixed, \@unfixed);
}
#-------------------------------------------------------------------
sub usage
{
   print "\n\n";
   print "===================================\n";
   print "Example of a sudoku puzzle that looks like this:-\n";
  	print "(empty box are represented by zero)\n"; 
	print "-------------------------------------------------\n";
   print "300 005 010\n";
   print "070 006 030\n";
   print "100 090 000\n";
   print "\n";
   print "708 000 090\n";
   print "900 408 002\n";
   print "060 000 501\n";
   print "\n";
   print "000 040 006\n";
   print "040 700 020\n";
   print "020 600 003\n";
   print "\n\n";
   print "input_string should look like this:-\n";
   print "------------------------------------\n";
	print "300005010070006030100090000708000090900408002060000501000040006040700020020600003\n";
   print "===================================\n";
}
#-------------------------------------------------------------------
1;

