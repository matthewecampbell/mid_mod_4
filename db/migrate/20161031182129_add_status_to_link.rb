class AddStatusToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :read, :boolean, :default => false
  end
end
