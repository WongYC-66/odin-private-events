class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.date :date
      t.belongs_to :creator, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
