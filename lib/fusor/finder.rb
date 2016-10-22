# frozen_string_literal: true
require 'fusor/providers'

module Fusor
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
          providers[provider] = "fusor/providers/#{provider}_provider".camelize.constantize.new
        end
        start_work
        result = work { providers[provider].search(query) }
        finish_work
        result
      end
    end

    def work
      start_work
      result = yield
      finish_work
      result
    end

    def start_work
      @status = :working
    end

    def finish_work
      @status = :ready
    end
  end
end
