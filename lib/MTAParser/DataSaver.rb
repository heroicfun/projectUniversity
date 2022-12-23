require 'csv'
require 'json'

module DataSaver
  def saveCSV()
      CSV.open("iteamMTA.csv", "w") do |csv|
          csv << @items.first.keys 
          @items.each do |row|
            csv << row.values
          end
          puts 'Save csv - Done'
        end
  end
    
  def saveJSON()
      json = @items.to_json
      File.write('iteamMTA.json', json) 
      puts 'Save json - Done'
  end
end
