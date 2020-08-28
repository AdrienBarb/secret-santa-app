class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
