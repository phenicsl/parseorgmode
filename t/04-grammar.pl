use v6;

# test grammar

grammar IndentLines {
    my Int $cil;		# current indent level

    # use token to ensure non-automatic sigspace
    token TOP { [ block ]* };
    
    token block { }

    token indent {
        <indent_space=.ws> 
        <?{ $<indent_space>.chars > 0 }>
     	{ $cil = $<indent_space>.chars; }
    }

    token deindent {
	<indent_space=.ws>
	<?{ $<indent_space>.chars < $cil }>
	{ $cil = $<indent_space>.chars; }
    }

    token sentence {
        \S+\N* 
    }
}

class IdentLinesActions {
    method indentline($/) {
        my $count = $/<indent>.chars;
	my $sentence = $/<sentence>;

	say "indent count = $count, sentence = $sentence";
    }

    method unindentline($/) {
        say "sentence = $/<sentence>";
    }    
}

my Str $str = "first line\n    second line";

my $actions = IdentLinesActions.new;
my $retval = IndentLines.parse($str, :$actions);

