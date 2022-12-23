require 'csv'
require 'json'

class Save
    def initialize(data)
      @data = data
    end
  
    def saveCSV()
        CSV.open("./file/iteamMTA.csv", "w") do |csv|
            csv << @data.first.keys 
            @data.each do |row|
              csv << row.values
            end
            puts 'Save csv - Done'
          end
    end
  
    def saveJSON()
        json = @data.to_json
        File.write('./file/iteamMTA.json', json) 
        puts 'Save json - Done'
    end
end