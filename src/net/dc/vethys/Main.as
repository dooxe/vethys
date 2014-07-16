package net.dc.vethys {
	import fl.video.VideoEvent;
	import fl.video.VideoPlayer;
	import fl.video.VideoProgressEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * 
	 * @author dooxe
	 */
	[SWF(width="480", height="320", frameRate="60")]
	public class Main extends Sprite 
	{
		/**
		 * 
		 */
		private var _player:VethysVideoPlayer;		
		
		/**
		 * 
		 */
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//	Retrieve the url to play
			var url:String = loaderInfo.parameters.url;
			
			//	Create the video player
			_player = new VethysVideoPlayer(stage.stageWidth, stage.stageHeight);
			if (url)
			{
				_player.load(url);
			}
			addChild(_player);
		}		
	}
	
}