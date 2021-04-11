class CreateCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :codes do |t|
      t.string :password_digest

      t.timestamps
    end
  end
end
