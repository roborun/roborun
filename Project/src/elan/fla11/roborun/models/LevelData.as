package elan.fla11.roborun.models
{
	/**
	 * Store levelinfo for one level.
	 * Get - title : String
	 * Get - source : String
	 * 
	 * @author Anton Strand.
	 **/
	
	public class LevelData
	{
		private var _title		:String;
		private var _source		:String;
		
		public function LevelData( title:String, source:String )
		{
			_title = title;
			_source = source;
		}
		
		public function get title(): String
		{
			return _title;
		}

		public function get source(): String
		{
			return _source;
		}
	}
}