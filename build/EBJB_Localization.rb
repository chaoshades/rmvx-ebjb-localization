################################################################################
#        Localization System with SQLite - EBJB_Localization          #   VX   #
#                          Last Update: 2009/03/09                    ##########
#                          Author : ChaosHades                                 #
#     Source :                                                                 #
#     http://www.google.com                                                    #
#------------------------------------------------------------------------------#
#  This script allows you to have locales in an external database and get      #
#  them directly from RGSS.                                                    #
#==============================================================================#
#                         ** Instructions For Usage **                         #
#  To make use of this function, you need to add the tag \dbt[ID] in the       #
#  Show Text event                                                             #
#                                                                              #
#  The format is as such : \dbt[ID]                                            #
#   Where ID : the ID the locale has in the database                           #
#  To switch languages, there is a variable that contains the ID of the        #
#  language you want to use : @@lang_id                                        #
#==============================================================================#
#                                ** Examples **                                #
#  You want to have a character that says 'Hello' to you in different          #
#  languages.                                                                  #
#  o First, you will need to create an entry in the database for the message,  #
#    let's say HelloMsg with the text Hello                                    #
#  o Add a Show Text Event with : \dbt[HelloMsg]                               #
#  o To switch languages, change the id in the @@lang_id variable              #
#==============================================================================#
#                           ** Installation Notes **                           #
#  Copy this script in the Materials section                                   #
#==============================================================================#
#                             ** Compatibility **                              #
#  Overwrites: Window_Message, convert_special_characters                      #
################################################################################

$imported = {} if $imported == nil
$imported["EBJB_Localization"] = true

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
#==============================================================================
# ** Window_Message (Overrides)
#------------------------------------------------------------------------------
#  This message window is used to display text.
#==============================================================================

class Window_Message < Window_Selectable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Convert Special Characters
  #--------------------------------------------------------------------------
  def convert_special_characters
    # Get text from the database
    @text.gsub!(/\\DBT\[([A-Z0-9_]+)\]/i) { Localization.getLocale($1.to_s, @@lang_id) }

    @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    @text.gsub!(/\\N\[([0-9]+)\]/i) { $game_actors[$1.to_i].name }
    @text.gsub!(/\\C\[([0-9]+)\]/i) { "\x01[#{$1}]" }
    @text.gsub!(/\\G/)              { "\x02" }
    @text.gsub!(/\\\./)             { "\x03" }
    @text.gsub!(/\\\|/)             { "\x04" }
    @text.gsub!(/\\!/)              { "\x05" }
    @text.gsub!(/\\>/)              { "\x06" }
    @text.gsub!(/\\</)              { "\x07" }
    @text.gsub!(/\\\^/)             { "\x08" }
    @text.gsub!(/\\\\/)             { "\\" }
  end

end

