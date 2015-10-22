# -*- perl -*-

# Test that our META.yml file matches the current specification.

use strict;
BEGIN {
  $|  = 1;
  $^W = 1;
}

my $MODULE = 'Test::CPAN::Meta 0.12';

# Don't run tests for installs
use Test::More;
use Config;
plan skip_all => 'This test is only run for the module author'
    unless -d '.git' || $ENV{AUTHOR_TESTING};
plan skip_all => 'Test::CPAN::Meta fails with clang -faddress-sanitizer'
    if $Config{ccflags} =~ /-faddress-sanitizer/;

# Load the testing module
eval "use $MODULE;";
if ( $@ ) {
  plan( skip_all => "$MODULE not available for testing" );
  die "Failed to load required release-testing module $MODULE 0.12"
    if -d '.git' || $ENV{AUTHOR_TESTING};
}
meta_yaml_ok();
