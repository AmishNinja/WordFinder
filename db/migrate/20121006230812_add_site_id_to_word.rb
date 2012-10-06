class AddSiteIdToWord < ActiveRecord::Migration
  def self.up
    add_column :words, :site_id, :integer
  end

  def self.down
    remove_column :words, :site_id
  end
end
