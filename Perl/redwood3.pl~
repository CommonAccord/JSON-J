#!/usr/bin/perl -wl

use warnings;
#use strict;

do 'being.cmacc';


my %human = (%being, 'head', 1, 'hands', 2, 'legs', 2);

my %man = (%human, 'legs', 3);
my %woman = (%human, 'legs', 1);

%jim = (%man, 'name', "Jim Hazzard", 'friend', \%ya);
%ya = (%woman, 'name', "Primavera", 'friend', \%jim);


my $render1 = "My name is {jim.name}, I have {jim.hands} hands,  {jim.legs} legs. My best friend is {jim.friend.name}. I am {jim.state}";
my $render2 = "My name is {ya.name}, I have {ya.hands} hands,  {ya.legs} legs. My best friend is {ya.friend.name}.";


print "OUTPUT: " . parser($render1);
print "OUTPUT: " . parser($render2);





sub parser {
	$_ = shift; my $r;
			
		s/{(.+?)\.(.+?)}/\$$1\{$2\}/g;
		s/{([^.}]+)\.([^.}]+)}/{$1}->{$2}/g;
		
		
		$_ = eval(quote($_));
		
	return $_;	
}

sub quote { qq!"$_[0]"! }



