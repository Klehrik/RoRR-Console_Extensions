Console.new{
    "equipment_remove [m_id]",
    {
        "Removes the player's equipment.",
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

        p:equipment_set(-1)
        local name = p.user_name or ""
        Console.print("Removed "..name.."'s equipment.")
    end
}