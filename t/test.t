#!perl

use Config;
use English '-no_match_vars';
use Test::More;
use Test::DZil;
use File::Temp;

my $perl = $EXECUTABLE_NAME;
if ( $OSNAME ne 'VMS' ) {
    $perl .= $Config{_exe} unless $perl =~ m/$Config{_exe}$/i;
}

my $dist_root = File::Temp->newdir();
my $tzil      = Builder->from_config(
    { dist_root => "$dist_root" },
    {   add_files => {
            'source/dist.ini' =>
                simple_ini( [ RequiresExternal => { requires => $perl } ] )
        }
    },
);
pass();
done_testing();
