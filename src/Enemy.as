package 
{  
    import flash.display.MovieClip;
    import flash.events.*;
    import flash.display.Stage;
	import flash.utils.Timer;

	public class Enemy extends MovieClip
	{
		//переменные
		public var speed:Number = 1;
		public var lives:int = 5;
		
		public var ship:Enemy_mc = new Enemy_mc;
		public var bullet:Bullet_mc = new Bullet_mc;
		
		public function Enemy():void
		{
			ship.x = 10 + Math.random() * 600;
			init();
		}
		
		public function addBullet():void
		{
			
			bullet.x = 200;
			bullet.y = 200;
			bullet.hp = 1;
			trace("создаем пули");
		}
		
		public function init():void
		{
			//Перемещение корабля
			ship.y = ship.y + speed;
			if (ship.y > 500)
			{
				ship.y = 0;
				ship.x = 10 + Math.random() * 600;
			}
			
		}
	}
}