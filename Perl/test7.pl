#!/usr/bin/perl -wl

use warnings;
#use strict;

# this does not work.  The reason seems to be the use of a period in a key name.  This will prevent overriding.


do 'being.cmacc';


%start = (%being, 'name' => "{docbody}");


my $render1 = "{start.name}";


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


			my($base) = $struct =~ /([^.]+)\./;

			if(!$base ) {
				$struct = $old . "." . $struct;
			} else {
				
				if(!(%$base)) { 
					$struct = $old . "." . $struct;
				} else {
					$old = $base; 
				}
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



