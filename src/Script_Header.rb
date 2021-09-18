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
