#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;
my @cards;

while (<>) {
    (undef, my ($drawn, $card)) = split /[:|]/;
    my %drawn = map {$_ => 1}      $drawn =~ /[0-9]+/g;
    my $match = grep {$drawn {$_}} $card  =~ /[0-9]+/g;

    $solution_2 += my $instances = 1 + (shift (@cards) // 0);

    if ($match) {
        $solution_1 += 2 ** ($match - 1);
        $cards [$_] += $instances for 0 .. $match - 1;
    }
}


say "Solution 1: $solution_1";
say "Solution 2: $solution_2";
