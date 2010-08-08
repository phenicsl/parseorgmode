use v6;

# test grammar

grammar IndentLines {
    token TOP { [ <indentline> | <unindentline> ]* };
    
    token indentline {  <indent> <sentence> \n? }
    
    token unindentline {  <sentence> \n? }
    
    token indent {
        <indent_sapce=.ws>
        <?{ $<indent_space>.chars > 0 }>
    }

    token sentence {
        \S+\N* { say "setence matched"; }
    }
}

class IdentLinesActions {
    method TOP($/) {
        
    }

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

