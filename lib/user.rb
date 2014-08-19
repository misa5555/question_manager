require './questions_database'
require './question'
class User
  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id, @fname, @lname =
      options.values_at('id', 'fname', 'lname')
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = (?)
    SQL

    User.new(results.first)
  end

  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = (?) AND lname = (?)
    SQL

    User.new(results.first)
  end

  def authored_questions
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = (?)
    SQL

    results.map {|result| Question.new(result) }
  end

  def authored_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = (?)
    SQL

    results.map {|result| Reply.new(result) }
  end
end
