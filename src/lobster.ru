require 'ebin/lobster'
require 'ebin/mochirack'

use Rack::Lint
use Rack::ShowExceptions
# run Rack::Lobster.new
Rack::Handler::Mochirack.run(Rack::Lobster.new)
