class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.integer :amount, null: false #必须传
      t.integer :category, null: false, limit: 1
      t.string :notes
      t.timestamps
    end
  end
end
