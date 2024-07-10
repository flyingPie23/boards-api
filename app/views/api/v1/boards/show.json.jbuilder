
json.extract! @board, :id, :title, :description

json.articles @board.articles do |article|

  json.extract! article, :id, :title, :content

end
