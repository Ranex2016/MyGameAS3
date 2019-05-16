package {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;


    public class CreateText extends Sprite 
	{
        public var label:TextField;
		public var chooseFormat:int;
		
        public function CreateText(f:int):void 
		{
			chooseFormat = f;
            configureLabel();
        }
		
        private function configureLabel():void 
		{
			trace("текстовое поле создано!");
            label = new TextField();
            label.autoSize = TextFieldAutoSize.LEFT;
			
			if (chooseFormat == 1)
			{
				label.background = true;
				label.border = true;
				var format1:TextFormat = new TextFormat();
				format1.font = "Arial";
				format1.color = 0xFF0000;
				format1.size = 20;
				//format1.underline = true;
				label.defaultTextFormat = format1;
				addChild(label);
			}
			if (chooseFormat == 2)
			{
				var format2:TextFormat = new TextFormat();
				format2.font = "Tahoma";
				format2.color = 0xFF0000;
				format2.size = 35;
				format2.bold = true;
				//format2.underline = true;
				label.defaultTextFormat = format2;
				addChild(label);
			}
            
        }
    }
}