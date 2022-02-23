class CreateMembersMembers < ActiveRecord::Migration[5.1]

  def up
    create_table :refinery_members do |t|
      t.string :name
      t.string :romanized_name
      t.integer :photo_id
      t.string :carrer
      t.string :occupation
      t.text :blurb
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-members"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/members/members"})
    end

    drop_table :refinery_members

  end

end
