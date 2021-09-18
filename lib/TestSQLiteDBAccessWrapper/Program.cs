using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace TestSQLiteDBAccessWrapper
{
    class Program
    {
        [DllImport("SQLiteDBAccessWrapper.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.StdCall)]
        public static extern string RunSQL(string sql, string pathToDBFile);

        static void Main(string[] args)
        {
            Console.WriteLine(RunSQL("SELECT * FROM LANGUAGES", "TestDossier/RPGMaker_Localization.db"));
            Console.WriteLine(RunSQL("SELECT * FROM LOCALES", "RPGMaker_Localization.db"));
            Console.Read();
        }

    }
}
