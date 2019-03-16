class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :content

      t.timestamps
      
      t.index :user_id
      t.index :post_id
      t.index [:user_id, :post_id, :created_at]
    end
  end
end