class AddUserToTagging < ActiveRecord::Migration[6.1]
  def change
    add_reference :taggings, :user
  end
end
