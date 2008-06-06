class CreatePages < ActiveRecord::Migration
  def self.up
    [:pages, :revisions].each do |table|
      create_table table do |t|
        t.string :title
        t.text :content
        t.integer :created_by
        t.timestamps
      end
    end
    
    add_column :pages, :updated_by, :integer
    add_column :revisions, :page_id, :integer
    add_column :revisions, :message, :string
  end

  def self.down
    [:pages, :revisions].each {|table| drop_table table }
  end
end
