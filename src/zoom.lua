Console.new{
    "zoom [m_id]",
    {
        "Toggle fast speed and extra jumps for a player.",
        {"[m_id]", "number", "The m_id of the player. Local player by default."},
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

        local m_id = args[1]
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

        local p_data = Instance.get_data(p)
        p_data.zoom = not p_data.zoom

        local fn = "item_"..(p_data.zoom and "give" or "take")
        p[fn](p, Item.find("paulsGoatHoof"), 50)
        p[fn](p, Item.find("hopooFeather"), 50)
        p[fn](p, Item.find("rustyJetpack"), 10)

        Console.print("Zoom is now "..tostring(p_data.zoom and "ON" or "OFF").." for "..p.user_name..".")
    end
}