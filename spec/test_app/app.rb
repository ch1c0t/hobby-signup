require 'hobby/signup'

require_relative 'user'

class App
  include Hobby

  get '/signin' do
    'Sign in.'
  end

  map '/signup', Hobby::Signup.new(User)
end
