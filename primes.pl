use strict;
use warnings;
use Time::HiRes qw/gettimeofday/;

sub isprime {
  my $n = shift;
  return 0 if $n <= 1;
  return 1 if $n <= 3;
  return 0 if $n % 2==0  or  $n % 3==0;
  my $c=5;
  while ($c * $c <= $n) {
    return 0 if ($n % $c==0 or $n % ($c+2)==0);
    $c = $c + 6;
  }
  return 1;
}

my $starttime=gettimeofday;
print "Perl\n";

my $s = 0;
$s += !!isprime($_) for 0..20000000;
print "Count = $s\n";
print gettimeofday-$starttime,"sec\t\t";
