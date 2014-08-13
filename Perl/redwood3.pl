#!/usr/bin/perl -wl

use warnings;
#use strict;


my %human = ('head', 1, 'hands', 2, 'legs', 2);

my %man = (%human, 'legs', 3);
my %woman = (%human, 'legs', 1);

%jim = (%man, 'name', "Jim Hazzard", 'friend', \%ya);
%ya = (%woman, 'name', "Primavera", 'friend', \%jim);


my $render1 = "my name is {jim.name}, I have {jim.hands} hands,  {jim.legs} legs. My best friend is {jim.friend.name}";
my $render2 = "my name is {ya.name}, I have {ya.hands} hands,  {ya.legs} legs. My best friend is {ya.friend.name}";


print "OUTPUT: " . parser($render1);
print "OUTPUT: " . parser($render2);





sub parser {
	$_ = shift; my $r;
#	while( s/{(.+?)\.(.+?)}/ref($1)?\$$1\{$2\}:\$$1->\{$2\}/eg ) {
#	while( s/{(.+?)\.(.+?)}/ref(${$1}{$2})?"AA":"BB"/eg ) {
			
		s/{(.+?)\.(.+?)}/\$$1\{$2\}/g;
		s/{([^.}]+)\.([^.}]+)}/{$1}->{$2}/g;
		
		
		$_ = eval(quote($_));
		
	return $_;	
}

sub quote { qq!"$_[0]"! }



