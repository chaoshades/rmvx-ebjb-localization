#include "stdafx.h"
#include "SQLiteDBAccessWrapper.h"

#ifdef _MANAGED
#pragma managed(push, off)
#endif

#ifdef _MANAGED
#pragma managed(pop)
#endif

#using "SQLiteDBAccess.dll"
using namespace SQLiteDBAccessAssembly;

//Call to the function from the C# dll
char* SQLiteDBAccessWrapper::RunSQL(char* sql, char* pathToDBFile)
{
	array<unsigned char>^ sqlManArr = CharToManArray(sql);
	array<unsigned char>^ pathToDBFileManArr = CharToManArray(pathToDBFile);

	array<unsigned char>^ char8ManArr = SQLiteDBAccess::RunSQL(sqlManArr, pathToDBFileManArr);
	char* char8UnmanArr = new char[char8ManArr->Length + 1];
	for (int i = 0; i < char8ManArr->Length; i++)
	{
		char8UnmanArr[i] = safe_cast<char>(char8ManArr[i]);
	}
	char8UnmanArr[char8ManArr->Length] = '\0';
	return char8UnmanArr;
}

//Create a managed char array from a char array
array<unsigned char>^ SQLiteDBAccessWrapper::CharToManArray(char* var)
{
	int i = 0;
	while (*var != '\0')
	{
		i++;
		var++;
	}
	array<unsigned char>^ varManArr = gcnew array<unsigned char>(i);
	var -= i;
	i = 0;
	while (*var != '\0')
	{
		varManArr[i] = *var;
		var++;
		i++;
	}
	
	return varManArr;
}
