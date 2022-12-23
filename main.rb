require "./main_application.rb"

print 'Введіть сайт який хочете парсити: '
url = gets.chomp
print 'Введіть кількість сторінок: '
page = gets.chomp.to_i
    
if 0 < page > 100
    main = Main_application.new(url, page)
    main.start() 
else
    main = Main_application.new(url)
    main.start() 
end

