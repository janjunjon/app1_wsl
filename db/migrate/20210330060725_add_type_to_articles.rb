class AddTypeToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :degree, :string
  end
end
