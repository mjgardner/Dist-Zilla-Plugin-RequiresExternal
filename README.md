# NAME

Dist::Zilla::Plugin::RequiresExternal - make dists require external commands

# VERSION

version 1.009

# SYNOPSIS

In your `dist.ini`:

    [RequiresExternal]
    requires = /path/to/some/executable
    requires = executable_in_path

# DESCRIPTION

This [Dist::Zilla](https://metacpan.org/pod/Dist%3A%3AZilla) plugin creates a test
in your distribution to check for the existence of executable commands
you require.

# ATTRIBUTES

## requires

Each `requires` attribute should be either an absolute path to an
executable or the name of a command in the user's `PATH` environment.
Multiple `requires` lines are allowed.

Example from a `dist.ini` file:

    [RequiresExternal]
    requires = sqlplus
    requires = /usr/bin/java

This will require the program `sqlplus` to be available somewhere in
the user's `PATH` and the program `java` specifically in `/usr/bin`.

## fatal

Boolean value to determine if a failed test will immediately stop
testing. It also causes the test name to change to
`t/000-requires_external.t` so that it runs earlier.
Defaults to false.

# METHODS

## gather\_files

Adds a `t/requires_external.t` test script to your distribution that
checks if each ["requires"](#requires) item is executable.

## metadata

Using this plugin will add [Test::Most](https://metacpan.org/pod/Test%3A%3AMost)
and [Env::Path](https://metacpan.org/pod/Env%3A%3APath) to your distribution's
testing prerequisites since the generated script uses those modules.

# SEE ALSO

This module was indirectly inspired by
[Module::Install::External's requires\_external\_bin](https://metacpan.org/pod/Module%3A%3AInstall%3A%3AExternal#requires_external_bin)
command.

# SUPPORT

## Perldoc

You can find documentation for this module with the perldoc command.

    perldoc Dist::Zilla::Plugin::RequiresExternal

## Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

- CPANTS

    The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

    [http://cpants.cpanauthors.org/dist/Dist-Zilla-Plugin-RequiresExternal](http://cpants.cpanauthors.org/dist/Dist-Zilla-Plugin-RequiresExternal)

- CPAN Testers

    The CPAN Testers is a network of smoke testers who run automated tests on uploaded CPAN distributions.

    [http://www.cpantesters.org/distro/D/Dist-Zilla-Plugin-RequiresExternal](http://www.cpantesters.org/distro/D/Dist-Zilla-Plugin-RequiresExternal)

- CPAN Testers Matrix

    The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

    [http://matrix.cpantesters.org/?dist=Dist-Zilla-Plugin-RequiresExternal](http://matrix.cpantesters.org/?dist=Dist-Zilla-Plugin-RequiresExternal)

- CPAN Testers Dependencies

    The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

    [http://deps.cpantesters.org/?module=Dist::Zilla::Plugin::RequiresExternal](http://deps.cpantesters.org/?module=Dist::Zilla::Plugin::RequiresExternal)

## Bugs / Feature Requests

Please report any bugs or feature requests through the web
interface at [https://github.com/mjgardner/Dist-Zilla-Plugin-RequiresExternal/issues](https://github.com/mjgardner/Dist-Zilla-Plugin-RequiresExternal/issues). You will be automatically notified of any
progress on the request by the system.

## Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

[https://github.com/mjgardner/Dist-Zilla-Plugin-RequiresExternal](https://github.com/mjgardner/Dist-Zilla-Plugin-RequiresExternal)

    git clone git://github.com/mjgardner/Dist-Zilla-Plugin-RequiresExternal.git

# AUTHORS

- Mark Gardner <mjgardner@cpan.org>
- Joenio Costa <joenio@joenio.me>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by GSI Commerce and Joenio Costa.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
