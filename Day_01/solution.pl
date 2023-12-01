#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;

my @words      = qw [one two three four five six seven eight nine];
my %value      = do {my $i = 0; map {$_ => ++ $i} @words};
   $value {$_} = $_ for 0 .. 9;

while (<>) {
    local $" = "|";
    my ($first_digit) = /   ([0-9])         /x;
    my ($last_digit)  = /.* ([0-9])         /x;
    my ($first_word)  = /   ([0-9] | @words)/x;
    my ($last_word)   = /.* ([0-9] | @words)/x;
    $solution_1      += 10 *         $first_digit +         $last_digit;
    $solution_2      += 10 * $value {$first_word} + $value {$last_word};
}

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";


__END__
