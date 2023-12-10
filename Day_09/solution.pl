#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'for_list';

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;

while (<>) {
    my @numbers  = split;
    my $sign     = 1;
    $solution_1 += $numbers [-1];
    $solution_2 += $numbers  [0] * $sign;
    while (grep {$_} @numbers) {
        @numbers     = map {$numbers [$_] - $numbers [$_ - 1]} 1 .. $#numbers;
        $solution_1 += $numbers [-1];
        $solution_2 += $numbers  [0] * ($sign *= -1);
    }
}


say "Solution 1: $solution_1";
say "Solution 2: $solution_2";


__END__
