// Class that wraps the C# dll
class SQLiteDBAccessWrapper
{
    public:
		//Exported function from the C# dll
		__declspec(dllexport) char*  RunSQL(char* sql, char* pathToDBFile);
	private:
		//Create a managed char array from a char array
		array<unsigned char>^ CharToManArray(char* var);
};