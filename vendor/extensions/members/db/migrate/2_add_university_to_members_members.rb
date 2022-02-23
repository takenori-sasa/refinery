class AddUniversityToMembersMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :refinery_members, :university, :string
  end
end
