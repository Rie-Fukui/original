class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :micropost, index: true, foreign_key: true
      t.string :text

      t.timestamps null: false
      t.index [:micropost_id, :created_at]
    end
  end
end
