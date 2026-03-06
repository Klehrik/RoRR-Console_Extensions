Console.new{
    "equipment_set (equipment) [m_id]",
    {
        "Sets the player's equipment.",
        {"(equipment)", "string", "The namespace-identifier of the equipment (e.g., <y>rottenBrain</c> or <y>ror-rottenBrain</c>)."},
        {"[m_id]",      "number", "The m_id of the player. Local player by default."},
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        if Net.client then
            Console.print("Must be lobby host.")
            return
        end

        if (#args < 1)
        or (type(args[1]) ~= "string") then
            Console.print("Enter a valid equipment.")
            return
        end

        local id, ns = nsid_split(args[1])
        local equip = Equipment.find(id, ns)
        if not equip then
            Console.print("Equipment '"..args[1].."' not found.")
            return
        end

        local m_id = args[2]
        local p = Player.get_local()
        if m_id then
            if type(m_id) ~= "number" then
                Console.print("Invalid value for m_id.")
                return
            end
            p = get_player(m_id)
        end
        if not Instance.exists(p) then
            Console.print("Player does not exist.")
            return
        end

        p:equipment_set(equip)
        local name = p.user_name or ""
        Console.print("Set "..name.."'s equipment to "..gm.translate("item."..id..".name")..".")
    end
}