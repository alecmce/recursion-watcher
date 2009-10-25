package recursionwatcher
{

	/**
	 * An error that is dispatched when a RecursionWatcher class is recursively constructing
	 * itself
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class RecursionError extends Error
	{
		private const NAME:String = "RecursionError";
		
		public function RecursionError(message:String)
		{
			super(message);
			name = NAME;
		}
		
	}
}
