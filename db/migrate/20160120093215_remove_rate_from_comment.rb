class RemoveRateFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :rate, :integer
  end
end
