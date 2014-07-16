package net.dc.vethys.ui {
	import flash.display.Graphics;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.dc.vethys.controls.VethysVideoControls;
	import net.dc.vethys.ui.VethysProgressBar;
	
	/**
	 * ...
	 * @author dooxe
	 */
	public class VethysPlayerUI extends Sprite 
	{	
		/**
		 * 
		 */
		private var _width		: int;
		
		/**
		 * 
		 */
		private var _height		: int;
		
		/**
		 * 
		 */
		private var _controls:Sprite;
		
		/**
		 * 
		 */
		private var _hidding	: Boolean;
		
		/**
		 * 
		 */
		private var _playB		: Sprite;
		
		/**
		 * 
		 */
		private var _bar		: VethysProgressBar;
		
		/**
		 * 
		 */
		private var _videoControls: VethysVideoControls;
		
		/**
		 * 
		 */
		public function VethysPlayerUI(w:int, h:int, videoControls:VethysVideoControls) 
		{
			super();
			
			//
			_width		= w;
			_height		= h;
			_controls	= createControls();
			addChild(_controls);
			_controls.y = _height - _controls.height;
			_hidding	= true;
			_videoControls	= videoControls;
			
			//
			_playB		= createPlayButton();
			_playB.x	= 0;
			_playB.y	= 0;
			_playB.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
			{
				_videoControls.togglePlay();
			});
			_controls.addChild(_playB);
			
			//
			_videoControls.onPlay.add(function(p:Boolean):void 
			{
				_playB.getChildByName("pause").visible	= true;
				_playB.getChildByName("play").visible	= false;
			});
			_videoControls.onPause.add(function(p:Boolean):void 
			{
				_playB.getChildByName("pause").visible	= false;
				_playB.getChildByName("play").visible	= true;
			});
			
			//
			_bar = new VethysProgressBar(_width - _playB.width - 8, 16);
			_bar.x = 40;
			_bar.y = 0;
			_bar.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
			{
				_videoControls.position = (e.localX / _bar.width);
			});
			_controls.addChild(_bar);
			
			//
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		/**
		 * 
		 * @return
		 */
		private function createPlayButton():Sprite
		{
			var down:Sprite = new Sprite();
			var g:Graphics = down.graphics;
			g.beginFill(0x113355);
			g.drawRect(0, 0, 32, 16);
			g.endFill();
			
			var up:Sprite = new Sprite();
			g = up.graphics;
			g.beginFill(0x113355);
			g.drawRect(0, 0, 32, 16);
			g.endFill();
			
			var over:Sprite = new Sprite();
			g = over.graphics;
			g.beginFill(0x225588);
			g.drawRect(0, 0, 32, 16);
			g.endFill();
			
			var play:Sprite = new Sprite();
			g = play.graphics;
			g.beginFill(0xffffff);
			g.lineTo(8, 4);			
			g.lineTo(0, 8);
			g.endFill();
			
			play.x = (32 - play.width) / 2;
			play.y = (16 - play.height) / 2;
			play.name = "play";
			
			var pause:Sprite = new Sprite();
			g = pause.graphics;
			g.beginFill(0xffffff);
			g.drawRect(0, 0, 4, 8);
			g.drawRect(8, 0, 4, 8);
			g.endFill();
			
			pause.x = (32 - pause.width) / 2;
			pause.y = (16 - pause.height) / 2;
			pause.visible = false;
			pause.name = "pause";
			
			var sbutton:SimpleButton = new SimpleButton(up, over, down, over);
			var button:Sprite = new Sprite();
			button.addChild(sbutton);
			button.addChild(play);
			button.addChild(pause);
			
			var overlay:Sprite = new Sprite();
			g = overlay.graphics;
			g.beginFill(0x000000);
			g.drawRect(0, 0, 32, 16);
			g.endFill();
			overlay.alpha = 0;
			button.addChild(overlay);
			
			return button;
		}
		
		/**
		 * 
		 * @param	b
		 */
		public function setControlsHidden(b:Boolean):void
		{
			_hidding = b;
		}
		
		/**
		 * 
		 */
		private function createControls():Sprite
		{
			var sprite:Sprite = new Sprite();
			var g:Graphics = sprite.graphics;
			g.beginFill(0x222222);
			g.drawRect(0, 0, _width, 16);
			g.endFill();
			return sprite;
		}
		
		/**
		 * 
		 */
		public function set loadProgress(progress:Number):void
		{
			_bar.loadProgress = progress;
		}
		
		/**
		 * 
		 */
		public function set cursorPosition(position:Number):void
		{
			_bar.cursorPosition = position;
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function enterFrame(e:Event):void
		{
			if (_hidding)
			{
				if (_controls.y < _height)
				{
					_controls.y += (_height - _controls.y) / 10 + 1;
				}
				else
				{
					_controls.y = _height;
				}
			}
			else
			{
				if (_controls.y > _height - 16)
				{
					_controls.y -= (_controls.y - (_height - 16)) / 10 + 1;
				}
				else
				{
					_controls.y = _height - 16;
				}
			}
		}
	}

}