class AddTitleToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :title, :string
    add_column :microposts, :word, :string
  end
end
