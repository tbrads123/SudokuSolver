#!C:\Strawberry\perl\bin
use strict; 


use constant GRIDSIZE => 81; #something wrong here??
my ($daddy_y,@AoA,$username, $cFlag, $tCount,$cCount, $CherryFlag,$hard_val_return,$x,$allowed_return,$count,$backing_up,@temp_array);




#+++++++++++++++++++++++++++++++++++++
#              main                  +
#+++++++++++++++++++++++++++++++++++++
#!! $daddy_y is global.. watch out !!!
open_game_file_populate_working_array();
populate_hard_vals();
print_grid();

#promptUser();

#******pick cherries*********************#
$CherryFlag=1;
while($CherryFlag eq 1){
  #promptUser();
  $daddy_y = 0; 
  &cherry_pick();
}
printf("found %s cherries. Press Enter to Continue.\n", $cCount);
print_grid();
promptUser();

#******* done picking cherries **********#





#**** start logic picker ****************#
#create array of temp arrays##############

my $rr=0; 
my $hardValReturn;
my @ArrayofTempArrays;
$daddy_y=0;
while($rr < 81){
   &allowed($daddy_y++);
   $rr++;
   push @ArrayofTempArrays, [@temp_array];
}
##############################################
# finds values allowed for row give at command line
# change value by ARGV line to change row,col,box
##############################################

$rr=0;
my $uu = 0;
print "========================================================\n";
printf("checking box: %s %s\n", $ARGV[0]);
while($rr < GRIDSIZE){
   if(&hard_val($rr)){$rr++; next;}     
   (my $rrrow, my $cccol, my $bbbox) = split(//,$AoA[$rr][0]);
     
    if($bbbox eq $ARGV[0]){      
      printf("box %s  ", $bbbox);
      for(my $ii=0;$ii<11;$ii++){
         #printf("in for loop\n");
         print $ArrayofTempArrays[$rr][$ii];  
}
print "\n"; 
}
$rr++;
}
promptUser();


#########################
#play

# my $gencount;
# #my $gen = make_generator([$ArrayofTempArrays[$rr][$ii]], [$ArrayofTempArrays[$rr][$ii]], [$ArrayofTempArrays[$rr][$ii]], [$ArrayofTempArrays[$rr][$ii]],[$ArrayofTempArrays[$rr][$ii]]);
# my $gen = make_generator([qw/4 9/],[qw/1 2/],[qw/1 7/],[qw/1 4 8 9/],[qw/4 9/],[qw/1 4 8 9/] );
# 
# while ($_ = $gen->()) {
  # #print join(", ", @$_), "\n";
  # print @$_; print "\n";
  # $gencount++;
 # # push(@ee, @$_);
# }
#printf("gencount:%s\n", $gencount);
#printf("array of temps [0][8]: %s\n", $ArrayofTempArrays[1][0]);

printf("AoA[0][2]: %s\n", $AoA[0][2]); 

#+++++++++++++++++++++++++++++++++++++
#         sub routines               +
#+++++++++++++++++++++++++++++++++++++
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
#------------------------------------#                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ``````````````````````````````````````````````````````````````````

sub cherry_pick{

$CherryFlag=0;
while($daddy_y < GRIDSIZE){
   if(&hard_val($daddy_y)){
#      printf("%s hard value\n",$daddy_y);
      $daddy_y++;
      next;
   }
   &allowed($daddy_y);

   # go over temp_array, if temp_array has only one value, then that is the only value legal
   # for that cell. Make that cell equal to that value and mark as hard val and proceed. 
   my $fflag = 0;
   my $aa = 0;
   my $bb = 0;
   for($aa=0;$aa lt 9;$aa++){
       if (($temp_array[$aa]) gt 0){
         $fflag++;
         $bb = $temp_array[$aa];
       }
   }
   if($fflag eq 1){
      $CherryFlag=1;
      #printf("fflag:%s\n", $fflag);
#      printf("Found a Cherry! ");
      $AoA[$daddy_y][1] = $bb;
      $AoA[$daddy_y][2] = 99;
#      printf("cell:%s value:%s\n", $daddy_y, $bb);
      $cCount++;
}    
#   printf("%s ",$daddy_y);
#   print @temp_array; print "\n";
    $daddy_y++;
}   
return 1;
}  


#------------------------------------#     

sub allowed{
my ($i,$j,$row,$col,$box,$crow,$ccol,$cbox,$flag);

# $_[0] is the value based to the function, in this case, $daddy_y 

@temp_array =(1...9);
($row, $col, $box) = split(//,$AoA[$_[0]][0] );


for($i=0;$i<GRIDSIZE;$i++){
   ($crow, $ccol, $cbox) = split(//,$AoA[$i][0]);
   if(($row eq $crow) or ($col eq $ccol) or ($box eq $cbox)){
      if($AoA[$i][1]>0){ 
         $temp_array[($AoA[$i][1])-1] = 0;
      }   
   } 
}
# $flag=0;
# for($j=0;$j<9;$j++){if($temp_array[$j] eq $x){$flag=1;}}
  # #printf("cell:%s   ", $daddy_y);
  # #print @temp_array; print "\n";
  # return $flag;
}   

#------------------------------------#

sub hard_val{
my $return;
   if(($AoA[$_[0]][2]) == 99){
      $return = 1;
   }
   else{
      $return = 0;
   }
   return $return; 
}



#------------------------------------#
sub print_grid{
my $i=0, my $k=1;
while($k<GRIDSIZE+1){
   if( $AoA[$i][1] > 0)
      {print " $AoA[$i][1]";}
   else
      {print " .";}
   if (($k % 3 eq 0) and ($k % 9 ne 0))
      {print " |";}
   if (($k % 9) eq 0)
      {print "\n";}
   $k++;
   $i++;   
}
print "+++++++++++++++++++++++++++++++++++++\n\n";
}

#------------------------------------#
sub populate_hard_vals{
my $q=0;   
   for($q=0;$q<82;$q++){
      if($AoA[$q][1] > 0){
         $AoA[$q][2] = 99;
      }
   } 
}

#------------------------------------#

sub open_game_file_populate_working_array{
  open(INFILE, "C:\\Documents and Settings\\tbradshaw\\Desktop\\SPROJ\\game69.txt") or die("Unable to open file");
  while (<INFILE>) {
      if ($_ =~ /#/) {
        next;
    }
     push @AoA, [ split ];
     
     }  
} 

#----------------------------(  promptUser  )-----------------------------#
#                                                                         #
#  FUNCTION:	promptUser                                                #
#                                                                         #
#  PURPOSE:	Prompt the user for some type of input, and return the    #
#		input back to the calling program.                        #
#                                                                         #
#  ARGS:	$promptString - what you want to prompt the user with     #
#		$defaultValue - (optional) a default value for the prompt #
#                                                                         #
#-------------------------------------------------------------------------#

sub promptUser {
my $promptString;
my $defaultValue;


   #-------------------------------------------------------------------#
   #  two possible input arguments - $promptString, and $defaultValue  #
   #  make the input arguments local variables.                        #
   #-------------------------------------------------------------------#

   #local($promptString,$defaultValue) = @_;
   $promptString,$defaultValue = @_;

   #-------------------------------------------------------------------#
   #  if there is a default value, use the first print statement; if   #
   #  no default is provided, print the second string.                 #
   #-------------------------------------------------------------------#

   if ($defaultValue) {
      print $promptString, "[", $defaultValue, "]: ";
   } else {
      print $promptString, ": ";
   }

   $| = 1;               # force a flush after our print
   $_ = <STDIN>;         # get the input from STDIN (presumably the keyboard)


   #------------------------------------------------------------------#
   # remove the newline character from the end of the input the user  #
   # gave us.                                                         #
   #------------------------------------------------------------------#

   chomp;

   #-----------------------------------------------------------------#
   #  if we had a $default value, and the user gave us input, then   #
   #  return the input; if we had a default, and they gave us no     #
   #  no input, return the $defaultValue.                            #
   #                                                                 # 
   #  if we did not have a default value, then just return whatever  #
   #  the user gave us.  if they just hit the <enter> key,           #
   #  the calling routine will have to deal with that.               #
   #-----------------------------------------------------------------#

   if ("$defaultValue") {
      return $_ ? $_ : $defaultValue;    # return $_ if it has a value
   } else {
      return $_;
   }
}



# A brute force algorithm visits the empty cells in some order, filling in digits sequentially from the 
# available choices, or backtracking (removing failed choices) when stymied. For the purposes of this exposition, 
# a naive iteration order of left to right, top to bottom is assumed. The iteration could, however, 
# visit the empty cells in any order, the order can even be randomized for each solution attempt with no harm to 
# the algorithm. Randomized algorithms are less vulnerable to worst case inputs, but don't have consistent running 
# times when solving the same problem repeatedly.
# 
# Briefly, a brute force program would solve a puzzle by placing the digit "1" in the first cell and checking if it 
# is allowed to be there. If there are no violations (checking row, column, and box constraints) then the algorithm 
# advances to the next cell, and places a "1" in that cell. When checking for violations, it is discovered that the 
# "1" is not allowed, so the value is advanced to a "2". If a cell is discovered where none of the 9 digits is allowed, 
# then the algorithm leaves that cell blank and moves back to the previous cell. The value in that cell is then 
# incremented by one. The algorithm is repeated until the allowed value in the 81st cell is discovered. 
# The construction of 81 numbers is parsed to form the 9 x 9 solution matrix.