# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Sys-Proctitle.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

sub cmdline {
  open my $f, "/proc/$$/cmdline";
  local $/;
  my $rc=<$f>;
  $rc=~s/\0+$//;
  $rc=~s/\0/ /g;
  print "# /proc/$$/cmdline='$rc'\n";
  return $rc;
}

use Test::More tests => 9;
BEGIN { use_ok('Sys::Proctitle') };

my $orig=cmdline;

Sys::Proctitle::setproctitle("klaus\0otto");
ok cmdline eq 'klaus otto', 'set';

Sys::Proctitle::setproctitle;
ok cmdline eq $orig, 'unset';

Sys::Proctitle::setproctitle("klaus", "otto");
ok cmdline eq 'klaus otto', 'list';

my $rc=Sys::Proctitle::getproctitle;
my $xrc=$rc; $xrc=~s/\0/!/g;
print "# rc='$xrc' (\\0 was replaced by !)\n";
ok $rc=~/klaus\0otto\0+$/, 'get';

Sys::Proctitle::setproctitle;
ok cmdline eq $orig, 'unset again';

Sys::Proctitle::setproctitle($rc);
ok cmdline eq 'klaus otto', 'value got via getproctitle() restored';

{
  my $proctitle=Sys::Proctitle->new( qw/object interface/ );
  ok cmdline eq 'object interface', 'object interface';
}

ok cmdline eq 'klaus otto', 'object destroyed';

## Local Variables: ##
## mode: cperl ##
## End: ##
