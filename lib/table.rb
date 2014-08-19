require "./questions_database"

class Table
  def self.find_one(sql_string, *args)
    results = QuestionsDatabase.instance.execute(sql_string, *args)
    self.new(results.first) unless results.empty?
  end

  def self.find_by(sql_string, *args)
    results = QuestionsDatabase.instance.execute(sql_string, *args)
    results.map { |result| self.new(result) }
  end
end
