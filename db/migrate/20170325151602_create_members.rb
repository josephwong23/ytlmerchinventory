class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.references :member_division, foreign_key: true

      t.timestamps
    end
  end
end
