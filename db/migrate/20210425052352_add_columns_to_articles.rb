class AddColumnsToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :romaji_name, :string
  end
end
