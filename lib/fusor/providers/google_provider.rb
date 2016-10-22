# frozen_string_literal: true
module Fusor
  module Providers
    class GoogleProvider < BaseProvider
      BASE_URL = 'http://google.com'

      def search(query)
        super
        agent.page.forms[0]["q"] = query
        agent.page.forms[0].submit
        agent.page
      end

      def base_url
        BASE_URL
      end
    end
  end
end
