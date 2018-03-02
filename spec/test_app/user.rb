require 'logger'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection adapter: 'sqlite3',
                                        database: "/tmp/#{$$}.sqlite"

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :email, null: false
    t.string :password_digest, null: false
  end
end

class User < ActiveRecord::Base
  has_secure_password
end
