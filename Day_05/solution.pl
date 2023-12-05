#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';
use experimental 'for_list';

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;
use List::Util qw [min max];

$/ = ""; # Process input one paragraph at a time.

my @rulesets;

#
# Read in the seeds, extract the values.
#
my @seeds = <> =~ /\d+/ga;

#
# Read in each of the mappings, which we call rulesets. We can
# ignore what they're mapping. We also don't care how many of
# them there are.
#
# Note that we do an immediate transformation: instead of how many
# items there are in a range, we store the begin and end of a range.
# And end points are always stored as the first number *exceeding*
# the endpoint.
#
while (<>) {
    push @rulesets => [];
    while (/(\d+)\s+(\d+)\s+(\d+)/ga) {
        push @{$rulesets [-1]} => [$1, $2, $2 + $3];
    }
}

#
# Divide into ranges. For part 1, the ranges will be just one seed
# long; For part 2, we use the ranges as given.
#
# For each range, we use a tuple (S, E), where S is the first seed
# in the range, and E is the first seed *after* the range.
#
my ($seeds1, $seeds2);
foreach my ($start, $end) (@seeds) {
    push @$seeds1 => [$start, $start + 1], [$end, $end + 1];
    push @$seeds2 => [$start, $start + $end + 1];
}

#
# Given a range, and a rule, return three ranges:
#   - The part of the range before the section the rule applies to
#   - The part of the range which overlaps the rule
#   - The part of the range after the section the rule applies to
#
# Each of the parts my be empty, but the three returned ranges combined
# give the input range, without overlap or gaps.
#
sub partition ($range, $rule) {
    my ($range_start, $range_end)  = @$range;
    my ($rule_start,  $rule_end)   = @$rule [1, 2];

    my ($before, $overlap, $after) = ([], [], []);

    if ($range_start < $rule_start) {
        $before = [$range_start, min ($range_end, $rule_start)];
    }

    if ($range_start < $rule_end && $range_end   > $rule_start) {
        $overlap = [max ($range_start, $rule_start),
                    min ($range_end,   $rule_end)];
    }

    if ($range_end > $rule_end) {
        $after = [max ($range_start, $rule_end), $range_end];
    }

    ($before, $overlap, $after);
}


foreach my ($solution, $seed_set) ($solution_1, $seeds1,
                                   $solution_2, $seeds2) {
    foreach my $ruleset (@rulesets) {
        my $for_next_set = [];
        foreach my $rule (@$ruleset) {
            my $for_next_rule = [];
            for my $current_range (@$seed_set) {
                #
                # Split the current range in three parts, each
                # possibly empty:
                #   * A range before $src_start
                #   * A range overlapping the range of the rule
                #   * A range past $scr_start + 
                #
                # The first and latter ranges, we retain for
                # the other rules to modify (push onto $for_next_rule),
                # the range which overlaps, we calculate their new
                # values, and push them onto $for_next_set
                #
                my ($before, $overlap, $after) = 
                     partition $current_range, $rule;

                push @$for_next_rule => $before if @$before;
                push @$for_next_rule => $after  if @$after;

                #
                # Apply the rule to the overlapping range
                #
                my $processed = [];
                if (@$overlap) {
                    @$processed = map {$_ + $$rule [0] - $$rule [1]} @$overlap;
                    push @$for_next_set => $processed;
                }
            }
            $seed_set = $for_next_rule;
        }
        push @$seed_set => @$for_next_set;
    }
    $solution = min map {$$_ [0]} @$seed_set;
}


say "Solution 1: $solution_1";
say "Solution 2: $solution_2";


__END__
