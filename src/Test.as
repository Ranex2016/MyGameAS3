var meteorArr:Array = new Array();//массив с метеоритами
var bulletArr:Array = new Array();//массив с пулями
var timer:Point = new Point(0,30);//таймер для появления метеоритов

var tempMeteorArr:Array=new Array();
var tempBulletArr:Array=new Array();

var metSpeed:Number = 10;//скорость метеоритов
var bulSpeed:Number = 10;//скорость пули
var hitDistance:Number = 30;//дистанция для столкновения

//временные переменные
var _meteor:Shar;

var _bullet:Bullet;
var _i:Number;
var _l:Number;



stage.scaleMode = StageScaleMode.NO_SCALE;

addEventListener(Event.ENTER_FRAME, update);

function update(e:Event){
	//если пришло время создать метеорит
	if (timer.x>=timer.y){
		timer.x = 0;//обнуляем таймер
		timer.y = randRange(20,30);//это для случайного времени появления метеоритов
		
		//создаем метеорит
		if (tempMeteorArr.length>0){
			//берем метеорит из пула
			_meteor = tempMeteorArr.shift();
			_meteor.visible=true;
		}else{
			//создаем метеорит
			_meteor = new Shar();
			addChild(_meteor);
		}
		meteorArr.push(_meteor);
		_meteor.x = randRange(50,590);
		_meteor.y = -50;
		
	}else{
		timer.x+=1;
	}
	
	//перемещаем все метеориты
	_l = meteorArr.length;
	for (_i=0;_i<_l;_i++){
		_meteor = meteorArr[_i];
		_meteor.y+=metSpeed;
		//если метеорит вылетел за приделы экрана, убираем его
		if (_meteor.y>=550){
			meteorArr.splice(_i,1);
			_i-=1;
			_l = meteorArr.length;
			
			tempMeteorArr.push(_meteor);
			_meteor.visible=false;
		}
	}
	//перемещаем все пули
	_l = bulletArr.length;
	for (_i=0;_i<_l;_i++){
		_bullet = bulletArr[_i];
		_bullet.y-=bulSpeed;
		//если пуля столкнулась с каким то метеоритом или она вылетела за приделы экрана
		if (cheackHit(_bullet) || _bullet.y<-50){
			//убираем пулю
			bulletArr.splice(_i,1);
			_i-=1;
			_l = bulletArr.length;
			
			tempBulletArr.push(_bullet);
			_bullet.visible=false;
		}
	}
}

//создаем пулю по клику
stage.addEventListener(MouseEvent.CLICK, createBullet);
function createBullet(e:MouseEvent){
	if (tempBulletArr.length>0){
		_bullet = tempBulletArr.shift();
		_bullet.visible=true;
	}else{
		_bullet = new Bullet();
		addChild(_bullet);
		
	}
	_bullet.x = mouseX;  
	_bullet.y = mouseY;
	bulletArr.push(_bullet);
	
	
}
//проверка на столкновение
function cheackHit(bul:Bullet){
	var i:Number;
	var l:Number = meteorArr.length;
	var dX:Number;
	var dY:Number;
	var dL:Number;
	//для каждого метеорита
	for (i=0;i<l;i++){
		_meteor = meteorArr[i];
		//считаем расстояние от метеорита до пули
		dX = Math.abs(_meteor.x - bul.x);
		dY = Math.abs(_meteor.y - bul.y);
		dL = Math.sqrt(Math.pow(dX,2)+Math.pow(dY,2));
		
		//если расстояние <= дистанции столкновения
		if (dL<=hitDistance){
			//уничтожаем метеорит
			meteorArr.splice(i,1);
			i-=1;
			l = meteorArr.length;
			
			tempMeteorArr.push(_meteor);
			_meteor.visible=false;
			
			return true;//прерываем цикл и возвращаем ответ
		}
		
	}
	
	return false;//возвращаем ответ
	
}

//функция рандома
function randRange(min:Number, max:Number) 
{
  var randomNum:Number = Math.round(Math.random()*(max-min))+min;
  return randomNum;
}







