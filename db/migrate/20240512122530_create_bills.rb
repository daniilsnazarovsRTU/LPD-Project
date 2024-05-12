class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills do |t|
      t.string :filename
      t.string :notes

      t.timestamps
    end
  end
end
