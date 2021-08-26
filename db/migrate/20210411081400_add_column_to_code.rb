class AddColumnToCode < ActiveRecord::Migration[6.1]
  def change
    add_column :codes, :classification, :string
  end
end
