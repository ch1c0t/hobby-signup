Gem::Specification.new do |g|
  g.name    = 'hobby-signup'
  g.files   = `git ls-files`.split($/)
  g.version = '0.0.0'
  g.summary = 'A Rack application for signing up.'
  g.authors = ['Anatoly Chernow']

  g.add_dependency 'hobby'
  g.add_dependency 'slim'
end
