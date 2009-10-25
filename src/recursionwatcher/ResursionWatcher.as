package recursionwatcher
{
	import flash.system.Capabilities;
	import flash.utils.getQualifiedClassName;

	/**
	 * Used as a base-class in a debug environment this class will test whether an
	 * object recursively constructs itself.
	 * 
	 * It uses an error stack trace in order to evaluate whether classes recursively
	 * construct itself, which is only available in the debug-player environment.
	 * 
	 * @author Alec McEachran
	 */
	public class ResursionWatcher 
	{
		
		private const ERROR_MESSAGE:String = "@TYPE@ recursively adds itself as a test!";
		
		private const TYPE_PLACEHOLDER_IN_ERROR_MESSAGE:String = "@TYPE@";
		
		private const PATTERN_FOR_EXTRACTING_CLASS_FROM_STACKTRACE:RegExp = /at (.+?)\(/;
		
		private static var typeOfLastConstructedObject:String;
		
		public function ResursionWatcher()
		{
			if (isRecursionTestAvailable())
				testForRecursion();
		}
		
		private function isRecursionTestAvailable():Boolean
		{
			return Capabilities.isDebugger;
		}
		
		private function testForRecursion():void
		{
			var type:String = getQualifiedClassName(this);
			var previous:String = typeOfLastConstructedObject;
			
			typeOfLastConstructedObject = type;
			if (type != previous)
				return;
			
			var error:Error = new RecursionError(type);
			if (stackIndicatesRecursion(error))
				throwError(error);
		}
		
		private function stackIndicatesRecursion(error:Error):Boolean
		{
			var stackTrace:String = error.getStackTrace();
			if (!stackTrace)
				return false;
			
			var stack:Array = stackTrace.split("\n");
			stack = stack.slice(3, stack.length);
			
			var classes:Array = [];
			var classIndex:int = 0;
			
			var line:String = stack[0];
			line = line.match(PATTERN_FOR_EXTRACTING_CLASS_FROM_STACKTRACE)[1];
			if (line.indexOf("/") == -1)
				classes[classIndex++] = line;
			
			var len:int = stack.length - 1;
			for (var i:int = 1; i < len; i++)
			{
				line = stack[i];
				line = line.match(PATTERN_FOR_EXTRACTING_CLASS_FROM_STACKTRACE)[1];
				if (line.indexOf("/") == -1)
				{
					if (classes[classIndex - 1] == line)
						return true;
					
					classes[classIndex++] = line;
				}
			}
			
			return false;
		}
		
		
		private function throwError(error:Error):void
		{
			var type:String = error.message;
			error.message = ERROR_MESSAGE.replace(TYPE_PLACEHOLDER_IN_ERROR_MESSAGE, type);
			throw error;
		}
		
		
	}
}
