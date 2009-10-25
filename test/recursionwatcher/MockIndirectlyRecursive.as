package recursionwatcher
{
	
	/**
	 * An example of an object that creates a copy of itself in a sub-method
	 *
	 * @author Alec McEachran
	 */
	internal class MockIndirectlyRecursive extends ResursionWatcher
	{
		public function MockIndirectlyRecursive()
		{
			init();
		}
		
		private function init():void
		{
			new MockIndirectlyRecursive();
		}
		
	}
}
