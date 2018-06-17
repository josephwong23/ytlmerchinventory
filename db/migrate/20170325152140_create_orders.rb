class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.boolean :status
      t.date :deliver_by
      t.date :order_date
      t.string :reason
      t.boolean :delivery_status, default: false
      t.references :item, foreign_key: true
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
