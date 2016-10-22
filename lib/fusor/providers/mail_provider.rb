# frozen_string_literal: true
module Fusor
  module Providers
    class MailProvider < BaseProvider
      BASE_URL = 'http://mail.ru'

      def search(query)
        super
        agent.page.forms.last["q"] = query
        agent.page.forms.last.submit
        agent.page
      end

      def base_url
        BASE_URL
      end
    end
  end
end
