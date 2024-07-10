class AddBoardToArticles < ActiveRecord::Migration[7.1]
  def change
    add_reference :articles, :board, null: false, foreign_key: true
  end
end
