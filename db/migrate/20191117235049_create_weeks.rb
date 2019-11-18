class CreateWeeks < ActiveRecord::Migration[6.0]
  def change
    create_table :weeks do |t|
      t.string :week

      t.timestamps
    end
  end
end
