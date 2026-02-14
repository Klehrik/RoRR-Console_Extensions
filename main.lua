-- Console Extensions

mods["ReturnsAPI-ReturnsAPI"].auto{
    namespace   = "consoleExtensions",
    mp          = true
}

PATH = _ENV["!plugins_mod_folder_path"]

nsid_split = function(nsid)
    local ns
    local id = nsid
    local delimiter = nsid:find("-")
    if delimiter then
        ns = nsid:sub(1, delimiter - 1)
        id = nsid:sub(delimiter + 1, -1)
    end
    return id, ns
end

-- Require all files in `src/`
local names = path.get_files(path.combine(PATH, "src"))
for _, name in ipairs(names) do require(name) end