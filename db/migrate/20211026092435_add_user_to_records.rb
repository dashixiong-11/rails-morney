class AddUserToRecords < ActiveRecord::Migration[6.1]
  def change
    add_reference :records, :user
  end
end
