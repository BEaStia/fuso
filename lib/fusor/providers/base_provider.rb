# frozen_string_literal: true
module Fusor
  module Providers
    class BaseProvider
      attr_accessor :agent

      def initialize
        @agent = Mechanize.new
      end

      def search(_query)
        agent.get(base_url)
      end

      def base_url
        raise NotImplementedError
      end
    end
  end
end
