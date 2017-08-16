#!/usr/bin/env perl

use lib 'lib';
use Modern::Perl '2010';    ## no critic (Modules::ProhibitUseQuotedVersion)
use Test::More 'no_plan';

my $OUT = `cd t/eg && dzil externaldeps`;

like( $OUT, qr/man/,     'man is an external prerequisite' );
like( $OUT, qr/sqlite3/, 'sqlite is an external prerequisite' );
unlike( $OUT, qr/mysql/, 'mysql isnt an external prerequisite' );
