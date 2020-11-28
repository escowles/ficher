class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :text
      t.integer :row
      t.integer :col
      t.references :sheet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
