require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'
require 'json'

# rubocop:disable all
# This is the main entry point for the app
class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end
  
  def run
    load_data
    
    puts "Welcome to School Library App!\n\n"

    option = nil
    while option != 7 
      puts 'Please choose an option by entering a number:'
      menu_options

      print '(Option number): '

      option = gets.chomp.strip.to_i
      select_options(option)
      puts
    end

    puts 'Closing Application...'
    puts 'Saving data to file...'
    save_data_to_file
  
    puts 'Good Bye!'
  end
  
   #Generate json for books
   #Write generated json to file
  def save_data_to_file
    save_books_data_to_file
    save_person_data_to_file
    save_rental_data_to_file
  end

  def save_books_data_to_file
    books_list = @books.map { |book| book.to_h }
    books_json = JSON.generate(books_list)
    file = File.new("books.json", "w")
    file.write(books_json)
    file.close
  end

  def save_person_data_to_file
    people_list = @people.map { |person| person.to_h }
    people_json = JSON.generate(people_list)

    file = File.new("people.json", "w")
    file.write(people_json)
    file.close
  end

  def save_rental_data_to_file
    rentals_list = @rentals.map { |rental| rental.to_h }
    rental_json = JSON.generate(rentals_list)

    file = File.new("rental.json", "w")
    file.write(rental_json)
    file.close
  end

  def load_data
    #load data from all the three files
    load_books 
    load_student
    load_teacher
    load_rentals
  end

  def load_books
    begin
      file = File.open("books.json")
      json_data = file.read
      parsed_data = JSON.parse(json_data)
      file.close

      @books = parsed_data.map do |book_data|
        Book.new(title: book_data['title'], author: book_data['author'])
      end
    rescue StandardError
      @books = []
    end
  end

  def load_student
    begin
      file = File.open("people.json")
      json_data = file.read
      parsed_data = JSON.parse(json_data)
      file.close
      
      @people = parsed_data.map do |person_data|
        Student.new(age: person_data['age'], name: person_data['name'], parent_permission: person_data['permission'])
      end
    rescue StandardError
      @people = []
    end
  end

  def load_teacher
    begin
      file = File.open("people.json")
      json_data = file.read
      parsed_data = JSON.parse(json_data)
      file.close

      @people = parsed_data.map do |person_data|
        Teacher.new(age: person_data['age'], name: person_data['name'], specialization: person_data['specialization'])
      end
    rescue StandardError
      @people = []
    end
  end

  def load_rentals
    begin
      file = File.open("rentals.json")
      json_data = file.read
      parsed_data = JSON.parse(json_data)
      file.close

      @rentals = parsed_data.map do |rental_data|
        Rentals.new(date: rental_data['date'], book: rental_data['book'], person: rental_data['person'])
      end
    rescue StandardError
      @rentals = []
    end
  end

  def menu_options
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person'
    puts '7 - Exit'
  end

  def select_options(option)
    case option
    when 1
      list_all_books
    when 2
      list_all_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_all_rentals
    when 7
      nil
    else
      invalid_option
    end
  end

  def list_all_books
    key = 1
    puts
    puts 'Books'.upcase
    puts
    puts 'No book yet! Choose option 4 to add a book ' if @books.empty?
    
    @books.each do |book|
      puts "#{key} - #{book.title} by #{book.author}"
      key += 1
    end
  end

  def list_all_people
    key = 1
    puts
    puts 'People'.upcase
    puts
    puts 'No people yet! Choose option 3 to add a person ' if @people.empty?
    
    @people.each do |person|
      print "#{key} - [#{person.class.name} ID]: #{person.id} Name: #{person.name} "
      print "Parent Permission: #{person.parent_permission}" if person.is_a?(Student)
      print "Specialization: #{person.specialization}" if person.is_a?(Teacher)
      puts
      key += 1
    end
  end

  def create_person
    entry = nil
    print 'Choose option 1 to create a Student or option 2 for a Teacher: '
    
    until [1, 2].include?(entry)
      entry = gets.chomp.strip.to_i
      puts
      puts 'Choose option 1 for Student or option 2 for Teacher' unless [1, 2].include?(entry)
    end

    case entry
    when 1
      create_student
    when 2
      create_teacher
    end
  end

  def create_student
    print 'Enter Age: '
    age = -1
    while age <= 0
      age = gets.chomp.to_i
      print 'Enter valid age for student: ' if age <= 0
    end

    print 'Enter Name: '
    name = gets.chomp.strip.capitalize

    print 'Does student have parent permission? (Y/N): '
    permission = gets.chomp.strip.upcase

    case permission
    when 'Y', 'YES'
      permission = true
    when 'N', 'NO'
      permission = false
    end
    @people << Student.new(age: age, name: name, parent_permission: permission, classroom: nil)
    puts
    puts 'New student created successfuly!'
    puts
  end

  def create_teacher
    age = -1
    print 'Enter Age: '
    while age <= 0
      age = gets.chomp.to_i
      print 'Enter valid age for teacher: ' if age <= 0
    end

    print 'Enter name: '
    name = gets.chomp.strip.capitalize

    print 'Enter specialization: '
    specialization = gets.chomp.strip.capitalize

    @people << Teacher.new(age: age, name: name, specialization: specialization)
    puts 'New teacher created successfuly!'
  end

  def create_book
    print 'Enter title: '
    title = gets.chomp.strip.capitalize

    print 'Enter author: '
    author = gets.chomp.strip.capitalize

    @books << Book.new(title: title, author: author)
    puts
    puts 'New book was created successfully!'
    puts
  end

  def create_rental
    list_all_books

    print 'Select the key of the book: '
    
    selected_book = gets.chomp.chomp.to_i

    list_all_people

    print 'Select the key of the person: '
    selected_person = gets.chomp.chomp.to_i

    print 'Select the date: (Year/Month/Day): '

    date = gets.chomp.strip
    book = @books[selected_book]
    person = @people[selected_person]
    new_rental = Rental.new(date: date, book: book, person: person)
    @rentals.push(new_rental)
    
    puts
    puts 'Rental was created successfuly!'
    puts
  end

  def list_all_rentals
    puts
    list_all_people
    puts 'Choose person ID: '
    entry = gets.chomp.to_i

    puts 'Rentals'.upcase
    puts
    @people.each do |person|
      next unless person.id == entry

      @rentals.each do |rental|
        puts "Rental date: #{rental.date} - #{rental.book.title} by #{rental.person.name}"
      end
    end
  end

  def invalid_option
    puts 'Invalid option! '
    puts "Please enter a valid option from the following: \n"
    menu_options
  end
end
