package 
{  
    import flash.display.MovieClip;
    import flash.events.*;
    import flash.display.Stage;

	public class Hero extends MovieClip
	{
		//переменные разници расстояния координат от корабля до мышки
		public var xmove:int=0;
		public var ymove:int=0;
		//public var speed:Number = 1;
		//public var acceleration:Number = 2;
		
		//public var friction:Number = 0.9;
		public var lives:int = 5;
		
		public var ship:Ship_mc = new Ship_mc;
		
		public function Hero():void
		{
			init();
		}
		
		public function init():void
		{
			//Растояние от коробля до мышки
			ymove = (Math.abs(Math.abs(ship.y)-Math.abs(mouseY)))/8;
			xmove = (Math.abs(Math.abs(ship.x) - Math.abs(mouseX)))/ 8;
			
			//speed += acceleration;
			
			if(ship.x<mouseX)
			{
				ship.x += xmove;
			}
			
			if(ship.x>mouseX)
			{	
				ship.x -= xmove;	
			}
			
			if(ship.y<mouseY)
			{
				ship.y += ymove;
			}
			
			if(ship.y>mouseY)
			{
				ship.y -= ymove;
			}
			
		}
	}
}