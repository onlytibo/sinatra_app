require 'pry'
require 'csv'
require 'date'

class Gossip
  attr_reader :author, :content, :date
  
  def initialize(author,content,date = DateTime.now.strftime("%H:%M, le %d/%m/%Y"))
    @author = author
    @content = content
    @date = date
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content, @date]
    end
  end

  def self.all
    all_gossips = []

    CSV.read("./db/gossip.csv").each do |line|
      all_gossips << Gossip.new(line[0], line[1], line[2])
    end
    return all_gossips
  end

  def self.find(id)
    gossips = Gossip.all
    real_id = id-1
    gossip = gossips[real_id]
    return gossip
  end


  def edit(author, content, date, id)
    @author = author
    @content = content
    @date = date

    all_gossips_with_replaced_element = []

    all_gossips = Gossip.all

    all_gossips.map.with_index do |g, i|
      if i == (id-1)
        all_gossips_with_replaced_element << self
      else
        all_gossips_with_replaced_element << all_gossips[i]
      end
    end

    CSV.open("./db/gossip.csv", "w") do |csv|
      all_gossips_with_replaced_element.each do |g|
        csv << [g.author, g.content, g.date]
      end
    end
  end
end
