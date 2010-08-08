use v6;

module LogUtil;

use Logging::Logger;

my Logger $logger = Logger.simple_init(level => Logger.DEBUG);

sub logger( ) is export {
    return $logger;
}
