require './questions_database'
require './user'

class Question
  attr_accessor :id, :title, :body, :user_id

  def initialize(options = {})
    @id, @title, @body, @user_id=
       options.values_at('id', 'title', 'body', 'user_id')
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = (?)
    SQL

    Question.new(results.first)
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = (?)
    SQL

    results.map { |result| Question.new(result) }
  end

  def author
    results = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
      SELECT
        *
      FROM
        users
      WHERE
        user_id = (?)
    SQL

    User.new(results.first)
  end
end
