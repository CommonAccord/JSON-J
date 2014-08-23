#!/usr/bin/perl -wl

use warnings;
use strict;

my @missing;
my $path = "./repository/";

sub parse {
	
	my($file,$root) = @_; my $f;

	ref($file) eq "GLOB" ? $f = $file : open $f, $file or die $!;
	
	my $content = parse_root($f, $root);

	if($content) { expand_fields($f, \$content); return($content) }

	return;
}


sub parse_root { 
	
	my ($f, $field) = @_; my $root;

	seek($f, 0, 0);	
#	local $/ = "\n\n";
	while(<$f>) {
#		$_ = substr($_, 0, -2);
		return $root if ($root) = $_ =~ /^$field\s*=\s*(.*?)$/;
	}
	
	seek($f, 0, 0);
	while(<$f>) {
		my($part,$what);	
		if( (($part, $what) = $_ =~ /^([^=]*)=\[(.+?)\]/) and ($field =~ s/^$part//) ) {
			$root = parse($path.$what, $field);
		}
	}
	return $root;

} 

sub expand_fields  {

	my($f,$field) = @_;

	foreach( $$field =~ /\{([^}]+)\}/g ) {
		my $ex = $_;
		my $value = parse($f, $ex);
		$value ? $$field =~ s/\{$ex\}/$value/gg : push @missing, $ex;
	}
} 



print "\nResult:\n".parse($ARGV[0], "Model.Root");
print "\nMissing elements: @missing";

