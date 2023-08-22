class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false, unique: true
      t.string :name

      t.timestamps
    end
  end
end
