require 'CSV'

module LoadCSV

  def load_csv(file_path, object)
    csv = CSV.open("#{file_path}", headers: true, header_converters: :symbol )
    csv.map do |row|
      object.new(row)
    end
  end
end
