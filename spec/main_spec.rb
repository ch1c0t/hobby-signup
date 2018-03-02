require_relative 'test_app/app'

require 'puma'
require 'watir'

require 'rspec/power_assert'
RSpec::PowerAssert.example_assertion_alias :assert
RSpec::PowerAssert.example_group_assertion_alias :assert

class Signup
  def initialize
    @browser = Watir::Browser.new
    @browser.goto '127.0.0.1:8080/signup'
  end

  attr_accessor :browser
  attr_accessor :name, :password, :password_confirmation

  def submit
    form = @browser.form
    form.text_field(name: 'name').set @name
    form.text_field(name: 'password').set @password
    form.text_field(name: 'password_confirmation').set @password_confirmation
    form.submit
  end
end

describe do
  before do
    @pid = fork do
      server = Puma::Server.new App.new
      server.add_tcp_listener '127.0.0.1', 8080
      server.run
      sleep
    end
  end

  context 'when it succeeds' do
    it "redirects to '/signin'" do
      signup = Signup.new
      signup.name, signup.password, signup.password_confirmation = 'a', '123', '123'
      signup.submit

      assert { signup.browser.text.include? 'Sign in.' }
    end
  end

  context 'when it fails' do
  end

  after do
    `kill -9 #{@pid}`
  end
end
