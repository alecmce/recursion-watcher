package recursionwatcher 
{
	
	import asunit.framework.TestCase;

	/**
	 * Tests for objects that extend the RecursionTester class
	 *
	 * @author Alec McEachran
	 */
	public class RecursionWatcherTest extends TestCase
	{
		
		public function testCreateDirectlyRecursive():void
		{
			var isError:Boolean = false;
			
			try
			{
				new MockDirectlyRecursive();
			}
			catch (error:RecursionError)
			{
				isError = true;
			}
			finally
			{
				assertTrue("creating an instance of a recursive object should throw a recursion error", isError);
			}
		}
		
		
		public function testCreateIndirectlyRecursive():void
		{
			var isError:Boolean = false;
			
			try
			{
				new MockIndirectlyRecursive();
			}
			catch (error:RecursionError)
			{
				isError = true;
			}
			finally
			{
				assertTrue("creating an instance of a recursive object should throw a recursion error", isError);
			}
		}


		public function testCreateNonRecursive():void
		{
			var isError:Boolean = false;
			
			try
			{
				new MockNonRecursive();
				new MockNonRecursive();
			}
			catch (error:RecursionError)
			{
				isError = true;
			}
			finally
			{
				assertFalse("creating two instances of a non-recursive object should not throw a recursion error", isError);
			}
		}

	}
}
