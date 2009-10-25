package recursionwatcher
{

	
	/**
	 * An example of an object that creates a copy of itself in the constructor
	 *
	 * @author Alec McEachran
	 */
	internal class MockDirectlyRecursive extends ResursionWatcher
	{
		public function MockDirectlyRecursive()
		{
			new MockDirectlyRecursive();
		}
	}
}
