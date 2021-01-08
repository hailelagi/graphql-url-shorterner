class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :shortLink
      t.string :originalLink

      t.timestamps
    end
  end
end
