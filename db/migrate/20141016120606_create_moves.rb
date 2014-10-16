class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :name
    end
  end
end
