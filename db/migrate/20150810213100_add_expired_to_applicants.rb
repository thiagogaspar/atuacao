class AddExpiredToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :expired, :boolean
  end
end
