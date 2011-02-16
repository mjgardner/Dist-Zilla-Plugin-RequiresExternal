package Dist::Zilla::Plugin::RequiresExternal;

# ABSTRACT: make dists require external commands

use Moose;
use MooseX::Types::Moose qw(ArrayRef Str);
use MooseX::Has::Sugar;
use Dist::Zilla::File::InMemory;
use namespace::autoclean;
with qw(
    Dist::Zilla::Role::Plugin
    Dist::Zilla::Role::FileGatherer
    Dist::Zilla::Role::TextTemplate
);

=begin Pod::Coverage

    mvp_multivalue_args

=end Pod::Coverage

=cut

sub mvp_multivalue_args { return 'requires' }

=attr requires

Each C<requires> attribute should be either a full path to an executable or
the name of a command in the user's C<PATH> environment.

=cut

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
    $self->add_file(
        Dist::Zilla::File::InMemory->new(
            name    => 't/requires_external.t',
            content => $self->fill_in_string(
                <<'END_TEMPLATE', { requires => [ $self->_requires ] } ) ) );
#!perl
use Test::More tests => {{ scalar @requires }};
ok(-x $_, "$_ is executable") for qw( {{ "@requires" }} );
END_TEMPLATE
    return;
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
