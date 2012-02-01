# Cnmobile
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) ||
                                          $:.include?(File.expand_path(File.dirname(__FILE__)))
module Cnmobile
  autoload :RequestWithMobile,        'cnmobile/request_with_mobile'
  autoload :Resolver, 'cnmobile/resolver'
end
if defined?(Rails)
  require 'cnmobile/rack'
  require 'cnmobile/rails'
end
