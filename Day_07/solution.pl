#!/opt/perl/bin/perl

use 5.038;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'for_list';

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;

my $HIGH_CARD       = 0;
my $ONE_PAIR        = $HIGH_CARD       + 1;
my $TWO_PAIR        = $ONE_PAIR        + 1;
my $THREE_OF_A_KIND = $TWO_PAIR        + 1;
my $FULL_HOUSE      = $THREE_OF_A_KIND + 1;
my $FOUR_OF_A_KIND  = $FULL_HOUSE      + 1;
my $FIVE_OF_A_KIND  = $FOUR_OF_A_KIND  + 1;

#
# Classify the given hand. If the second parameter it true,
# treat Jacks as wild cards (jokers)
#
sub classify ($hand, $wild = 0) {
    my %cards;
    $cards {$_} ++ for split // => $hand;

    my $jokers = $wild && $cards {J} ? delete $cards {J} : 0;

    my @count = sort {$b <=> $a} values %cards;
    
    #
    # Add jokers to the cards appearing most frequently
    #
    $count [0] += $jokers;

    return $FIVE_OF_A_KIND  if $count [0] == 5;
    return $FOUR_OF_A_KIND  if $count [0] == 4;
    return $FULL_HOUSE      if $count [0] == 3 && $count [1] == 2;
    return $THREE_OF_A_KIND if $count [0] == 3 && $count [1] == 1;
    return $TWO_PAIR        if $count [0] == 2 && $count [1] == 2;
    return $ONE_PAIR        if $count [0] == 2 && $count [1] == 1;
    return $HIGH_CARD       if $count [0] == 1;
    die "Huh? ($hand)";
}

my %hands;

while (<>) {
    my ($hand, $bid) = split;
    #
    # Transfer hand into something that is easily sortable:
    #
    #   A -> E
    #   K -> D
    #   Q -> C
    #   J -> B (* for part 2, as * sorts before any digit or letter)
    #   T -> A
    #
    $hands {$hand} = [$bid, classify ($hand, 0), $hand =~ y/AKQJT/EDCBA/r,
                            classify ($hand, 1), $hand =~ y/AKQJT/EDC*A/r];
}

foreach my ($solution => $offset) ($solution_1 => 1, $solution_2 => 3) {
    my @hands = sort {$hands {$a} [$offset]     <=> $hands {$b} [$offset] ||
                      $hands {$a} [$offset + 1] cmp $hands {$b} [$offset + 1]}
                keys %hands;

    while (my ($index, $hand) = each @hands) {
        $solution += ($index + 1) * $hands {$hand} [0];
    }
}

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";


__END__
