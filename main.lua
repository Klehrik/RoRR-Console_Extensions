-- Console Extensions

mods["ReturnsAPI-ReturnsAPI"].auto{
    namespace   = "consoleExtensions",
    mp          = true
}

PATH = _ENV["!plugins_mod_folder_path"]

require("./helper")

-- Require all files in `src/`
local names = path.get_files(path.combine(PATH, "src"))
for _, name in ipairs(names) do require(name) end