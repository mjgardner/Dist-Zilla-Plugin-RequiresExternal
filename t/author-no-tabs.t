
BEGIN {
    unless ( $ENV{AUTHOR_TESTING} ) {
        require Test::More;
        Test::More::plan(
            skip_all => 'these tests are for testing by the author' );
    }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Dist/Zilla/Plugin/RequiresExternal.pm',
    't/00-compile.t',
    't/000-report-versions.t',
    't/author-critic.t',
    't/author-eol.t',
    't/author-no-tabs.t',
    't/fatal.t',
    't/release-changes_has_content.t',
    't/release-cpan-changes.t',
    't/release-dist-manifest.t',
    't/release-distmeta.t',
    't/release-kwalitee.t',
    't/release-localbrew-perl-5.10.1-TEST.t',
    't/release-localbrew-perl-5.16.3-TEST.t',
    't/release-localbrew-perl-5.18.4-TEST.t',
    't/release-localbrew-perl-5.20.2-TEST.t',
    't/release-localbrew-perl-5.22.0-TEST.t',
    't/release-localbrew-perl-latest-TEST.t',
    't/release-meta-json.t',
    't/release-minimum-version.t',
    't/release-mojibake.t',
    't/release-pod-coverage.t',
    't/release-pod-linkcheck.t',
    't/release-pod-syntax.t',
    't/release-portability.t',
    't/release-synopsis.t',
    't/release-system-localbrew.t',
    't/release-test-version.t',
    't/release-unused-vars.t',
    't/test.t'
);

notabs_ok($_) foreach @files;
done_testing;
