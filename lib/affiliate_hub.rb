require "singleton"
require "ostruct"
require "httparty"
require 'nokogiri'
require "active_support/inflector"

require "affiliate_hub/version"
require "affiliate_hub/settings"
require "affiliate_hub/endpoint"
require "affiliate_hub/connection"

module AffiliateHub

  class << self

    def setup(options={},&blk)
      @settings = AffiliateHub::Settings.instance
      @settings.instance_eval &blk
      @settings
    end

    def initialize_connection(client, local_settings=nil)
      klass = "AffiliateHub::#{client.to_s.camelcase}::Connection".constantize
      klass.new(set_local_settings_for(client, local_settings))
    end

    def set_local_settings_for(client, settings)
      if settings.kind_of? Hash
        settings.each do |k,v|
          settings_for(client).send("#{k}=",v)
        end
      elsif settings.kind_of? Proc
        settings_for(client).instance_eval &settings
      end
      settings_for(client)
    end

    def settings_for(client)
      AffiliateHub::Settings.instance.setup(client)
    end

  end

end
