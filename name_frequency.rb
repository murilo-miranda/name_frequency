require_relative 'lib/system'
require_relative 'db/connection'
require_relative 'app/views/display'

welcome
menu
option = gets.chomp

loop do
  case option
  when '1'
    uf_list_menu
  when '2'
    city_list_menu
  when '3'
    frequency_list_menu
  when '0'
    puts 'até mais'
    break
  else
    puts 'Opção invalida'
  end

  menu
  option = gets.chomp
end
