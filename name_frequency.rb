require_relative 'lib/name_frequency_sys'
require_relative 'lib/federative_unit'
require_relative 'lib/ranking_name'

welcome
menu
option = gets.chomp

loop do
  case option
  when '1'
    uf_list_menu
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