package Dist::Zilla::Plugin::RequiresExternal;

# ABSTRACT: make dists require external commands

use English '-no_match_vars';
use Moose;
use MooseX::Types::Moose qw(ArrayRef Str);
use MooseX::Has::Sugar;
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

=attr requires

Each C<requires> attribute should be either a full path to an executable or
the name of a command in the user's C<PATH> environment.

=cut

sub mvp_multivalue_args { return 'requires' }

has _requires => ( ro, lazy, auto_deref,
    isa => ArrayRef [Str],
    init_arg => 'requires',
    default  => sub { [] },
);

=method gather_files

Adds a F<t/requires_external.t> test script to the distribution that checks
if each L</requires> item is executable.
Required by
L<Dist::Zilla::Role::FileGatherer|Dist::Zilla::Role::FileGatherer>.

=cut

sub gather_files {
    my $self = shift;
    my @requires = part { file($ARG)->is_absolute() } $self->_requires;

    $self->add_file(
        Dist::Zilla::File::InMemory->new(
            name    => 't/requires_external.t',
            content => $self->fill_in_string(
                <<'END_TEMPLATE', { requires => \@requires } ) ) );
#!perl

use Env::Path 'PATH';
use Test::More tests => {{ @{ $requires[0] } + @{ $requires[1] } }};

ok(scalar PATH->Whence($_), "$_ in PATH") for qw( {{ "@{ $requires[0] }" }} );
ok(-x $_, "$_ is executable")             for qw( {{ "@{ $requires[1] }" }} );

END_TEMPLATE
    return;
}

=method metadata

Using this plugin will add the L<Env::Path|Env::Path> to your distribution's
testing prerequisites, since it uses that module to look for executables in
the user's C<PATH>.

=cut

sub metadata {
    return { prereqs => { test => { requires => { 'Env::Path' => '0' } } } };
}

__PACKAGE__->meta->make_immutable();
no Moose;
1;

=head1 DESCRIPTION

This L<Dist::Zilla|Dist::Zilla> plugin creates a test in your distribution
to check for the existence of executable commands you require.

=head1 SYNOPSIS

=for test_synopsis 1;

=for test_synopsis __END__

In your F<dist.ini>:

    [RequiresExternal]
    requires = /path/to/some/executable
    requires = executable_in_path
