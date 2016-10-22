# frozen_string_literal: true
module Fusor
  module Providers
    class YandexProvider < BaseProvider
      BASE_URL = 'https://yandex.ru'

      def search(query)
        super
        form = agent.page.forms.last
        form["text"] = query
        form.submit
        agent.page
      end

      def base_url
        BASE_URL
      end
    end
  end
end
