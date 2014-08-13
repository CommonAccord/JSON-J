#!/usr/bin/perl -wl

use warnings;
#use strict;

# this does not work.  The reason seems to be the use of a period in a key name.  This will prevent overriding.


do 'being.cmacc';


%doc = ("doc.body" => "My name is {name}, {being.state}.");

my %start = (%doc , 'name', 'James' );


my $render1 = "{start.doc.body}";


print "OUTPUT: " . parser($render1);



sub parser {
	$_ = shift; 
	
	#	while( ($r) = $_ =~  /{([^.}]+)/ ) {		
	#		s/{(.+?)\.(.+?)}/\$$1\{$2\}/g;
	#		s/{([^.}]+)\.([^.}]+)}/{$1}->{$2}/g;
	#		s/{([^}]+)}/\${$r}{$1}/g;
	#		$_ = eval(quote($_));
	#	}
	
	
	print $_;
	
	my $old;

		while( my($struct) = $_ =~ /{([^}]+)}/) {

			if(! ($struct =~ /([^.]+)\./) ) {
				$struct = $old . ".$struct";
			} else {
				$old = $1;
			}

			my @hash = split('\.', $struct);
			my $h = shift @hash;
			
			if(@hash) { 
				 $h = "\$$h\{" .shift(@hash) . "\}";
			}
			
			foreach my $k (@hash) { $h .= "->\{$k\}" };
			
			s/{[^}]+}/$h/;	

			$_ = eval(quote($_));	


		}

	return $_;	
}

sub quote { qq!"$_[0]"! }



