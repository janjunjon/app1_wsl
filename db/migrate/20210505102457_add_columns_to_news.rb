class AddColumnsToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :info, :string
  end
end
