package net.dc.vethys.ui {
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author dooxe
	 */
	public class VethysProgressBar extends Sprite 
	{
		/**
		 * 
		 */
		private var _background		: Sprite;
		
		/**
		 * 
		 */
		private var _loading		: Sprite;
		
		/**
		 * 
		 */
		private var _cursor			: Sprite;
		
		/**
		 * 
		 */
		private var _width			: Number;
		
		/**
		 * 
		 */
		private var _height			: Number;
		
		/**
		 * 
		 */
		public function VethysProgressBar(width:Number, height:Number) 
		{
			super();	
			_width		= width;
			_height		= height;
			_background	= createBackground();
			addChild(_background);
			_loading	= createLoadBar();
			addChild(_loading);
			_cursor		= createCursor();
			addChild(_cursor);
		}
		
		/**
		 * 
		 */
		private function createBackground():Sprite
		{
			var bar:Sprite = new Sprite();
			var g:Graphics = bar.graphics;
			g.beginFill(0x111111);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
			return bar;
		}
		
		/**
		 * 
		 */
		private function createLoadBar():Sprite
		{
			var bar:Sprite = new Sprite();
			var g:Graphics = bar.graphics;
			g.beginFill(0x113355);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
			return bar;
		}
		
		/**
		 * 
		 */
		private function createCursor():Sprite
		{
			var cursor:Sprite = new Sprite();
			var g:Graphics = cursor.graphics;
			g.beginFill(0x2255AA);
			g.drawRect(0, 0, 8, _height);
			g.endFill();
			return cursor;
		}
		
		/**
		 * 
		 */
		public function set loadProgress(progress:Number):void
		{
			_loading.scaleX = progress;
		}
		
		/**
		 * 
		 */
		public function set cursorPosition(position:Number):void
		{
			_cursor.x = position * (_width - _cursor.width);
		}
	}

}