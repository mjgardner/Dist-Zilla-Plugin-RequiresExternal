package Dist::Zilla::App::Command::externaldeps; ## no critic (Capitalization)

# ABSTRACT: print external libraries and binaries prerequisites

use Modern::Perl '2010';    ## no critic (Modules::ProhibitUseQuotedVersion)

# VERSION
use utf8;

=for test_synopsis
BEGIN { die "SKIP: this is command line, not perl\n" }

=head1 SYNOPSIS

On the command line:

    % dzil externaldeps
    man
    sqlite3

=head1 DESCRIPTION

This is a command plugin for L<Dist::Zilla|Dist::Zilla>. It provides the
C<externaldeps> command, which prints external prerequisites declared
with
L<Dist::Zilla::Plugin::RequiresExternal|Dist::Zilla::Plugin::RequiresExternal>.

=cut

use Dist::Zilla::App -command;    ## no critic (ProhibitCallsToUndeclaredSubs)
use English '-no_match_vars';

sub opt_spec { }

sub execute {
    my $self   = shift;
    my $plugin = $self->zilla->plugin_named('RequiresExternal');
    local $LIST_SEPARATOR = "\n";
    say "@{ $plugin->_requires }";
    return;
}

## no critic (NamingConventions::ProhibitAmbiguousNames)
sub abstract { return 'print external libraries and binaries prerequisites' }

1;
