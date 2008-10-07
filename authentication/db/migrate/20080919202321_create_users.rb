class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :password_hash, :password_salt
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
