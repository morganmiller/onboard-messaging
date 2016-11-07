require 'logger'
require 'faker'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'active_support'
require 'active_support/core_ext'

module LoadScript
  class Session
    include Capybara::DSL
    attr_reader :host
    def initialize(host = nil)
      Capybara.default_driver = :poltergeist
      @host = host || 'http://localhost:3000'
    end

    def logger
      @logger ||= Logger.new('./log/requests.log')
    end

    def session
      @session ||= Capybara::Session.new(:poltergeist)
    end

    def run
      while true
        run_action(actions.sample)
      end
    end

    def run_action(name)
      benchmarked(name) do
        send(name)
      end
    rescue Capybara::Poltergeist::TimeoutError
      logger.error("Timed out executing Action: #{name}. Will continue.")
    end

    def benchmarked(name)
      logger.info "Running action #{name}"
      start = Time.now
      val = yield
      logger.info "Completed #{name} in #{Time.now - start} seconds"
      val
    end

    def actions
      [
        :view_sms_messages
      ]
    end

    def view_sms_messages
      session.visit "#{host}/sms_messages"
      session.all(".thread").sample.click
    end

  end
end
