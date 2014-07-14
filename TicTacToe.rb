#main game function
def game
  
end

#function to start/exit game
def tutorial
  puts "Before we begin, here is some helpful information to know"
  puts "about this game..."
  puts "To choose your move simply press the value corresponding to\nits position on the following grid"
  puts
  puts "
			     |     |          
			  1  |  2  |  3  
			----- ----- -----
			     |     |
			  4  |  5  |  6  
			----- ----- -----
			     |     |
			  7  |  8  |  9
			"
  puts
  puts "Are you ready to begin?(y/n)"
  readyStart #call function to start game
end

def readyToStart
  answer = gets.chomp
  if answer.downcase == 'y'
    # initialing game_array for new game to be used to keep track and check moves made
      $game_array = [[' ',' ',' '],
                     [' ',' ',' '],
                     [' ',' ',' ']]

		  # Begin Game
	  game

  elsif answer.downcase == 'n' 
    puts "Aww...too bad, feel free to come back when you are ready"
	puts "Have a great day(or night)!"
  else
	puts "Please enter a correct response(y/n)"
	readyToStart answer
   end
end

def boardCheck
  if $game_array[0][0] == 'x' && $game_array[0][1] == 'x' && $game_array[0][2] == ' ' 
	#comp goes 0,2
  elsif game_array[0][0] == 'x' && $game_array[0][2] == 'x' && $$game_array[0][1] == ' ' 
	#comp goes 0,1
  elsif $game_array[0][1] == 'x' && $game_array[0][2] == 'x' && $game_array[0][0] == ' ' 
	#comp goes 0,0
  elsif $game_array[1][0] == 'x' && $game_array[1][1] == 'x' && $game_array[1][2] == ' ' 
	#comp goes 1,2 
  elsif $game_array[1][0] == 'x' && $game_array[1][2] == 'x' && $game_array[1][1] == ' ' 
	#comp goes 1,1
  elsif $game_array[1][1] == 'x' && $game_array[1][2] == 'x' && $game_array[1][0] == ' ' 
    #comp goes 1,0
  elsif $game_array[2][0] == 'x' && $game_array[2][1] == 'x' && $game_array[2][2] == ' ' 
	#comp goes 2,2
  elsif $game_array[2][0] == 'x' && $game_array[2][2] == 'x' && $game_array[2][1] == ' ' 
	#comp goes 2,1
  elsif $game_array[2][1] == 'x' && $game_array[2][2] == 'x' && $game_array[2][0] == ' ' 
    #comp goes 2,0
  elsif $game_array[0][0] == 'x' && $game_array[1][0] == 'x' && $game_array[2][0] == ' ' 
    #comp goes 2,0
  elsif $game_array[0][0] == 'x' && $game_array[2][0] == 'x' && $game_array[1][0] == ' ' 
	#comp goes 1,0
  elsif $game_array[1][0] == 'x' && $game_array[2][0] == 'x' && $game_array[0][0] == ' ' 
   #comp goes 0,0
  elsif $game_array[0][1] == 'x' && $game_array[1][1] == 'x' && $game_array[2][1] == ' ' 
    #comp goes 2,1
  elsif $game_array[0][1] == 'x' && $game_array[2][1] == 'x' && $game_array[1][1] == ' ' 
	#comp goes 1,1
  elsif $game_array[1][1] == 'x' && $game_array[1][2] == 'x' && $game_array[0][1] == ' ' 
	#comp goes 0,1
  elsif $game_array[0][2] == 'x' && $game_array[1][2] == 'x' && $game_array[2][2] == ' ' 
    #comp goes 2,2
  elsif $game_array[0][2] == 'x' && $game_array[2][2] == 'x' && $game_array[1][2] == ' ' 
	#comp goes 1,2
  elsif $game_array[1][2] == 'x' && $game_array[2][2] == 'x' && $game_array[0][2] == ' ' 
	#comp goes 0,2
  elsif $game_array[0][0] == 'x' && $game_array[1][1] == 'x' && $game_array[2][2] == ' ' 
    #comp goes 2,2
  elsif $game_array[0][0] == 'x' && $game_array[2][2] == 'x' && $game_array[1][1] == ' ' 
	#comp goes 1,1
  elsif $game_array[1][1] == 'x' && $game_array[2][2] == 'x' && $game_array[0][0] == ' ' 
    #comp goes 0,0
  elsif $game_array[0][2] == 'x' && $game_array[1][1] == 'x' && $game_array[2][0] == ' ' 
    #comp goes 2,0
  elsif $game_array[0][2] == 'x' && $game_array[2][0] == 'x' && $game_array[1][1] == ' ' 
	#comp goes 1,1
  elsif $game_array[1][1] == 'x' && $game_array[2][2] == 'x' && $game_array[0][0] == ' ' 
    #comp goes 0,0
  end
  return
end

#function to print the game board with up to date moves
def printboard
  xo_rows   = [1,4,7] #columns where 'X' or 'O' may need to be printed
  xo_cols   = [2,8,14] #rows where 'X' or 'O' may need to be printed
  col_line  = [5,11] #points to print '|'
  row_line  = [2,5]
  x_count = 0 # x coordinate for game_array
  y_count = 0 # y coordiante for game array

  for i in 0..7 
    for j in 0..17 
  	  if xo_cols.index(j) != nil && xo_rows.index(i) != nil #at a spot to print X O or nothing
        if y_count == 3 #have reached the end of row
       	  x_count +=1 #increment to next row
       	  y_count = 0 #reset column to 0
        end
  	      print game_array[x_count][y_count]
  	      y_count +=1 #increment column
  	  elsif row_line.index(i) != nil
  	    if col_line.index(j) != nil
  		  print ' '
  		else
  		  print '-'
  		end
  	  elsif col_line.index(j) != nil
  		print '|'
  	  else 
        print ' ' 
  	  end
    end
  puts
  end
end

puts "Welcome to the most amazing game of Tic-Tac-Toe"
tutorial



