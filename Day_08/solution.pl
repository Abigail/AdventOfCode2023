#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'for_list';

@ARGV = "input" unless @ARGV;

my $START  = 'AAA';
my $FINISH = 'ZZZ';

my $solution_1 = 0;
my $solution_2 = 0;

my @directions = <> =~ /[LR]/g; 
<>; # Blank line

my %map;
while (<>) {
   my ($input, $left, $right) = /[A-Z]{3}/g;
   $map {$input} {L} = $left;
   $map {$input} {R} = $right;
}

#
# Part 1
#
my $current = $START;
my $step    =  0;

while ($current ne $FINISH) {
    $current = $map {$current} {$directions [$step % @directions]};
    $step ++;
}
$solution_1 = $step;

#
# Part 2
#

my @start  =               grep {/A$/} keys %map;
my %finish = map {$_ => 1} grep {/Z$/} keys %map;
my @first;

foreach my $current (@start) {
    my $copy = $current;
    my $step = 0;
    while (!$finish {$copy}) {
        $copy = $map {$copy} {$directions [$step % @directions]};
        $step ++;
    }
    push @first => $step;
}

use Math::BigInt;

my $lcm = Math::BigInt:: -> new (shift @first);
   $lcm = $lcm -> blcm ($_) for @first;

$solution_2 = $lcm;

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";


__END__
