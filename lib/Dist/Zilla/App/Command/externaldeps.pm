package Dist::Zilla::App::Command::externaldeps;
use strict;
use warnings;
use Dist::Zilla::App -command;

# ABSTRACT: print external libraries and binaries prerequisites

# VERSION

sub abstract { 'print external libraries and binaries prerequisites' }

sub opt_spec {}

sub execute {
    my ($self, $opt, $args) = @_;
    my $plugin = $self->zilla->plugin_named('RequiresExternal');
    local $" = "\n";
    print "@{ $plugin->_requires }\n";
}

1;

__END__

=pod

=head1 NAME

Dist::Zilla::App::Command::externaldeps - print external libraries and binaries prerequisites

=head1 VERSION

version 0.01

=head1 DESCRIPTION

This is a command plugin for L<Dist::Zilla>. It provides the C<externaldeps>
command, which prints external prerequisites declared with
L<Dist::Zilla::Plugin::RequiresExternal>.

=head1 AUTHOR

Joenio Costa <joenio@joenio.me>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Joenio Costa.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
