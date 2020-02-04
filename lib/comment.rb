require 'csv'
require 'date'


class Comment
  attr_accessor :comment_author, :comment_content, :comment_date

  def initialize(comment_author,comment_content,comment_date = DateTime.now.strftime("%H:%M, le %d/%m/%Y"))
    
    @comment_author = comment_author
    @comment_content = comment_content
    @comment_date = comment_date

  end

  # def save_comment
  #   CSV.open("./db/gossip.csv", "ab") do |csv|
  #     csv << [@comment_author, @comment_content, @comment_date]
  #   end
  # end


end

