# Java-ConnectFour-text
Java Connect Four game in text result.
This application is a extended form of famous connect four game, this is a GUI-based application allowing customization of the game board and victory conditions.
following are the functionalities that are desired in development of the application,
1)	Provide GUI objects for players to:
a.	Enter Player 1’s name
b.	Enter Player 2’s name
c.	Have the option to randomize play order prior to game start
d.	Make moves (still dropping pieces into columns as in Connect Four)
e.	Specify the dimensions of the board: rectangular with:
i.	Between 4 and 12 rows
ii.	Between 4 and 15 columns
iii.	Specify the number of placements in a row required for victory: At least 3 and less than the number of rows or columns
2)	Players make moves by using mouse and clicking on squares (assume “hotseat”, where both players take turns using the mouse)
3)	Display the game board in a JFrame object, both before the game and updated after each move. Output should include:
a.	Which squares are unclaimed
b.	Player 1 moves shown as solid red circles
c.	Player 2 moves shown as solid yellow circles
d.	Borders around each square and the entire board for easier board-reading
4)	After each move, the game should check for victory or a tie
5)	Game should conclude with a dialog box including:
a.	Announcement of result and congratulations to winner (if any)
b.	Set of GUI objects for selecting repeat play by the two players, with the options of randomized, reversed, or repeated play order
c.	GUI object for selecting new game (with changes to board, players, or victory requirements)
6)	Attempting to close the window should:
a.	Before or after a game: Close the window and exit the game.
b.	During a game: Provide a dialog box asking if the player really wants to quit and options for closing the window (and aborting the game) or not.
Program Code Constraints
There should be only one class, GuiApp. Each of the required functionalities should be implemented as separate methods (as far as possible) and operate by passing parameters and/or returning values (e.g., inputting player 1’s name should call a method that returns whatever String the user entered). Comments should be provided for the class and for each variable and method, explaining their usage. You can assume players only enter valid inputs for game parameters but the program should explicitly prevent impossible moves (i.e., dropping a piece into a full column). Additionally, any relevant deficiencies in gameplay from the previous assignment should be corrected.
