class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions, { id: false } do |t|
      t.column :id, :string, null: false, index: true
      t.column :amount, :float, null: false
      t.column :status, :string, null: false
    end
  end
end
