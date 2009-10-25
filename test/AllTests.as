package 
{
	import asunit.framework.TestSuite;

	import recursionwatcher.AllTests;

	public class AllTests extends TestSuite 
	{
		public function AllTests() 
		{
			addTest(new recursionwatcher.AllTests());
		}
	}
}
