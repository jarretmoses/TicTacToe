require "io/console" #importing library for

#--------------------------------------------------------------
#**************************************************************
# Program:     TTT.rb
# Programmer:  Jarret Moses
#
#
# Overview:    Simple Tic-Tac-Toe game where a player must get 
#              3 in a row to win or the result is a tie when no
#              moves are left. You will have choice of first move.
#              This particular program was written to run through 
#              terminal. Simply type 'ruby TTT.rb' to run the 
  #               
#
#
#**************************************************************
#--------------------------------------------------------------


#--------------------------------------------------------------
#         Tutorial function teaching how to play
#--------------------------------------------------------------
def tutorial
  puts "Before we begin, here is some helpful information to know"
  puts "about this game..."
  puts
  puts "To choose your move simply press the value corresponding to\nits position on the following grid and press 'ENTER'"
  puts
  puts "When your value is enetered it will not appear on the screen\nso don't be alarmed because it is there :)"
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
  readyToStart #call function to start game
end
#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------


#--------------------------------------------------------------
#    Function checking if player is ready to begin
#--------------------------------------------------------------
def readyToStart
  answer = gets.chomp.downcase #obtain input to console
  if answer == 'y' 
    system('clear')
	  puts "YAY!, would you like to go first?(y/n)"
    firstMove #go on to decide who gets first move
  elsif answer == 'n' #exit game
    puts
    puts "Alrighty, feel free to come back whenever you like"
	  puts "Have a great day(or night)!"
    puts
  else
	  puts "Please enter a correct response(y/n)"
	  readyToStart 
  end
end



#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------

#--------------------------------------------------------------
#    Function to decide whose turn it is first
#--------------------------------------------------------------

def firstMove 
  response = gets.chomp.downcase
  if response == 'y'
    game 'P', 'C'
    exit
  elsif response == 'n'
    game 'C', 'P'
    exit
  else
    puts
    puts "Please enter a valid response (y/n)"
    firstMove
  end
end

#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------


#--------------------------------------------------------------
#                      Main Game function
#--------------------------------------------------------------
def game player1, player2

  # ---------------Data structures for game -------------------
  # initialing game_array for new game to be used to keep track and check moves made
  $game_array = [[' ',' ',' '],
                 [' ',' ',' '],
                 [' ',' ',' ']]
  #array to store the moves that are left             
  $moves_left  = [1,2,3,4,5,6,7,8,9]
  # -----------------------------------------------------------

 #clearing screen for new game
  system('clear')
  done = false
  
  #loop created to keep game going until either someone wins or its a tie
  while !done
  	printboard #display most recent board
    

    if player1 == 'P' #player goes first if they are player 1
      puts
      puts "It is your turn"
      safe_pick = playerMove  #variable set to response of player's move (true means a valid move was made)
      #checking for proper input
      while !safe_pick
        puts
        puts "You cannot move here please select a different location(1-9)"
        safe_pick = playerMove 
      end
    else #player1 is the CPU
      puts
      puts "It is the computer's turn"
      cpuMove
      sleep(1.5)   #time delay for CPU move (just for a more fluid experience)
    end


    puts
    system('clear')
    printboard #print board after player's move
    
    #check for player1 win
     winCheckDecide player1
     tieCheck

    if player1 == 'C' #player 2's turn
      puts "It is your turn"
      safe_pick = playerMove
      while !safe_pick
        puts
        puts "You cannot move here please select a different location(1-9)"
        safe_pick = playerMove 
      end
    else
      puts "It is the computer's turn"
      cpuMove
      sleep(1.5)   #time delay for CPU move (just for a more fluid experience)
    end

    winCheckDecide player2
    tieCheck #check for a tie
      
  system('clear')
  end
end

#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------

#--------------------------------------------------------------
#         Function for checking and placing player's move
#--------------------------------------------------------------
def playerMove
	#enter value of where to go
	move = STDIN.noecho(&:gets).chomp.to_i #hiding value being inpute on screen
    if $moves_left.index(move) == nil #not a valid move
      return false
    else
      conv_move = moveConvert move
      $game_array[conv_move[0]][conv_move[1]] = 'X' #adding move to game array for move checking and grid printing
      removeNum move #remove value from the moves_left array
    end
    return true
end

#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------

#--------------------------------------------------------------
#         Function for checking and placing CPU's move
#--------------------------------------------------------------
def cpuMove 
  	# first need to check if cpu has a move to win
  moves_length = $moves_left.length.to_i

  	#First, check if computer has a move to win it
  (boardCheck 'O', 'O', ' ')
  if (moves_length > $moves_left.length.to_i)
    return 
  end

    #if cpu can't win check if they need to block
	(boardCheck 'X', 'X', ' ')  #2 in a row check for cpu block
	if (moves_length > $moves_left.length.to_i)
    return 
  end			

    #if neither of the other cases pass, check for "best" move
	(boardCheck 'O', ' ', ' ')  #1 'O' with 2 blanks to move towards a win
	if (moves_length > $moves_left.length.to_i)
    return 
  end
 		
 	#if no other case works, cpu can go wherever / remove that value from moves left array
  cpu_move = rand(0..$moves_left.length-1).to_i
  conv_move = moveConvert $moves_left[cpu_move]
  $game_array[conv_move[0]][conv_move[1]] = 'O'
  removeNum $moves_left[cpu_move]
end

#--------------------------------------------------------------
#           Function for checking for a tie
#--------------------------------------------------------------
def tieCheck
#if moves_left array has length of zero then there are no moves to be made, resulting in a tie
  if $moves_left.length == 0
  	system('clear')
  	printboard
  	puts
    puts "******************IT'S A TIE******************"
    puts "**********************************************"
    puts
    replay
    exit #exiting program
  end
end

#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------

#--------------------------------------------------------------
#         Function for checking a player win
#--------------------------------------------------------------
def playerWinCheck
  if (boardCheck 'X', 'X', 'X') #checks grid for any combo of 3 of a row of 'X'
    system('clear')
    printboard
    puts
    puts "**************YOU WIN, NICE JOB!**************"
    puts "**********************************************"
    puts
    replay
    exit 
  end
end

#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------


#--------------------------------------------------------------
#         Function for checking a cpu win
#--------------------------------------------------------------
def cpuWinCheck
  if (boardCheck 'O', 'O', 'O')
    system('clear')
    printboard
    puts
    puts "**************THE COMPUTER WINS***************"
    puts "**********************************************"
    puts
    replay
    exit
  end
end

#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------

#--------------------------------------------------------------
#         Function for which check to perform
#--------------------------------------------------------------
def winCheckDecide who
  if who == 'P'
    playerWinCheck
  else
    cpuWinCheck
  end
end

#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------

#--------------------------------------------------------------
#       Function asking if player would like to play again
#--------------------------------------------------------------

def replay
  puts "Would you like to play again?"
  readyToStart
end

#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------

#--------------------------------------------------------------
#         Function for checking board X/O placement based
#		      on inputs a,b, and c. The Matrix locations represent
#         the positions on tic-tac-toe grid, [0][0] = 1,
#         [1][0] = 4, [2][0] = 7 etc... This function will
#         check through all combinations of the grid to see if 
#         they comply with the inputs a,b,c which will be a
#         combination (or not) of 'X', 'O' and ' ' depending 
#         on what was called to be look for
#          
#--------------------------------------------------------------
def boardCheck a,b,c
  win = false	
  if $game_array[0][0] == a && $game_array[0][1] == b && $game_array[0][2] == c 
  	if a == c #3 in a row
  	  win = true #stricly for a win check
  	else	
	  $game_array[0][2] = 'O'
	  removeNum 3 #[0][3] corresponds to 3 on game grid
	end
  elsif $game_array[0][0] == a && $game_array[0][2] == b && $game_array[0][1] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[0][1] = 'O'
	  removeNum 2
	end
  elsif $game_array[0][1] == a && $game_array[0][2] == b && $game_array[0][0] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[0][0] = 'O'
	  removeNum 1
	end
  elsif $game_array[1][0] == a && $game_array[1][1] == b && $game_array[1][2] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[1][2] = 'O'
	  removeNum 6
	end
  elsif $game_array[1][0] == a && $game_array[1][2] == b && $game_array[1][1] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[1][1] = 'O'
	  removeNum 5
	end
  elsif $game_array[1][1] == a && $game_array[1][2] == b && $game_array[1][0] == c 
  	if a == c
  	  win = true
  	else	
      $game_array[1][0] = 'O'
      removeNum 4
  end
  elsif $game_array[2][0] == a && $game_array[2][1] == b && $game_array[2][2] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[2][2] = 'O'
	  removeNum 9
	end
  elsif $game_array[2][0] == a && $game_array[2][2] == b && $game_array[2][1] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[2][1] = 'O'
	  removeNum 8
	end
  elsif $game_array[2][1] == a && $game_array[2][2] == b && $game_array[2][0] == c 
  	if a == c
  	  win = true
  	else	
      $game_array[2][0] = 'O'
      removeNum 7
    end
  elsif $game_array[0][0] == a && $game_array[1][0] == b && $game_array[2][0] == c 
  	if a == c
  	  win = true
  	else	
      $game_array[2][0] = 'O'
      removeNum 7
    end
  elsif $game_array[0][0] == a && $game_array[2][0] == b && $game_array[1][0] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[1][0] = 'O'
	  removeNum 4
	end
  elsif $game_array[1][0] == a && $game_array[2][0] == b && $game_array[0][0] == c 
  	if a == c
  	  win = true
  	else	
     $game_array[0][0] = 'O'
     removeNum 1
    end
  elsif $game_array[0][1] == a && $game_array[1][1] == b && $game_array[2][1] == c 
  	if a == c
  	  win = true
  	else	
     $game_array[2][1] = 'O'
     removeNum 8
    end
  elsif $game_array[0][1] == a && $game_array[2][1] == b && $game_array[1][1] == c 
  	if a == c
  	  win = true
  	else	
	 $game_array[1][1] = 'O'
	 removeNum 5
	end
  elsif $game_array[1][1] == a && $game_array[2][1] == b && $game_array[0][1] == c 
  	##########
  	if a == c
  	  win = true
  	else	
	$game_array[0][1] = 'O'
	removeNum 2
    end
  elsif $game_array[0][2] == a && $game_array[1][2] == b && $game_array[2][2] == c 
  	if a == c
  	  win = true
  	else	
      $game_array[2][2] = 'O'
      removeNum 9
    end
  elsif $game_array[0][2] == a && $game_array[2][2] == b && $game_array[1][2] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[1][2] = 'O'
	  removeNum 6
	end
  elsif $game_array[1][2] == a && $game_array[2][2] == b && $game_array[0][2] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[0][2] = 'O'
	  removeNum 3
	end
  elsif $game_array[0][0] == a && $game_array[1][1] == b && $game_array[2][2] == c 
  	if a == c
  	  win = true
  	else	
      $game_array[2][2] = 'O'
      removeNum 9
    end
  elsif $game_array[0][0] == a && $game_array[2][2] == b && $game_array[1][1] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[1][1] = 'O'
	  removeNum 5
	end
  elsif $game_array[1][1] == a && $game_array[2][2] == b && $game_array[0][0] == c 
  	if a == c
  	  win = true
  	else
      $game_array[0][0] = 'O'
      removeNum 1
    end
  elsif $game_array[0][2] == a && $game_array[1][1] == b && $game_array[2][0] == c 
  	if a == c
  	  win = true
  	else	
      $game_array[2][0] = 'O'
      removeNum 7
    end
  elsif $game_array[0][2] == a && $game_array[2][0] == b && $game_array[1][1] == c 
  	if a == c
  	  win = true
  	else	
	  $game_array[1][1] = 'O'
	  removeNum 5
	end
  elsif $game_array[1][1] == a && $game_array[2][0] == b && $game_array[0][2] == c 
  	if a == c
  	  win = true
  	else	
      $game_array[0][2] = 'O'
      removeNum 3
    end
  end
  return win
end


#--------------------------------------------------------------
#**************************************************************
#--------------------------------------------------------------

#--------------------------------------------------------------
#        Function for converting move into grid location 
#        (as according to printboard function)
#--------------------------------------------------------------
def moveConvert num
  case num
    when 1
      num = [0,0]
    when 2
      num = [0,1]
    when 3
      num = [0,2]	
    when 4
      num = [1,0]	
    when 5
      num = [1,1]	
    when 6
      num = [1,2]	
    when 7
      num = [2,0]	
    when 8
      num = [2,1]	
    when 9
      num = [2,2]	
    else
      num = -1; #incase input value is incorrect(which shouldn't ever happen)
  end
  return num 
end

#------------------------------------------------------------------------
#************************************************************************
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#         function to remove move from check array
#------------------------------------------------------------------------

def removeNum num
  remove = $moves_left.index(num).to_i # finding index of value to be removed
  $moves_left.slice!(remove) #removing value from moves_left array 
end

#------------------------------------------------------------------------
#************************************************************************
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#    function to print the game board with up to date moves to screen
#------------------------------------------------------------------------
def printboard
  xo_rows   = [1,4,7] #columns where 'X' or 'O' may need to be printed
  xo_cols   = [2,8,14] #rows where 'X' or 'O' may need to be printed
  col_line  = [5,11] #points to print '|'
  row_line  = [2,5]
  x_index   = 0 # x coordinate for game_array
  y_index   = 0 # y coordiante for game array
  
  for i in 0..7  #row loop
    for j in 0..17  #column loop
  	  if xo_cols.index(j) != nil && xo_rows.index(i) != nil #at a spot to print X O or nothing
        if y_index == 3 #have reached the end of row
       	  x_index += 1 #increment to next row
       	  y_index = 0 #reset column to 0
        end
  	      print $game_array[x_index][y_index] #print whatever is in the $games_array slot with these indexes
  	      y_index+=1 #increment column
  	  elsif row_line.index(i) != nil #if at a row that needs '-'
  	    if col_line.index(j) != nil # only time not to print '-' in this specific row
  		  print ' '
  		else
  		  print '-' #board horizontal lines
  		end
  	  elsif col_line.index(j) != nil #case to print vertical lines
  		print '|'
  	  else 
        print ' ' #else just print a space
  	  end
    end
  puts #strictly for a new space after board prints for better visual
  end
end
#------------------------------------------------------------------------
#************************************************************************
#------------------------------------------------------------------------

#=============== OPENING MESSAGE/CALL WHEN GAME IS RUN ==================
puts
puts "Welcome to Jarret's amazing game of Tic-Tac-Toe"
#run tutorial of how to play
tutorial
