package net.dc.vethys.controls {
	import fl.video.VideoEvent;
	import fl.video.VideoPlayer;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author dooxe
	 */
	public class VethysVideoControls 
	{
		/**
		 * 
		 */
		private var _playing		: Boolean;
		
		/**
		 * 
		 */
		private var _video			: VideoPlayer;
		
		/**
		 * 
		 */
		public const	onPlay		: Signal = new Signal();
		
		/**
		 * 
		 */
		public const	onPause		: Signal = new Signal();
		
		/**
		 * 
		 */		
		public function VethysVideoControls(video:VideoPlayer) 
		{			
			_video		= video;
			_video.addEventListener(VideoEvent.COMPLETE, function(e:VideoEvent):void
			{
				togglePlay();
				_video.seek(0);
			});
			_playing	= false;
		}
		
		/**
		 * 
		 */
		public function togglePlay():void
		{
			if (_playing)
			{
				_video.pause();
				_playing = false;
				onPause.dispatch(_playing);
			}
			else
			{
				_video.play();
				_playing = true;
				onPlay.dispatch(_playing);
			}
		}
		
		/**
		 * 
		 */
		public function set position(position:Number):void
		{
			_video.seek(position * _video.totalTime);
		}
		
		/**
		 * 
		 * @return
		 */
		public function get isPlaying():Boolean
		{
			return _playing;
		}
	}

}