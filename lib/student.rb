require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(id = nil, name, grade)
    @name = name
    @grade = grade.to_i
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create(name, grade)
    Student.new(name, grade)
  end

  def self.new_from_db(array)
    Student.new(array[0][0], array[0][1], array[0][2])
  end

  def update 
    sql = <<-SQL
      SELECT * 
      FROM students
      WHERE id = ?
    SQL 
    DB[:conn].execute(sql, self.id)

end
