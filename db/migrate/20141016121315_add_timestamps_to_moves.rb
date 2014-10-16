class AddTimestampsToMoves < ActiveRecord::Migration
  def change
    change_table(:moves) { |t| t.timestamps }
  end
end
