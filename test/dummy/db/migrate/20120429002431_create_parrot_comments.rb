class CreateParrotComments < ActiveRecord::Migration
  def change
    create_table :parrot_comments do |t|
      t.integer :author_id
      t.string  :commentable_type
      t.integer :commentable_id
      t.text    :body
      t.integer :parent_id
      t.timestamps
    end
  end
end
