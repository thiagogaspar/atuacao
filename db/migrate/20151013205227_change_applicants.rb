class ChangeApplicants < ActiveRecord::Migration
  def change
    remove_column :applicants, :phone_2, :string
    add_column :applicants, :last_name, :string
    add_column :applicants, :organization, :string
  end
end
