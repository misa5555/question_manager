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

  def save
    if self.id.nil?
      create
    else
      update
    end
  end

  def create
    ivars_quoted = ivar_strings.map { |el| "'#{el}'" }

    QuestionsDatabase.instance.execute(<<-SQL, ivar_values)
      INSERT INTO
        #{ self.class::TABLE } (#{ ivars_quoted.join(", ") })
      VALUES
        ( #{ instance_variables.map { '?' }.join(", ") } )
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    # fname = (?), lname = (?)
    update_command = ivar_strings.map { |el| "#{el} = (?)" }.join(", ")

    QuestionsDatabase.instance.execute(<<-SQL, ivar_values)
      UPDATE #{ self.class::TABLE }
      SET
        #{update_command}
      WHERE
        id = #{@id}
    SQL
  end

  def ivar_strings
    self.instance_variables.map { |var| "#{var.to_s[1..-1]}" }
  end

  def ivar_values
    self.instance_variables.map do |sym|
      self.instance_variable_get(sym)
    end
  end
end
