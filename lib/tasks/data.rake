namespace :exel do 

  task :greet do
     puts "Hello world"
  end

  task open: :environment do
    workbook = Roo::Spreadsheet.open('lib/tasks/users.xlsx')
    password_length = 6
    password = Devise.friendly_token.first(password_length)
    p password
    username = "#{workbook.row(5)[0]}#{workbook.row(5)[1]}".slice!(0..7).downcase
    p username
    test_user = User.create!(email: 'someone@something.com', 
                 f_name: workbook.row(5)[0], 
                 l_name: workbook.row(5)[1],
                 username: username,
                 validity_date: workbook.row(5)[3],
                 :password => password, 
                 :password_confirmation => password)
    if User.all.count == 1
      puts "lose"
    else
      puts "win"
    end
    p test_user
  end
end