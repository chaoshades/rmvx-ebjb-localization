using System;
using System.Collections.Generic;
using System.Text;
using SQLiteDBAccessAssembly;

namespace TestSQLiteDBAccess
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(Encoding.UTF8.GetString(SQLiteDBAccess.RunSQL(Encoding.UTF8.GetBytes("SELECT * FROM LANGUAGES"),
                              Encoding.UTF8.GetBytes("RPGMaker_Localization.db"))));
            Console.WriteLine(Encoding.UTF8.GetString(SQLiteDBAccess.RunSQL(Encoding.UTF8.GetBytes("SELECT * FROM LOCALES"), 
                              Encoding.UTF8.GetBytes("RPGMaker_Localization.db"))));
            Console.Read();
        }
    }
}
