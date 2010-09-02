use v6;

use LogUtil;

#
# Orgmode::Grammar
#
grammar Orgmode::Grammar;

#
# @cstars is used to record level of head lines 
#
my @cstars;

#
# cspaces is used to record space level
#
my @cspaces;


token TOP { 
    { @cstars = 0; @cspaces = 0; }      
    <orgnode>*
}

token orgnode { 
   <star_indent> 
   <headline>
   <content_line>* 		# arbitrary content lines
   <orgnode>*		# follow by indent nodes
   [<star_deindent> | $ ]
}

#
# A empty line begin at the line beginning "^^" and end at the line ending
# with only whitespaces("<.ws>") between them. 
#
token empty_line {
    ^^ <.ws> $$ { logger.debug("Match empty line"); }
}

#
# A 
#
regex headline { 
    (\N *?) <tags>? [\n | $] { logger.debug("match headline : $/"); }
}

#
# star indentation. if line starts with stars and have more stars than
# @cstarts[*-1] then it is considered to be a indentation.
#
# <?{ }> code assertion is used here to assert an star indentation
#
token star_indent {
    <stars> <?{ ($<stars>.chars - 1) > @cstars[*-1]; }>
    { push @cstars, ($<stars>.chars - 1);
      logger.debug("start_indent match to be $/");
      logger.debug("After Push: { @cstars.perl }");
    }
}

#
# Every lines not starts with <stars>
#
token content_line {
    ^^ <!stars> (\N* \n) { logger.debug("Match Content Line: $0"); }
}

#
# star deindentation. Meaning a higher level of sections is started. 
#
# <?stars> is used to forbid them from consumed.
#
token star_deindent {
    <?stars> <?{ ($<stars>.chars - 1) <= @cstars[*-1]; }>
    { pop @cstars; 
      logger.debug("After Pop: { @cstars.perl} "); 
    }
}

#
# star sequence with one space after them
#
token stars { '*'+ ' ' }

#
# A tag are nomal word containing letters, numbers, '_' and '@'
# <[]> contains a 
# 
token tag {
    <[a..zA..Z0..9_@]>+
}

#
# tags must be preceded and followed by a single colon.
#
token tags {
    ':' <tag> ** ':' ':' { say "Match tags to be $/" }
}
