class AddUserIdReferenceToBills < ActiveRecord::Migration[7.1]
  def change
    add_reference :bills, :user, null: false, foreign_key: true
  end
end
