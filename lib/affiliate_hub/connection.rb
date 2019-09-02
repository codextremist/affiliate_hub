module AffiliateHub
  class Connection

    class HTTPError < StandardError; end

    attr_reader :settings

    include HTTParty
    debug_output $stdout if AffiliateHub::Settings.instance.debug_output

    class << self

      def def_endpoint(name, uri=nil, options={})

        namespace   = "#{self.to_s.deconstantize}::Endpoints"

        klass = if options[:class]
          "#{namespace}::#{options[:class].to_s.camelcase.demodulize}"
        else
          "#{namespace}::#{name.to_s.singularize.camelcase}"
        end

        @endpoints ||= {}
        @endpoints[name.to_sym] = klass.constantize.new(uri)

        class_eval <<-METHODS, __FILE__, __LINE__
          def #{name}(extended_uri=nil, async: false, mapper: false, request_params: {})

            dispatch = lambda do

              endpoint = self.class.endpoints(__method__.to_sym)
              endpoint.connection = self
              endpoint.mapper = mapper
              endpoint.extend_uri(extended_uri)

              response = endpoint.call(request_params)

              raise HTTPError, "\#{response.code} http error. Server response '\#{response.body}\'" if response.code != 200

              payload = endpoint.mapper ? endpoint.mapper.call(response.body) : response.body

              if block_given?
                yield payload, response.code, response.headers
              else
                {body: payload, code: response.code, headers: response.headers}
              end

            end

           async ? Thread.new(&dispatch) : dispatch.call

          end
        METHODS

      end

      def endpoints(name=nil)
        name ? @endpoints[name] : @endpoints
      end

    end
    
  end
end
