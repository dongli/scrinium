class AddSubdomainToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :subdomain, :string
  end
end
