require './questions_database'
require './table'
require_relative 'question'

class QuestionLike < Table
  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id, @user_id, @question_id=
       options.values_at('id', 'user_id', 'question_id')
  end

  def self.find_by_id(id)
    QuestionLike.find_by(<<-SQL, id).first
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = (?)
    SQL
  end

  def self.likers_for_question_id(question_id)
    User.find_by(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = (?)
    SQL
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      JOIN
        users ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = (?)
    SQL

    results.first["COUNT(*)"]
  end

  def self.liked_questions_for_user_id(user_id)
    Question.find_by(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
       question_likes ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = (?)
    SQL
  end

  def self.most_liked_questions(n)
    Question.find_by(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_likes.id) DESC
      LIMIT
        (?)
    SQL
  end
end
