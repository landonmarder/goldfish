class CreateGroup < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
