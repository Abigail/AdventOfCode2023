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

push @times     => join "" => @times;
push @distances => join "" => @distances;

sub distance ($pressed, $race_length) {
    ($race_length - $pressed) * $pressed;
}

foreach my $race (keys @times) {
    my $time     = $times     [$race];
    my $distance = $distances [$race];
    my $wins     = $time + 1;
    foreach my $t (0 .. $time) {
        $distance < distance ($t, $time) ? last : ($wins -= 2);
    }
    $solution_1 *= $wins if $race != $#times;
    $solution_2  = $wins if $race == $#times;
}

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";


__END__
