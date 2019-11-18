class CreateDays < ActiveRecord::Migration[6.0]
  def change
    create_table :days do |t|
      t.string :start
      t.string :end
      t.string :week_day
      t.references :week, null: false, foreign_key: true

      t.timestamps
    end
  end
end
