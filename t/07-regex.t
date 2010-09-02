use v6;

{
    grammar Tags_Grammar {
    	token TOP {
	    <headline>
	}

	token headline {
	#	    (\S+) <.ws>+ <tags> \n { say $/ }
	(\N *) <tags> { say $/; say $0; say $1; say $<tags>;}
	}
    	token tag {
	    <[a..zA..Z0..9_@]>+
	}

	token tags {
	    ':' <tag> ** ':' ':' { say $/ }
	}
    }

    my $str = "first :@tag1:@tag2:\n";
    my $match = Tags_Grammar.parse($str);
}
