# frozen_string_literal: true

require 'rails'
require_relative 'xlog/xlogger'
require_relative 'xlog/version'

module Xlog
  class << self
    attr_accessor :config, :app_name, :app_root, :base_logger, :xlogger

    def tag_logger(*tags)
      config.xlogger.tag_logger(tags)
    end

    def clear_tags
      config.xlogger.clear_tags
    end

    def info(message, data: nil)
      config.xlogger.info(message, data)
    end

    def warn(message, data: nil)
      config.xlogger.warn(message, data)
    end

    def error(e, message: nil, data: nil)
      config.xlogger.error(e, message, data)
    end

    def and_raise_error(e, message: nil, data: nil)
      config.xlogger.and_raise_error(e, message, data)
    end
  end

  def self.configure
    self.config ||= Config.new
    yield(config)
  end

  class Config
    attr_accessor :xlogger

    def initialize
      @xlogger = Xlogger.instance
    end

    def custom_logger=(logger)
      xlogger.custom_logger = logger
    end
  end

  configure {}
end
