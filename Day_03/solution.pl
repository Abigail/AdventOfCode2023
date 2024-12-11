#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';

use feature 'multidimensional';
use experimental 'for_list';

@ARGV = "input" unless @ARGV;

#
# Fetch the input
#
my $map = [map {[/./g, "."]} <>];
push @$map => [(".") x @{$$map [0]}];
my $X = @$map - 1;
my $Y = @{$$map [0]} - 1;

my $solution_1 = 0;
my $solution_2 = 0;

my %gears;

#
# Determine whether a number on the given start coordinates
# is adjacent to a symbol. If it's adjacent to a gear, record
# the position of the $gear, the starting positions of the numbers,
# and the numbers itself.
#
sub adjacent ($map, $x, $y, $number) {
    #
    # First find the coordinates we need to inspect
    #
    my $len = length ($number);
    my @checks = ([$x, $y - 1], [$x, $y + $len]);
    for my $xp ($x - 1, $x + 1) {
        for (my $yp = $y - 1; $yp <= $y + $len; $yp ++) {
            push @checks => [$xp, $yp];
        }
    }
    foreach my $point (@checks) {
        if ($$map [$$point [0]] [$$point [1]] eq '*') {
            $gears {$$point [0], $$point [1]} {$x, $y} = $number;
        }
    }
    return grep {$$map [$$_ [0]] [$$_ [1]] ne '.'} @checks;
}


#
# Iterate over the map. If we find a number, check if it's adjacent to a symbol.
# If it is, add it to $solution_1.
#
for (my $x = 0; $x < $X; $x ++) {
    my $number  = 0;
    my $start_y = 0;
    for (my $y = 0; $y < $Y + 1; $y ++) {
        if ($$map [$x] [$y] =~ /[0-9]/) {
            $start_y = $y unless $number;
            $number *= 10;
            $number += $$map [$x] [$y];
        }
        elsif ($number) {
            $solution_1 += $number if adjacent ($map, $x, $start_y, $number);
            $number = 0;
        }
    }
}

#
# Find all the gears adjacent to exactly two numbers, and calculate the score.
#
foreach my $gear (keys %gears) {
    my @numbers = values %{$gears {$gear}};
    $solution_2 += $numbers [0] * $numbers [1] if @numbers == 2;
}

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";


__END__
