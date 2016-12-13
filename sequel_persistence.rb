require "sequel"

class SequelPersistence
  DB = Sequel.connect("postgres://localhost/cbsa_chapters")

  DB.disconnect

  def initialize(logger)
    DB.logger = logger
  end

  def density_all
    DB[:geo_area].inner_join(:density, :geo_area_id => :id).all
  end

  def query(data_type)
    DB[:geo_area].inner_join("#{data_type}".to_sym, :geo_area_id => :id).all
  end

  def less_than_1mil(data_type)
    query(data_type).select { |line| line[:pop_2010].to_i < 1000000 }
  end

  def between_1mil_3mil(data_type)
    query(data_type).select { |line| line[:pop_2010].to_i > 1000001 && line[:pop_2010].to_i < 3000000 }
  end

  def more_than_3mil(data_type)
    query(data_type).select { |line| line[:pop_2010].to_i > 3000001 }
  end

  def get_population_data(arr)
    case arr[0]
    when "less_than_1mil"
      less_than_1mil(arr[1])
    when "between_1mil_3mil"
      between_1mil_3mil(arr[1])
    when "more_than_3mil"
      more_than_3mil(arr[1])
    else "density"
      density_all
    end
  end
end
