require_relative "MTAParser/version"
require_relative "MTAParser/DataParser"

module MTAParser
  def self.title(id)
    return "/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[3]/a"
  end

  def self.price(id)
      return "/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[3]/div/div[1]"
  end

  def self.discount(id)
      return "/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[2]/span[1]"
  end

  def self.cashback(id)
      return "/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[5]/button/span"
  end
end
