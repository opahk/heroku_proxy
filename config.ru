# config.ru
require 'rack'
require 'rack/proxy'
require 'rack/cache'

use Rack::Cache,
  :verbose     => true,
  :metastore   => 'file:tmp/cache/rack/meta',
  :entitystore => 'file:tmp/cache/rack/body'


class NlProxy < Rack::Proxy
  def rewrite_env(env)
    env["HTTP_HOST"] = "www.nightline.uni-hd.de"
    env["REQUEST_PATH"] = "/nightlines" + env["REQUEST_PATH"]
    env["PATH_INFO"] = "/nightlines" + env["PATH_INFO"]
    env["SERVER_PORT"] = 80

    env
  end
end

use NlProxy

run proc{ |env| [ 200, {'Content-Type' => 'text/plain'}, "a" ] }
