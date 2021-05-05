require_relative 'lib/name_frequency_sys'

welcome
menu
option = gets.chomp

loop do
  case option
  when '1'
    puts 'murilo'
  when '0'
    puts 'até mais'
    break
  else
    'Opção invalida'
  end

  menu
  option = gets.chomp
end