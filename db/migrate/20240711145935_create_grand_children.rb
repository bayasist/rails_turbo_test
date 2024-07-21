class CreateGrandChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :grand_children do |t|
      t.references :child, null: false, foreign_key: true
      t.string :name, null: false
      t.timestamps
    end
  end
end
