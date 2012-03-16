#!/usr/bin/env perl -w
 
use strict;
use warnings;

#modules
use Test::More 'no_plan';
#add local lib to path
use FindBin;
use lib "$FindBin::Bin/../lib";

my $CLASS;
BEGIN {
    $CLASS = 'DBIx::Retry';
    use_ok $CLASS or die;
}
 
# check the basics - copy straight from DBIx::Connector test
ok my $conn = $CLASS->new, "New object OK";
isa_ok $conn, $CLASS, "New object isa $CLASS";
