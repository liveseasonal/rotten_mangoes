class AddADefaultValue < ActiveRecord::Migration
  def change
    change_column :reviews, :rating_out_of_ten, :integer, :default => 5
  end
end
