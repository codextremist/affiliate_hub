module AffiliateHub
  class Settings

    include Singleton

    attr_accessor :debug_output

    def initialize
      @confs = {}
    end

    def setup(name, &blk)
      namespace = name.to_s.camelcase
      settings  = @confs[name] || "AffiliateHub::#{namespace}::Settings".constantize.new
      settings.instance_eval(&blk) if blk
      @confs[name] = settings
      rescue  NoMethodError => e
        raise e
      rescue NameError => e
        raise "AffiliateHub::#{namespace}::Settings class is missing. Refer to
        https://github.com/lemmoney/affiliate_hub for more information"
    end

  end
end
