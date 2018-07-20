class Createusers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |usr|
      usr.string :FirstName
      usr.string :LastName
      usr.string :Username
      usr.string :Email
      usr.string :Password
      usr.string :UserType
    end
  end
end
