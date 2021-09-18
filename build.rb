module EBJB_Localization
  # Build filename
  FINAL   = "build/EBJB_Localization.rb"
  # Source files
  TARGETS = [
	"src/Script_Header.rb",
    "src/Localization.rb",
    "src/Windows/Window_Message.rb",
  ]
end

def ebjb_build
  final = File.new(EBJB_Localization::FINAL, "w+")
  EBJB_Localization::TARGETS.each { |file|
    src = File.open(file, "r+")
    final.write(src.read + "\n")
    src.close
  }
  final.close
end

ebjb_build()