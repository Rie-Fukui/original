class AddFinishToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :finish, :boolean, null: false, default: false
  end
end
