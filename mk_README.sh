#!/bin/bash

(perldoc -tU ./lib/Sys/Proctitle.pm
 perldoc -tU $0
) >README

exit 0

=head1 INSTALLATION

 perl Makefile.PL
 make
 make test
 make install

=head1 DEPENDENCIES

=over 4

=item *

This module works only on linux.

=item *

Class::Member

=item *

perl 5.8.0

=back

=cut