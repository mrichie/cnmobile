# -*- coding: utf-8 -*-

module Cnmobile
  module RequestWithMobile
    MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
    'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
    'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
    'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
    'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'

    def user_agent
      env['HTTP_USER_AGENT']
    end

    # for reverse proxy.
    def remote_addr
      if respond_to?(:remote_ip)
        return __send__(:remote_ip)  # for Rails
      elsif respond_to?(:ip)
        return __send__(:ip)         # for Rack
      else
        return ( env["HTTP_X_FORWARDED_FOR"] ? env["HTTP_X_FORWARDED_FOR"].split(',').pop : env["REMOTE_ADDR"] )
      end
    end

    def user_agent=(str)
      self.env["HTTP_USER_AGENT"] = str
    end

    def mobile?
      agent_str = user_agent.to_s.downcase
      return false if agent_str =~ /ipad/
      agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
    end

  end

end
