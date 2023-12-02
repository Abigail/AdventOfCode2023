#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';

@ARGV = "input" unless @ARGV;

my $MAX_RED    = 12;
my $MAX_GREEN  = 13;
my $MAX_BLUE   = 14;

use List::Util qw [max];

my $solution_1 = 0;
my $solution_2 = 0;

while (<>) {
    my ($game) = /([0-9]+)/;

    my  $max_red   = max (/([0-9]+)\s+red/g)   || 0;
    my  $max_green = max (/([0-9]+)\s+green/g) || 0;
    my  $max_blue  = max (/([0-9]+)\s+blue/g)  || 0;

    $solution_1 += $game if   $max_red   <= $MAX_RED   &&
                              $max_green <= $MAX_GREEN &&
                              $max_blue  <= $MAX_BLUE;
    $solution_2 += $max_red * $max_green * $max_blue;
}

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";
            

__END__
