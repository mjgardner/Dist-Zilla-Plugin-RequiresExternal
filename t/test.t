#!perl
#
# This file is part of Dist-Zilla-Plugin-RequiresExternal
#
# This software is copyright (c) 2011 by GSI Commerce.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use utf8;
use Modern::Perl;    ## no critic (UselessNoCritic,RequireExplicitPackage)

use Config;
use English '-no_match_vars';
use Test::Most tests => 3;
use Test::DZil;

my $perl = $EXECUTABLE_NAME;
if ( $OSNAME ne 'VMS' ) {
    $perl .= $Config{_exe} unless $perl =~ m/$Config{_exe}$/i;
}
my $tzil = Builder->from_config(
    { dist_root => 1 },
    {   add_files => {
            'source/dist.ini' => simple_ini(
                ['@Basic'],
                [ RequiresExternal => { requires => [ $perl, 'perl' ] } ],
            ),
            'source/lib/DZT/Sample.pm' => <<'END_SAMPLE_PM',
package DZT::Sample;
# ABSTRACT: Sample package
1;
END_SAMPLE_PM
        },
    },
);

lives_ok( sub { $tzil->build() }, 'build' );
ok( ( grep { $ARG->name eq 't/requires_external.t' } @{ $tzil->files } ),
    'test script added' );
lives_ok( sub { $tzil->run_tests_in( $tzil->built_in ) }, 'test' );
