class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads do |t|
      t.references :user, null: false, foreign_key: true
      t.string :business_name
      t.string :contact_name
      t.string :phone
      t.string :email
      t.string :twitter
      t.string :instagram
      t.string :facebook
      t.string :tiktok
      t.string :website
      t.string :location
      t.integer :interest_level
      t.integer :status
      t.text :notes

      t.timestamps
    end
  end
end
