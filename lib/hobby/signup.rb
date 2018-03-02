require 'hobby'
require 'slim'

module Hobby
  class Signup
    include Hobby

    use Rack::ContentType, 'text/html'

    def initialize model, template = Slim::Template.new("#{__dir__}/template.slim")
      @model, @template = model, template
    end

    get {
      @template.render self
    }

    post {
      @user = @model.new request.params
      @user.save ? success : failure
    }

    def success
      response.redirect '/signin'
    end

    def failure
      @errors = @user.errors.to_a
      @template.render self
    end
end
end
