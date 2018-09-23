#!C:\Strawberry\perl\bin
#se strict; 

my ($i, $j, $k, $count, $ii, $jj );
my @array_one = ("4", "9");
my @array_two = ("7", "9");
my @array_three = ("4", "9");

my $array_one = @array_one;
my $array_two = @array_two;
my $array_three = @array_three;
my @array_temp;




for($i=0;$i<$array_one;$i++){
	for($j=0;$j<$array_two;$j++){
		for($k=0;$k<$array_three;$k++){
#printf("i:%s j:%s k:%s\n", $i,$j,$k);


if((@array_one[$i] eq @array_two[$j]) || (@array_two[$j] eq @array_three[$k]) || (@array_one[$i] eq @array_three[$k]) ){next;}
else{
printf("%s %s %s\n", @array_one[$i],@array_two[$j],@array_three[$k] );
push(@array_temp,  [@array_one[$i],@array_two[$j],@array_three[$k]]);






$count++;
}			
}
}
}
printf("count:%s\n", $count);
printf("dk: %s\n", $array_temp[1][2]);



for($ii=0;$ii<3;$ii++){
   if($array_temp[0][$ii] eq $array_temp[1][$ii]){
   	printf("hit \n");
   	print "this: ";
   	print $array_temp[1][$ii]; print "\n";
   }	
	
}

