class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.references :tag, null: false # 引用
      t.references :record, null: false
      t.timestamps
    end
  end
end
