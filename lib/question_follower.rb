require './questions_database'
require './table'

class QuestionFollower < Table
  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id, @user_id, @question_id =
       options.values_at('id', 'user_id', 'question_id')
  end

  def self.find_by_id(id)
    QuestionFollower.find_by(<<-SQL, id).first
      SELECT
        *
      FROM
        question_followers
      WHERE
        id = (?)
    SQL
  end

  def self.followers_for_question_id(question_id)
    User.find_by(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_followers ON users.id = question_followers.user_id
      WHERE
        question_followers.id = (?)
    SQL
  end

  def self.followed_questions_for_user_id(user_id)
    Question.find_by(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_followers ON questions.id = question_followers.question_id
      WHERE
        question_followers.id = (?)
    SQL
  end

  def self.most_followed_questions(n)
    Question.find_by(<<-SQL, n)
      SELECT
        questions.*, COUNT(question_followers.id)
      FROM
        question_followers
      JOIN
        questions ON question_followers.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_followers.id) DESC
      LIMIT
        (?)
    SQL
  end
end
