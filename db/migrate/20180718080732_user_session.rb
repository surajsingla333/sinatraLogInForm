class UserSession < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |ses|
      ses.integer :UserId
      ses.datetime :Created_at
      ses.string :Token
      ses.boolean :status, default: 1
    end
  end
end
