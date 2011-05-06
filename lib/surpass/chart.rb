class Chart
  def initialize
    raise "not implemented"
  end
  
  
  # ● OBJ Object description for the chart 
  # ● BOF Type = chart (➜5.8) 
  # Chart records 
  # ● EOF End of the Chart Substream of the chart object (5.37) 
  def to_biff
    result = []
    result << Biff8BOFRecord.new(Biff8BOFRecord::CHART).to_biff
    result.join
  end
end
