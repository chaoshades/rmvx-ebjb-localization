using System;
using System.IO;
using System.Data;
using System.Data.SQLite;
using System.Text;

namespace SQLiteDBAccessAssembly
{
    /// <summary>
    /// Class that contains base operations with a SQLite database
    /// </summary>
    public class SQLiteDBAccess
    {
        /// <summary>
        /// Execute a SQL command on a SQLite database
        /// </summary>
        /// <param name="sql">SQL command to run</param>
        /// <param name="pathToDBFile">Path of the database file</param>
        /// <returns>Byte array with the results from the SQL command in XML format</returns>
        public static byte[] RunSQL(byte[] sql, byte[] pathToDBFile)
        {
            string XMLresults = string.Empty;
            SQLiteConnection conn = new SQLiteConnection();
            SQLiteDataAdapter adapter;
            DataTable dt = new DataTable();
            MemoryStream memStream = new MemoryStream();
            string strSql = Encoding.UTF8.GetString(sql);
            string strPathToDBFile = Encoding.UTF8.GetString(pathToDBFile);

            try
            {
                conn.ConnectionString = "Data Source=" + strPathToDBFile + ";Version=3;";
                conn.Open();
                adapter = new SQLiteDataAdapter(strSql, conn);
                adapter.Fill(dt);
                dt.TableName = Path.GetFileNameWithoutExtension(strPathToDBFile);

                dt.WriteXml(memStream);
                memStream.Position = 0;
                XMLresults = new StreamReader(memStream, Encoding.UTF8).ReadToEnd();
            }
            catch (Exception ex)
            {
                Console.WriteLine("SQLiteDBAccess Error : " + ex.Message);
            }
            finally
            {
                conn.Close();
            }

            return Encoding.UTF8.GetBytes(XMLresults);
        }
    }
}
