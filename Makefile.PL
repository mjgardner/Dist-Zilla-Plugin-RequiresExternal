
use strict;
use warnings;

BEGIN { require 5.010; }

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'make dists require external commands',
  'AUTHOR' => 'Mark Gardner <mjgardner@cpan.org>',
  'BUILD_REQUIRES' => {
    'Carp' => '0',
    'Config' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Scalar::Util' => '0',
    'Test::DZil' => '0',
    'Test::More' => '0.94',
    'Test::Most' => '0',
    'perl' => '5.004'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'Dist-Zilla-Plugin-RequiresExternal',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla::Plugin::RequiresExternal',
  'PREREQ_PM' => {
    'Dist::Zilla::File::InMemory' => '0',
    'Dist::Zilla::Role::FileGatherer' => '0',
    'Dist::Zilla::Role::MetaProvider' => '0',
    'Dist::Zilla::Role::Plugin' => '0',
    'Dist::Zilla::Role::TextTemplate' => '0',
    'English' => '0',
    'Env::Path' => '0.18',
    'List::MoreUtils' => '0',
    'Modern::Perl' => '0',
    'Moose' => '0',
    'MooseX::Has::Sugar' => '0',
    'MooseX::Types::Moose' => '0',
    'Path::Class' => '0',
    'Test::Most' => '0',
    'namespace::autoclean' => '0',
    'utf8' => '0'
  },
  'VERSION' => '1.001',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



