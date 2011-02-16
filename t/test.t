#!perl

use Config;
use English '-no_match_vars';
use Test::Most tests => 2;
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
lives_ok( sub { $tzil->run_tests_in( $tzil->built_in ) }, 'test' );
