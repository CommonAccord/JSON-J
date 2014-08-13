#!/usr/bin/perl -wl

use warnings;
use strict;

my %usa = ('nation', 'United States of America');

my %cali = (%usa, 'state', 'California', 'Addr2', '{redw.state} {redw.nation}');

my %redw = (%cali, 'city', 'Redwood City', 'county', 'San Mateo', 'zip', 94063);



print "$_ = ". $redw{$_} for keys %redw;

my $render = "I live in {redw.city} which is in {redw.state}, {redw.nation} {redw.Addr2}";

sub parser {
	$_ = shift;
	s/{(.+?)\.(.+?)}/\$$1\{$2\}/g;
	return $_;	
}

sub quote { qq!"$_[0]"! }

my $parsing = parser($render); my $temp = quote($parsing); print "INPUT = $temp";

my $test = eval($temp); print "OUTPUT: $test";



