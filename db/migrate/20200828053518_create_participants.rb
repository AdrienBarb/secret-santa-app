class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :user_name
      t.string :email
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
