class RemoveCarrerFromMembersMembers < ActiveRecord::Migration[5.1]
  def change
    remove_column :refinery_members, :carrer, :string
  end
end
