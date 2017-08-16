package Dist::Zilla::Plugin::RequiresExternal;

# ABSTRACT: make dists require external commands

use Modern::Perl '2010';    ## no critic (Modules::ProhibitUseQuotedVersion)

# VERSION
use utf8;

=for test_synopsis
BEGIN { die "SKIP: this is ini, not perl\n" }

=head1 SYNOPSIS

In your F<dist.ini>:

    [RequiresExternal]
    requires = /path/to/some/executable
    requires = executable_in_path

=head1 DESCRIPTION

This L<Dist::Zilla|Dist::Zilla> plugin creates a test in your distribution
to check for the existence of executable commands you require.

=head1 SEE ALSO

This module was indirectly inspired by
L<Module::Install::External's requires_external_bin|Module::Install::External/requires_external_bin>
command.

=cut

use Moose;
use MooseX::Types::Moose qw(ArrayRef Bool Maybe Str);
use MooseX::AttributeShortcuts;
use Dist::Zilla::File::InMemory;
use List::MoreUtils 'part';
use Path::Class;
use namespace::autoclean;
with qw(
    Dist::Zilla::Role::Plugin
    Dist::Zilla::Role::FileGatherer
    Dist::Zilla::Role::MetaProvider
    Dist::Zilla::Role::TextTemplate
);

=for Pod::Coverage mvp_multivalue_args

=cut

sub mvp_multivalue_args { return 'requires' }

=attr requires

Each C<requires> attribute should be either an absolute path to an executable
or the name of a command in the user's C<PATH> environment.  Multiple
C<requires> lines are allowed.

Example from a F<dist.ini> file:

    [RequiresExternal]
    requires = sqlplus
    requires = /usr/bin/java

This will require the program C<sqlplus> to be available somewhere in the
user's C<PATH> and the program C<java> specifically in F</usr/bin>.

=cut

has _requires => (
    is       => 'lazy',
    isa      => Maybe [ ArrayRef [Str] ],
    init_arg => 'requires',
    default => sub { [] },
);

=attr fatal

Boolean value to determine if a failed test will immediately stop testing.
It also causes the test name to change to F<t/000-requires_external.t> so that
it runs earlier.
Defaults to false.

=cut

has fatal => ( is => 'ro', required => 1, isa => Maybe [Bool], default => 0 );

=method gather_files

Adds a F<t/requires_external.t> test script to your distribution that checks
if each L</requires> item is executable.

=cut

sub gather_files {
    my $self = shift;

    # @{$requires[0]} will contain any non-absolute paths to look for in $PATH
    # @{$requires[1]} will contain any absolute paths
    my @requires = part { file($_)->is_absolute() } @{ $self->_requires };
    my $template = <<'END_TEMPLATE';
#!/usr/bin/env perl

use Test::Most;
plan tests => {{
    $OUT = 0;
    $OUT += @{ $requires[0] } if defined $requires[0];
    $OUT += @{ $requires[1] } if defined $requires[1];
}};
bail_on_fail if {{ $fatal }};
use Env::Path 0.18 'PATH';

{{ "ok(scalar PATH->Whence(\$_), \"\$_ in PATH\") for qw(@{ $requires[0] });"
        if defined $requires[0]; }}
{{ "ok(-x \$_, \"\$_ is executable\") for qw(@{ $requires[1] });"
        if defined $requires[1]; }}
END_TEMPLATE

    $self->add_file(
        Dist::Zilla::File::InMemory->new(
            name => (
                $self->fatal
                ? 't/000-requires_external.t'
                : 't/requires_external.t',
            ),
            content => $self->fill_in_string(
                $template, { fatal => $self->fatal, requires => \@requires },
            ),
        ),
    );
    return;
}

=method metadata

Using this plugin will add L<Test::Most|Test::Most> and L<Env::Path|Env::Path>
to your distribution's testing prerequisites since the generated script uses
those modules.

=cut

sub metadata {
    return {
        prereqs => {
            test => {
                requires => { 'Test::Most' => '0', 'Env::Path' => '0.18' },
            },
        },
    };
}

__PACKAGE__->meta->make_immutable();
no Moose;
1;

