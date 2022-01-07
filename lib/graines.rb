require "graines/version"
require "airrecord"

module Graines
  class Error < StandardError; end
  Airrecord.api_key = ENV["AIRTABLE_API_KEY"]

  class Seed < Airrecord::Table
    self.base_key = "appHNiFg8HxKehJ9N"
    self.table_name = "graines"
    has_many :months, class: "Graines::Month", column: "Mois"

    def name
      self["Nom"]
    end
  end

  class Month < Airrecord::Table
    self.base_key = "appHNiFg8HxKehJ9N"
    self.table_name = "Mois"

    has_many :seeds, class: "Graines::Seed", column: "graines"

    def name
      self["Name"]
    end
  end

  def self.print_per_month
    Graines::Month.all(sort: { "order" => "asc"}).each do |m|
      puts "## #{m.name}"
      puts
      m.seeds.map(&:name).sort.each { |name| puts "- #{name}" }
      puts
      puts "+++"
      puts
    end
  end
end

