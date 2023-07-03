require_relative 'student'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    puts 'There is no book registered!' if @books.empty?
    @books.each_with_index do |book, index|
      puts "#{index}) Title: '#{book.title}', Author: #{book.author}"
    end
  end

  def list_people(with_number: false)
    puts 'There is no people registered!' if @people.empty?
    @people.each_with_index do |person, index|
      print "#{index}) " if with_number
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def add_teacher(age, name, specialization)
    @people << Teacher.new(age, specialization, name)
  end

  def add_student(age, name, parent_permission)
    @people << Student.new(age, '', name, parent_permission: parent_permission)
  end

  def add_book(title, author)
    @books << Book.new(title, author)
  end

  def add_rental(date, book_number, person_number)
    if [book_number, person_number].any?(&:negative?) || book_number >= @books.length || person_number >= @people.length
      return false
    end

    @books[book_number].add_rental(date, @people[person_number])
    true
  end

  def list_rentals_for_person_id(id)
    person = @people.select { |pers| pers.id == id }
    if person.empty?
      puts 'No rentals found for this ID'
      return
    end

    puts 'Rentals:'
    person[0].rentals.each do |rental|
      puts "Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}"
    end
  end
end
