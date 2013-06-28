# -*- coding: utf-8 -*-
ActiveSupport.on_load(:action_controller) do
  require 'cnmobile/helpers'
  require 'cnmobile/hook_action_controller'
  require 'cnmobile/hook_action_view'
end

module Cnmobile
  module ViewSelector
    def self.included(base)
      base.class_eval do
        before_filter :register_mobile

        self._view_paths = self._view_paths.dup
        self.view_paths.unshift(*self.view_paths.map {|resolver| Cnmobile::Resolver.new(resolver.to_path) })
      end
    end

    def register_mobile
      if request.mobile?
        # register mobile
        enable_mobile_view!
      end
    end

    def enable_mobile_view!
      self.lookup_context.mobile = [:mobile]
    end

    def disable_mobile_view!
      self.lookup_context.mobile = []
    end
  end
end
