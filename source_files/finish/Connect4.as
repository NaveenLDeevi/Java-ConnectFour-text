package
{
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import caurina.transitions.Tweener;
	
	public class Connect4 extends Sprite
	{
		private var columns:uint;
		private var rows:uint;
		private var board:Array = new Array();
		private var columnWidth:uint;
		private var rowHeight:uint;
		private var currentPlayer:uint = 1;
		private var currentChip;
		
		public function Connect4(columns:uint,rows:uint):void
		{
			this.columns = columns
			this.rows = rows
			
			columnWidth = new BoardPiece().width
			rowHeight = new BoardPiece().height
			
			drawboard();
			createboardArray();
			putChipReady();
			this.addEventListener(MouseEvent.CLICK, boardClick)
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function drawboard():void
		{
			for(var i:uint = 0; i<rows; i++)
			{
				for(var j:uint = 0; j<columns; j++)
				{
					var boardpiece:BoardPiece = new BoardPiece();
					boardpiece.x = j * boardpiece.width;
					boardpiece.y = i * boardpiece.height;
					this.addChild(boardpiece);
				}
			}
		}
		
		private function createboardArray():void
		{
			for(var i:uint = 0; i<rows; i++)
			{
				board[i] = []
				for(var j:uint=0; j<columns; j++)
				{
					board[i][j] = 0;
				}
			}
		}
		
		private function putChipReady():void
		{
			if(currentPlayer == 1)
			{
				currentChip = new RedChip();
			}
			else
			{
				currentChip = new YellowChip();
			}
			currentChip.y = -50;
			this.addChildAt(currentChip,0);
		}
		
		private function boardClick(e:MouseEvent):void
		{
			var columnclicked:uint = calculateColumn(e.currentTarget.mouseX);
			
			for(var row:int=rows-1; row>=0; row--)
			{
				
				if(board[row][columnclicked]==0)
				{
					board[row][columnclicked] = currentPlayer;
					placeChip(new Point(row,columnclicked))
					if(checkForWinner(new Point(row,columnclicked)))
					{
						trace("WINNAAR");
						this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
						this.removeEventListener(MouseEvent.CLICK, boardClick);
						showWinnerDialog();
					}
					else
					{
						togglePlayer();
						putChipReady();
					}
					return
				}
			}
			
		}
		
		private function placeChip(position:Point):void
		{
			var distanceY:int = position.x * rowHeight + rowHeight/2;
			var distanceX:int = position.y * columnWidth + columnWidth/2;
			Tweener.addTween(currentChip, {x: distanceX, y:distanceY, time:0.7, transition:"easeOutBounce"});
		}
		
		private function enterFrameHandler(e:Event):void
		{
			var currentcolumn:uint = calculateColumn(this.mouseX);
			var xPosChip:uint = currentcolumn * columnWidth + columnWidth/2
			Tweener.addTween(currentChip, {x:xPosChip, time:0.3, transition:"lineair"});
		}
		
		private function checkForWinner(position:Point):Boolean
		{
			if(verticalCheck(position))return true;
    		if(horizontalCheck(position))return true;
    		if(leftUpDiagonalCheck(position))return true;
    		if(rightUpDiagonalCheck(position))return true;
    		return false;
		}
		
		function verticalCheck(position:Point):Boolean
		{
			var row:uint = position.x;
			var column:uint = position.y;
			var player:uint = board[row][column];
		
			if (row >= rows - 3)
			{
				return false;
			}
		
			for (var i:uint = row+1; i <= row + 3; i++)
			{
				if (board[i][column] != player)
				{
					return false;
				}
			}
			return true;
		}
		
		function horizontalCheck(position:Point):Boolean
		{
			var row:uint = position.x;
			var column:uint = position.y;
			var player:uint = board[row][column];
			var counter:uint = 1;
			
			for(var i:uint = column-1; i>=0; i--)
			{
				if(board[row][i] != player)
				{
					break;
				}
				counter++;
			}
			
			for(var j:uint = column+1; j<columns; j++)
			{
				if(board[row][j] != player)
				{
					break;
				}
				counter++;
			}
			
			if(counter >=4)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		function leftUpDiagonalCheck(position:Point):Boolean
		{
			var player:uint = board[position.x][position.y];
		
			var row:Number = position.x - 1;
			var column:Number = position.y - 1;
		
			var counter:uint = 1;
		
			while (row >= 0 && column >= 0)
			{
				if (board[row][column] == player)
				{
					counter++;
					row--;
					column--;
				} 
				else
				{
					break;            
				}
			}
		
			row = position.x + 1;
			column = position.y + 1;
		
			while (row < rows && column < columns)
			{            
				if (board[row][column] == player)
				{
					counter++;
					row++;
					column++;
				} 
				else
				{
					 break;
				}
			}
			if(counter >=4)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function rightUpDiagonalCheck(position:Point):Boolean
		{
			var player:uint = board[position.x][position.y];
		
			var row:Number = position.x + 1;
			var column:Number = position.y - 1;
		
			var counter:uint = 1;
		
			while (row < rows && column >= 0)
			{
				if (board[row][column] == player)
				{
					counter++;
					row++;
					column--;
				} 
				else
				{
					break;            
				}
			}
		
			row = position.x - 1;
			column = position.y + 1;
		
			while (row >= 0 && column < columns)
			{            
				if (board[row][column] == player)
				{
					counter++;
					row--;
					column++;
				} 
				else
				{
					 break;
				}
			}
			if(counter >=4)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function showWinnerDialog():void
		{
			var dialog:WinnerDialog = new WinnerDialog();
			var winner:String = (currentPlayer == 1)? "red" : "yellow"
			dialog.txtWinner.text = winner + " wins!!!";
			dialog.x = (this.width - dialog.width)/2;
			dialog.y = 100;
			this.addChild(dialog);
		}
		
		//helpfunctions
		private function togglePlayer():void
		{
			if(currentPlayer == 1)
			{
				currentPlayer = 2
			}
			else
			{
				currentPlayer = 1
			}
		}
		
		private function calculateColumn(mouseXPos):uint
		{
			if(mouseXPos < 0)
			{
				return 0;
			}
			else if(mouseXPos > this.width)
			{
				return columns - 1;
			}
			else
			{
				return mouseXPos/columnWidth;
			}
		}
	}
}