class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :firstname
      t.string :lastname
      t.boolean :haspassport
      t.integer :salary
      t.date :birthdate
      t.date :hiredate
      t.string :gender
      t.string :notes
      t.string :email
      t.string :phone
      t.references :country, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
