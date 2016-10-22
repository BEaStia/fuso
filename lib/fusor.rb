require 'fusor/version'
require 'mechanize'
require 'open-uri'
require 'active_support/core_ext/string/inflections'

module Fusor
  class User
    attr_accessor :first_name, :last_name, :events

    def self.find_in_vk(first_name, last_name)

    end

  end

  class Event
    attr_accessor :start_date, :end_date, :start_place, :end_place, :origin_url
  end


  class Finder
    AVAILABLE_STATUSES = %i[ready working stopped].freeze
    PROVIDERS = %i[google yandex bing mail].freeze

    attr_accessor :status
    attr_accessor :providers

    def initialize
      @status = :ready
      @providers = {}
    end

    PROVIDERS.each do |provider|
      define_method(provider) do |query|
        if providers[provider].nil?
          providers[provider] = "fusor/finder/#{provider}_provider".camelize.constantize.new
        end
        start_work
        result = work { providers[provider].search(query) }
        finish_work
        result
      end
    end

    def work(&block)
      start_work

      result = block.call

      finish_work
      result
    end

    def start_work
      @status = :working
    end

    def finish_work
      @status = :ready
    end

    class BaseProvider
      attr_accessor :agent

      def initialize
        @agent = Mechanize.new
      end

      def search(query)
        agent.get(base_url)
      end

      def base_url
        raise NotImplementedError
      end
    end

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

    class BingProvider < BaseProvider
      BASE_URL = 'http://bing.com'

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
