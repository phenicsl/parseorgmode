use v6;

use LogUtil;

grammar Orgmode::Grammar;

my @cstars;
my @cspaces;

token TOP { 
    { @cstars = 0; @cspaces = 0; }      
    <orgnode>*
}

token orgnode { 
    <star_indent> <headline> { logger.debug($<headline>.perl) }
    <content_line>* 		# arbitrary content lines
    <orgnode>*		# follow by indent nodes
    [<star_deindent> | $ ]
}

token empty_line {
  ^^ <.ws> $$ { logger.debug("Match empty line"); }
}
token headline { (\N*) \n? { logger.debug("Match Headline: $/"); } }

token star_indent {    
    <stars> <?{ ($<stars>.chars - 1) > @cstars[*-1]; }>
    { push @cstars, ($<stars>.chars - 1); 
      logger.debug("After Push: { @cstars.perl }");
    }
}

token content_line {
    ^^ <!stars> (\N* \n) { logger.debug("Match Content Line: $0"); }
}

token star_deindent {
    <?stars> <?{ ($<stars>.chars - 1) <= @cstars[*-1]; }>
    { pop @cstars; 
      logger.debug("After Pop: { @cstars.perl} "); 
    }
}

token stars { '*'+ ' ' }
