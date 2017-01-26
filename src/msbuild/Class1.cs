using System;
using System.Runtime.InteropServices;

namespace ClassLibrary1
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class Class1
	{
		public static void Main(string[] args)
		{
			// Marshal.SizeOf<T> is new to 4.5.1
			int x = 4;
			Console.WriteLine(Marshal.SizeOf<int>(x));
		}
	}
}
