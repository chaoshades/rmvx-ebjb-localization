# rmvx-ebjb-localization

Adds simple way to add multilingual support to your game backed by a [SQLite](https://www.sqlite.org/index.html) database. We could also use the same idea to feed more data into RPG Maker VX instead of the default database.

## Table of contents

- [Quick start](#quick-start)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Creators](#creators)

## Quick start

- Run this command to combine core scripts source into one file. `ruby build.rb`
- Copy the resulting file into your RPG Maker VX project 
- Copy the `lib/rexml` folder and its content into the `External Scripts` folder of your project
- Copy all of the `lib/*.dll` files next to your `.exe` of your project

OR

- There is an already pre-compiled demo with the classic sample project.

### Dependencies

Depends on EBJB_Core : <https://github.com/chaoshades/rmvx-ebjb-core/>

## Documentation

### Database schema

```text
CREATE TABLE LANGUAGES (
  lang_id.    integer,
  lang_desc.  nvarchar(20),
  Primary Key (lang_id)
)

CREATE TABLE LOCALES (
  locale_id   nvarchar(100),
  lang_id     integer,
  locale_text nvarchar(1000),
  Primary Key (locale_id,lang_id),
  Foreign Key (lang_id) references LANGUAGES(lang_id)
)
```

### Instruction for usage

You need to add the tag `\dbt[ID]` in the `Show Text` event where `ID` represents the unique identifier of the locale in the database. 

To change the language, you can do so with a `Show Choices` event or any custom script that change the value of the `@@lang_id` global variable.

### External libraries

> There are clearly newest versions available for these. However, the old ones still works :O.

#### SQLiteDBAccess, SQLiteDBAccessWrapper, System.Data.SQLite

> I put the source code I had that was used to generate the wrapper to be called by RPG Maker VX. Sorry, I didn't found more details on how it was compiled though.

It's a wrapper, hence the name, on a library in C# that uses the ADO.NET provider for [SQLite](https://www.sqlite.org/index.html) and return results in XML. It is loaded with a `Win32API` call. 

#### rexml

A [Ruby library](https://github.com/ruby/rexml) with a simple API to parse the XML returned by the SQLiteDBAccess library. It is loaded dynamically with the require method, which isn't available by default in RGSS, so it was custom-made.
> For more info, the source is there : <https://github.com/chaoshades/rmvx-ebjb-core/blob/master/src/Other%20Scripts/RequireDefinition.rb>

## Contributing

Still in development...

## Creators

- <https://github.com/chaoshades>
