class CreateSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :sheets do |t|
      t.integer :number
      t.string :title
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
