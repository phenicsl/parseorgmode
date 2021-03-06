use v6;
use Logging::Logger;
use LogUtil;

class Orgmode::Actions;

method TOP($/) {
    logger.debug("In TOP");
    logger.debug($/.perl);

    my @orgnode_array;
    for @($<orgnode>) -> $node {
	push @orgnode_array, $node.ast;
    }

    make @orgnode_array;
}

method orgnode($/) {
    my Int $level = $<star_indent>.ast;
    my $headline = $<headline>.ast;

    say $headline.perl;
    my Str $title = @($headline)[0];
    my OrgNode $orgnode = OrgNode.new(:$level, :$title);
    $orgnode.tags = @($headline)[1];
    logger.debug(~$orgnode);

    my $content;
    for @($<content_line>) -> $line {
	$content ~= $line;
    }

    $orgnode.content = $content;

    for @($<orgnode>) -> $node {
	push $orgnode.children, $node.ast;
    }

    make $orgnode;
}

method content($/){
    make $0;
}

method headline($/) {
    logger.debug("In Headline: $0");    
    make [~$/[0], @($<tags>).map(-> $x { ~$x })]
}

# start_indent ast = number of stars
method star_indent($/) {
    make ($<stars>.chars - 1);
}


