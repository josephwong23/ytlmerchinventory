class CreateMemberDivisions < ActiveRecord::Migration[5.0]
  def change
    create_table :member_divisions do |t|
      t.string :name

      t.timestamps
    end
  end
end
