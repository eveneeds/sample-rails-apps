class CreatePages < ActiveRecord::Migration
  def self.up
    [:pages, :page_revisions].each do |table|
      create_table table do |t|
        t.string :title
        t.text :content
        t.integer :created_by
        t.timestamps
      end
    end
    
    add_column :pages, :updated_by, :integer
    add_column :page_revisions, :page_id, :integer
  end

  def self.down
    [:pages, :page_revisions].each {|table| drop_table table }
  end
end
