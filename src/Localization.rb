#==============================================================================
# ** Localization
#------------------------------------------------------------------------------
#  Singleton class used to get locales from a database
#==============================================================================

#Global value for the language
@@lang_id = 1

# include REXML library to parse XML
$: << "./External Scripts/"
require "rexml/document"
include REXML

class Localization
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constants
  #//////////////////////////////////////////////////////////////////////////
  
  # SQL command to get locales
  GET_LOCALES_SQL = "SELECT locale_text FROM LOCALES WHERE locale_id IN ($1) AND lang_id = $2;"
  # DLL wrapper to call to access the database
  DB_ACCESS_DLL = Win32API.new("SQLiteDBAccessWrapper.dll","RunSQL",["p","p"],"p")
  # Database filename
  DB_FILE = "RPGMaker_Localization.db"
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get value for a specified locale in the database
  #     id : locale id
  #     lang  : language id
  #--------------------------------------------------------------------------
  def self.getLocale(id, lang)
    arrIds = Array.new()
    arrIds.push(id)
    return getLocales(arrIds, lang)[0]
  end
  
  #--------------------------------------------------------------------------
  # * Get values for specified locales in the database
  #     arrIds : array containing the locale ids
  #     lang  : language id
  #--------------------------------------------------------------------------
  def self.getLocales(arrIds, lang)
    # Transform the array into a string (format : [a,b,...] >> 'a','b',...)
    str = arrIds.collect{|a| "'" + a + "', "}.to_s.chop.chop
    # Generate the SQL command to execute
    sql = String.new(GET_LOCALES_SQL)
    sql["$1"] = str
    sql["$2"] = lang.to_s
    # Run SQL from the external DLL
    dbResults = DB_ACCESS_DLL.call(sql, DB_FILE)
    # Transform the result in a REXML::Document Object
    doc = Document.new dbResults
    # Get the filename of the database without the extension
    dbName = File.basename(DB_FILE).split(".")[0]
    # Get the results and add the elements in an array
    results = Array.new()
    if !doc.root.elements.empty? then
      doc.root.elements.each(dbName + "/locale_text") { |element| results.push(element.text) }
    else
      results[0] = "[Undefined into the database]"
    end
    return results
  end
 
end