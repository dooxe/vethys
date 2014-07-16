package net.dc.vethys 
{
	import fl.video.VideoEvent;
	import fl.video.VideoPlayer;
	import fl.video.VideoProgressEvent;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.dc.vethys.controls.VethysVideoControls;
	import net.dc.vethys.ui.VethysPlayerUI;
	/**
	 * ...
	 * @author dooxe
	 */
	public class VethysVideoPlayer extends Sprite
	{
		/**
		 * 
		 */
		private var	_width			: Number;
		
		/**
		 * 
		 */
		private var _height			: Number;
		
		/**
		 * 
		 */
		private var _player			: VideoPlayer;
		
		/**
		 * 
		 */
		private var	_ui				: VethysPlayerUI;
		
		/**
		 * 
		 */
		private var _controls		: VethysVideoControls;
		
		/**
		 * 
		 */
		private var	_url			: String;
		
		/**
		 * 
		 */
		public function VethysVideoPlayer(width:Number, height:Number, videoUrl:String = null) 
		{
			super();
			_width		= width;
			_height		= height;
			_url		= videoUrl;
			init();
		}
		
		/**
		 * 
		 */		
		private function init():void
		{		
			var g:Graphics = graphics;
			g.beginFill(0X111111);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
			
			//
			var cache:Sprite = new Sprite();
			g = cache.graphics;
			g.beginFill(0x000000);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
			addChild(cache);
			cache.alpha = 0;				
			
			//
			_player = new VideoPlayer(_width, _height);						
			_player.addEventListener(VideoEvent.READY, function(e:VideoEvent):void
			{
				
			});
			_player.addEventListener(VideoProgressEvent.PROGRESS, function(e:VideoProgressEvent):void
			{
				_ui.loadProgress = e.bytesLoaded / e.bytesTotal;
			});
			_player.addEventListener(VideoEvent.PLAYHEAD_UPDATE, function(e:VideoEvent):void
			{
				_ui.cursorPosition = e.playheadTime / _player.totalTime;
			});
			addChild(_player);	
			
			//
			var overlay:Sprite = new Sprite();
			g = overlay.graphics;
			g.beginFill(0x113355);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
			overlay.alpha = 0.5;
			
			var play:Sprite = new Sprite();
			g = play.graphics;
			g.beginFill(0xffffff, 0.5);
			g.lineTo(48, 24);
			g.lineTo(0, 48);
			g.endFill();
			play.x = (overlay.width - play.width) / 2;
			play.y = (overlay.height - play.height) / 2;
			overlay.addChild(play);
			addChild(overlay);
			
			overlay.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				if (_url)
				{
					_controls.togglePlay();
					_ui.visible = true;
					overlay.visible = false;
				}
			});	
			
			cache.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				if (_url)
				{
					_controls.togglePlay();
				}
			});	
			
			//
			_controls = new VethysVideoControls(_player);
			_controls.onPlay.add(function(p:Boolean):void { overlay.alpha = 0; } );
			_controls.onPause.add(function(p:Boolean):void { overlay.alpha = 0.5; } );
			
			//
			_ui = new VethysPlayerUI(_width, _height, _controls);
			_ui.visible = false;
			addChild(_ui);		
						
			//
			cache.addEventListener(MouseEvent.MOUSE_OVER, function(e:Event):void
			{
				_ui.setControlsHidden(false);
			});
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		/**
		 * 
		 */
		private function addedToStage(e:Event):void
		{
			var object:DisplayObject = this;
			while (object.parent)
			{
				object = object.parent;
			}
			(object as Stage).addEventListener(Event.MOUSE_LEAVE, function(e:Event):void
			{
				_ui.setControlsHidden(true);
			});
		}
		
		/**
		 * 
		 */
		public function load(url:String):void
		{
			_url = url;
			_player.load(_url);	
		}
	}

}