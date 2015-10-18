require 'roo'
namespace :exel do 

  task load_users: :environment do
    valid = 0
    not_valid = 0
    puts "Podaj nazwę pliku z rozszerzeniem:"
    file = STDIN.gets.strip
    workbook = Roo::Spreadsheet.open("lib/tasks/#{file}", extension: :xlsx)  
    puts "File opened successfully"    
    (2..workbook.last_row).each do |i|
      pass = password
      username = "#{workbook.row(i)[0].slice(0..2).mb_chars.downcase.to_s}#{workbook.row(i)[1].slice(0..2).mb_chars.downcase.to_s}"+(0...2).map { ('a'..'z').to_a[rand(26)] }.join
      if User.where( f_name: workbook.row(i)[0].mb_chars.capitalize.to_s, l_name: workbook.row(i)[1].mb_chars.titleize.to_s).blank?
        user = User.new( f_name: workbook.row(i)[0].mb_chars.capitalize.to_s,
                         l_name: workbook.row(i)[1].mb_chars.titleize.to_s,
                         email: workbook.row(i)[2].mb_chars.downcase.to_s,
                         username: username,
                         validity_date: workbook.row(5)[3],
                         password: pass,
                         password_confirmation: pass)
        if user.valid? && user.new_record?
          user.save
          valid += 1
        else
          not_valid += 1
          puts "Row #{i}. User not valid, #{user.errors.messages}"
        end
      end
    end
    check_all_load(not_valid)
    puts "Created #{valid} valid accounts"
    puts "#{not_valid} Accounts were not created"    
  end

  def password
    password_length = 6
    password = Devise.friendly_token.first(password_length)
  end

  def check_all_load(val)
    if val > 0
       puts "Do you wish to load file again? (y/n)"
       answer = STDIN.gets.strip()
       if answer == ('y') 
        Rake::Task["exel:load_users"].reenable
        Rake::Task["exel:load_users"].invoke
      end
    end
  end
end