# This migration comes from refinery_members (originally 3)
class RemoveCarrerFromMembersMembers < ActiveRecord::Migration[5.1]
  def change
    remove_column :refinery_members, :carrer, :string
  end
end
