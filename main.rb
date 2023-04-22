require_relative 'app'

class Main
  def initialize
    @app = App.new
    puts 'Welcome to School Library App!'
  end

  def menu
    puts %(
Please choose an option by enterin a number:
1 - List all books
2 - List all people
3 - Create a person
4 - Create a book
5 - Create a rental
6 - List all rentals for a given person id
7 - Exit)
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    unless %w[1 2].include?(person_type)
      puts 'Invalid option'
      return
    end
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    case person_type
    when '1'
      print 'Has parent permission? [Y/N]: '
      @app.add_student(age, name, gets.chomp.downcase == 'y')
    when '2'
      print 'Specialization: '
      @app.add_teacher(age, name, gets.chomp)
    end
    puts 'Person created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    @app.add_book(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @app.list_books
    book_id = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    @app.list_people(with_number: true)
    people_id = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    rental = @app.add_rental(date, book_id, people_id) ? 'Rental created successfully' : 'Invalid book or person ID'
    puts rental
  end

  def list_rentals_for_person_id
    print 'ID of person: '
    id = gets.chomp.to_i
    @app.list_rentals_for_person_id(id)
  end

  def list_books
    @app.list_books
  end

  def list_people
    @app.list_people
  end

  def run
    options = {
      '1' => :list_books, '2' => :list_people, '3' => :create_person,
      '4' => :create_book, '5' => :create_rental, '6' => :list_rentals_for_person_id,
      '7' => :break
    }
    loop do
      menu
      input = gets.chomp
      method = options[input]
      if method == :break
        break
      elsif method
        send(method)
      else
        puts 'Invalid option'
      end
    end
    puts 'Thank you for using this app!'
    exit
  end
end

library = Main.new
library.run
