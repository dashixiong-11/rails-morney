class AddUserToTags < ActiveRecord::Migration[6.1]
  def change
    add_reference :tags, :user
  end
end
