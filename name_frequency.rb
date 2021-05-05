require_relative 'lib/name_frequency_sys'
require_relative 'lib/federative_unit'

welcome
menu
option = gets.chomp

loop do
  case option
  when '1'
    uf_list
    option = gets.chomp
  when '0'
    puts 'até mais'
    break
  else
    puts 'Opção invalida'
  end

  menu
  option = gets.chomp
end