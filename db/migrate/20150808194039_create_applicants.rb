class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :email
      t.string :phone_1
      t.string :phone_2
      t.string :confirmation_token
      t.string :address

      t.timestamps null: false
    end
  end
end
