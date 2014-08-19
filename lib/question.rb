require_relative 'questions_database'
require_relative 'user'
require_relative 'table'

class Question < Table
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

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def author
    User.find_one(<<-SQL, @user_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = (?)
    SQL
  end

  def followers

  end

  def likers
  end

  def num_likes
  end

  def replies
  end
end
