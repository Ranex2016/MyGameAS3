package 
{  
    import flash.display.MovieClip;
    import flash.events.*;
    import flash.display.Stage;

	public class Hero extends MovieClip
	{
		//переменные разници расстояния координат от корабля до мышки
		public var xmove:Number;
		public var ymove:Number;
		public var speed:Number;
		public var lives:int = 5;
		
		public var ship:Ship_mc = new Ship_mc;
		
		public function Hero():void
		{
			init();
		}
		
		public function init():void
		{
			//Перемещение корабля
			ymove = (Math.abs(Math.abs(ship.y)-Math.abs(mouseY)))/7;
			xmove = (Math.abs(Math.abs(ship.x)-Math.abs(mouseX)))/7;
			//trace(xmove);
			
			if(ship.x<mouseX)
			{
				ship.x=ship.x+xmove;
				/*if(xmove>1)
				{
					ship.gotoAndStop(3);
				}
				
				else
				{
					ship.gotoAndStop(1);
				}*/
				
			}
			
			if(ship.x>mouseX)
			{
				ship.x=ship.x-xmove;
				/*if(xmove>1)
				{
					ship.gotoAndStop(2);
				}
				else
				{
					ship.gotoAndStop(1);
				}*/
				
			}
			
			if(ship.y<mouseY)
			{
				ship.y=ship.y+ymove;
			}
			
			if(ship.y>mouseY)
			{
				ship.y=ship.y-ymove;
			}
		}
	}
}