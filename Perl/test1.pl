#!/usr/bin/perl -wl

use warnings;
#use strict;

my %doc = ('body',"My name is {name}.", 'name', 'James' );


my $render1 = "{doc.body} {doc.name}";


print "OUTPUT: " . parser($render1);



sub parser {
	$_ = shift; my $r;
			
		s/{(.+?)\.(.+?)}/\$$1\{$2\}/g;
		s/{([^.}]+)\.([^.}]+)}/{$1}->{$2}/g;
		
		
		$_ = eval(quote($_));
		
	return $_;	
}

sub quote { qq!"$_[0]"! }



