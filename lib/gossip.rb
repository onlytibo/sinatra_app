require 'pry'
require 'csv'
require 'date'


class Gossip
  attr_accessor :author, :content, :date, :comments
  @@all_gossips = []

  def initialize(author,content,date = DateTime.now.strftime("%H:%M, le %d/%m/%Y"))
    @author = author
    @content = content
    @date = date
    

  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content, @date, @comments]
    end
  end

  def self.all
    @@all_gossips = []
    CSV.read("./db/gossip.csv").each do |line|
      @@all_gossips << Gossip.new(line[0], line[1], line[2], line[3])
    end
    return @@all_gossips
  end

  def edit(author, content, date, id)
    @author = author
    @content = content
    @date = date
    # {"comment_author" => comment_author, "comment_content" => comment_content}
    # save_edit
    all_gossips_with_replaced_element = []

    @@all_gossips.map.with_index do |g, i|
      if i == (id-1)
        all_gossips_with_replaced_element << self
      else
        all_gossips_with_replaced_element << @@all_gossips[i]
      end
    end

    CSV.open("./db/gossip.csv", "w") do |csv|
      all_gossips_with_replaced_element.each do |g|
        csv << [g.author, g.content, g.date, g.comments]
      end
    end
  end

  def add_comment(author,content,id)
    @comments << Comment.new(author,content)
    all_gossips_with_replaced_element = []

    @@all_gossips.map.with_index do |g, i|
      if i == (id-1)
        all_gossips_with_replaced_element << self
      else
        all_gossips_with_replaced_element << @@all_gossips[i]
      end
    end
    CSV.open("./db/gossip.csv", "w") do |csv|
      all_gossips_with_replaced_element.each do |g|
        csv << [g.author, g.content, g.date, g.comments]
      end
    end
    # comments = all_gossips_with_replaced_element[id-1].comments

  end
  def display_comment
    id_comments = self.comments
    print id_comments
    return id_comments
    # comments_ary = []
    # @@all_gossips.map.with_index do |g, i|
    #   if i == (id-1)
    #     comments_ary << self
    #   else
    #     comments_ary << @@all_gossips[i]
    #   end
    # end
    # comment = comments_ary[id].comments
  end

  def self.find(id)
    gossips =  Gossip.all
    print @@all_gossips
    real_id = id-1
    gossip = @@all_gossips[real_id]
    puts gossip
    return gossip
  end
end
  # def comments(id,author,content)
  #   comment = Comment.new(id,author,content).save_comment
  #   puts comment.link
  #   CSV.read('./db/gossip.csv').each do |csv_line|
  #     @comments << [comment.link, comment.comment_author, comment.comment_content]
  #   end
  #     print @comments
  #   return @comments
  # end

    # def save_edit
  #   # all_gossips_with_replaced_element = []

  #   #   all_gossips = Gossip.all

  #   #   all_gossips.map.with_index do |g, i|
  #   #     if i == (id-1)
  #   #       all_gossips_with_replaced_element << self
  #   #     else
  #   #       all_gossips_with_replaced_element << all_gossips[i]
  #   #     end
  #   #   end

  #   #   CSV.open("./db/gossip.csv", "w") do |csv|
  #   #     all_gossips_with_replaced_element.each do |g|
  #   #       csv << [g.author, g.content, g.date, [g.comments]
  #   #     end
  #   #   end
  #   end