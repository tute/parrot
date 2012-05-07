class CreateParrotComments < ActiveRecord::Migration
  def change
    create_table :parrot_comments do |t|
      t.integer :author_id
      t.string  :author_name
      t.string  :author_email
      t.string  :author_phone
      t.string  :commentable_type
      t.integer :commentable_id
      t.text    :body
      t.integer :parent_id
      t.timestamps
    end
  end
end
