require "sequel"

class SequelPersistence
  DB = Sequel.connect("postgres://localhost/cbsa_chapters")

  DB.disconnect

  def initialize(logger)
    DB.logger = logger
  end

  def density
    result = DB[:geo_area].inner_join(:density, :geo_area_id => :id).all
  end
end
