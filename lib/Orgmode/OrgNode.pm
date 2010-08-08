#!/usr/bin/env perl6

use v6;

class OrgNode {
    has Str $.title is rw;
    has Int $.level is rw;
    has @.children is rw;
    has Str $.content is rw;

    method Str(){    
        "OrgNode($.level, $.title)";
    }

    method perl() {
        my Str $indent = ' ' x 4;
        my $str = "OrgNode($.level, $.title)\{\n";
	
	if $.content {
	    my $content = "$.content";
	    $content ~~ s:g/^^/## /;
	    $str ~= $content;
        }

	for @.children -> $child {
	    my $cstr = $child.perl;
	    $cstr ~~ s:g/^^/    /;
	    $str ~= $cstr;
	}
	
	$str ~= "\}\n";
	$str;
    }
}
