#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'for_list';

@ARGV = "input" unless @ARGV;

my $solution_1 = 1;
my $solution_2 = 0;

my @times     = <> =~ /\d+/ga;
my @distances = <> =~ /\d+/ga;

sub distance ($pressed, $race_length) {
    ($race_length - $pressed) * $pressed;
}

foreach my $race (keys @times) {
    my $time     = $times     [$race];
    my $distance = $distances [$race];
    my $wins     = 0;
    foreach my $t (0 .. $time) {
        $wins ++ if $distance < distance $t, $time;
    }
    $solution_1 *= $wins;
}

my $big_time     = join "" => @times;
my $big_distance = join "" => @distances;

my $losses;
for my $t (0 .. $big_time) {
    $big_distance < distance ($t, $big_time) ? last : $losses ++;
}

$solution_2 = $big_time + 1 - 2 * $losses;

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";


__END__
