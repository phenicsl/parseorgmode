#!/usr/bin/env perl6

use v6;

class OrgNode {
    has Str $.title is rw;
    has Int $.level is rw;
    has @.children is rw;
    has Str $.content is rw;
    has @.tags is rw;

    method Str(){    
        "OrgNode($.level, $.title)";
    }

    method perl() {
        my Str $indent = ' ' x 4;
        my $str = "OrgNode($.level, $.title)\{\n";
	
	$str ~= "TAGS:";
	for @.tags -> $tag {
	    $str ~= $tag;
	}
	$str ~= "\n";

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
