package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage; 
	import flash.display.StageAlign; 
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

	
	
	//[SWF(width="640", height="480", backgroundColor="0x000000", frameRate="45")]
	final public class Main extends Sprite 
	{	
		
	    //Объявление переменных
		
		//таймер-точка
		public var timerP:Point = new Point(0, 60);
		
		//таймер появления пуль
		public var timer:Timer = new Timer(200, 0);
		
		
		//актив массивы
		public var bulletAr:Array = new Array;
		public var meteorAr:Array = new Array;
		
		public var bullet:Bullet_mc;
		public var meteor:Meteor_mc;
		
		//пассивные массивы
		public var _bulletAr:Array = new Array;
		public var _meteorAr:Array = new Array;
		
		//объявляем замену мыши
		public var mouseMc:Target6 = new Target6;
		
		//Объявляем героя
		public var hero:Hero = new Hero();
		//Объявляем врагов
		public var enemy:Enemy = new Enemy();
		
		public var lb:int;
		public var lm:int;
		
		public var score:int = 0;
		public var score_txt:CreateText = new CreateText(1);
		public var lives_txt:CreateText = new CreateText(1);
		public var over_txt:CreateText = new CreateText(2);
		
		//Таймер топлива
		//public var timerFuel:Timer = new Timer(5000,7);
		//timerFuel.start();
		
		
		public function Main() 
		{
			
			init();
		}
		
		public function init():void
		{   
			//делаем так что бы сцена не маштабировалась
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//прячем мышь
			Mouse.hide();
			stage.addChildAt(mouseMc, 1);
			
			//добавляем корабль на сцену
			stage.addChild(hero.ship);
			
			//Запускаем класс создания и форматирования текста..
			//задаем полям изначальный текст
			score_txt.label.text = String("Счет: " + score);
			addChild(score_txt);
			lives_txt.label.text = String("Жизни: " + hero.lives);
			lives_txt.x = 700;
			addChild(lives_txt);
			
			//Слушатели событий
			stage.addEventListener(MouseEvent.MOUSE_DOWN, down);
			stage.addEventListener(MouseEvent.MOUSE_UP, up);
			addEventListener(Event.ENTER_FRAME, update);
			timer.addEventListener(TimerEvent.TIMER, addBull);
			//timerFuel.addEventListener(TimerEvent.TIMER, refuel);
			
			//Если клавиша мыши нажата то запускается таймер появления пуль
			function down(e:MouseEvent):void
			{
				timer.start();
			}
			
			//Если клавиша мыши отжата то таймер остановится
			function up(e:MouseEvent):void
			{
				timer.stop();
			}
			
			//Появление пуль
			function addBull(e:TimerEvent):void
			{
				if(_bulletAr.length>0)
				{
					bullet = _bulletAr.shift();
					bullet.gotoAndStop(1);
					bullet.visible = true;
				}
				else
				{
					bullet = new Bullet_mc;
					addChild(bullet);
				}
				
				bulletAr.push(bullet);
				bullet.x = hero.ship.x;
				bullet.y = hero.ship.y - 30;
				bullet.hp = 1;
				
				lb = bulletAr.length;
			}
			
			function update(e:Event):void
			{
				//Обновляем координаты нашего героя
				hero.init();
				//enemy.init();	
				//-------------------------------------------------------------
				
				//Обновляем координаты мыши
				mouseMc.x = mouseX;
				mouseMc.y = mouseY;
				
				//перемещение пуль	
				lb = bulletAr.length;
				var i:int;
				for(i = 0; i<lb; i++)
				{
					bullet = bulletAr[i];
					bullet.y -= 7;			
					
					//Если пуля столкнулась с метеором или улетела за поле то убираем её
					if(hitTest(bullet) || bullet.y<=-20 )
					{
						
						//убираем пулю
						bulletAr.splice(i,1);
						//bullet.visible = false;
						
						bullet.gotoAndPlay(2); //Проигрываем анимацию взрыва пули
						
						_bulletAr.push(bullet);
						i--;
						lb = bulletAr.length;
					}
					
				}
				//trace(lb);
				//trace(_bulletAr.lengt);
				//Появление метеоров по таймеру
				if(timerP.x > timerP.y)
				{
					timerP.x = 0;
					timerP.y = 10+Math.random()*60;
					
					if(_meteorAr.length>0)
					{
						meteor = _meteorAr.shift();
						meteor.gotoAndStop(1);
						meteor.visible = true;
					}
					else
					{
						meteor = new Meteor_mc;
						addChild(meteor);
					}
					meteor.y = -20;
					meteor.x = -70 + Math.random() * 680;
					
					meteor.hp = 3 + int(Math.random() * 3);
					meteor.speed = 2 + int(Math.random() * 5);
					meteorAr.push(meteor);
					//trace(meteor.hp);
					
				}
				else
				{
					timerP.x++;
				}
				
				//Движение метеоритов
				lm = meteorAr.length;
				for(i = 0; i<lm; i++)
				{
					meteor = meteorAr[i];
					meteor.y = meteor.y + meteor.speed;
					meteor.x = meteor.x + 1;
					
					meteor.rotation += 1;
					
					if(meteor.y>630)
					{
						meteorAr.splice(i,1);
						_meteorAr.push(meteor);
						meteor.visible = false;
						i--;
						lm = meteorAr.length;
						
					}
					
					//Проверяем столкновение корабля с метеоритами
					if(hero.lives>0)
					{
						if(meteor.hitTestObject(hero.ship) )
						{
							meteor.gotoAndPlay(2);
							
							//фиксируем повреждения корабля
							hero.ship.gotoAndStop(hero.ship.currentFrame+1);
							
							meteorAr.splice(i,1); //meteor.visible=false;
							_meteorAr.push(meteor);
							i--;
							lm = meteorAr.length;
							//meteor.gotoAndPlay("bam");
							
							//Контроль жизней
							hero.lives--;
							//присвоим текстовому полю кол-во жизней
							lives_txt.label.text = String("Жизни: "+hero.lives);
							
							
							//Если наступил GameOver то чистим экран от неиспользуемых объектов
							if(hero.lives==0)
							{
								//создади надпись Game Over
								over_txt.label.text = "Game Over";
								over_txt.x = 330;
								over_txt.y = 200;
								addChild(over_txt);
								addChild(score_txt);
								
								//Делаем метеориты в массиве не видимыми
								for(i=0; i<lm; i++)
								{
									meteor = meteorAr[i];
									meteor.visible=false;
								}
								//Делаем пули в массиве не видимыми
								for(i=0; i<lb; i++)
								{
									
									bullet = bulletAr[i];
									bullet.visible=false;
								}
								
								//Чистим экран от объектов
								removeEventListener(Event.ENTER_FRAME, update);
								stage.removeEventListener(MouseEvent.MOUSE_DOWN, down);
								stage.removeEventListener(MouseEvent.MOUSE_UP, up);
								timer.removeEventListener(TimerEvent.TIMER, addBull);
								//timerFuel.removeEventListener(TimerEvent.TIMER, refuel);
								hero.ship.visible = false;
								//removeChild(score_txt);
								score_txt.x = 390;
								score_txt.y = 270;
								removeChild(lives_txt);
								Mouse.show();
								//gotoAndPlay("over");
							}
					    }
					}
					
				}
			}
			
		}
		
		//Проверка столкновений пуль с метеоритами
		public function hitTest(b:MovieClip):Boolean
		{
			var collision:Boolean = false;
			var dx:Number;
			var dy:Number;
			var dl:Number;
			var i:Number;
			lm = meteorAr.length;
			
			//Перебираем массив активных метеоритов
			for(i=0; i<lm; i++)
			{
				//Определяем расстояние между объектами
				meteor = meteorAr[i];
				dx = Math.abs(meteor.x-b.x);
				dy = Math.abs(meteor.y-b.y);
				dl = Math.sqrt(Math.pow(dx,2)+Math.pow(dy,2));
				
				//Если достигнуто минимальное расстояние между метеором и пулей
				
				if(dl<= meteor.height/2)
				{
					
					meteor.hp--;
					trace(meteor.hp);
					if(meteor.hp <= 0)
					{
						meteor.gotoAndPlay(2);
						//meteor.visible = false;
						meteorAr.splice(i,1);
						_meteorAr.push(meteor);
						i--;
						lm = meteorAr.length;
						
						score+= 5;
						//Обновляем текстовое поле со счетом
						score_txt.label.text = String("Счет: "+score);
						
						//break;
					}
					collision = true;
					
				}
				
			}
			return collision;
		}
		
		
	}
	
}