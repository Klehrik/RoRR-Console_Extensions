Console.new{
    "buff_remove (buff) [count] [m_id]",
    {
        "Remove a buff from a player.",
        {"(buff)",      "string", "The namespace-identifier of the buff (e.g., <y>wormEye</c> or <y>ror-wormEye</c>)."},
        {"[count]",     "bool",   "The number of stacks to remove. <y>1</c> by default."},
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

        local nsid = args[1]
        if type(nsid) ~= "string" then
            Console.print("Enter a valid buff.")
            return
        end

        local id, ns = nsid_split(nsid)
        local buff = Buff.find(id, ns)
        if not buff then
            Console.print("Buff '"..nsid.."' not found.")
            return
        end

        local count = args[2]
        if count and (type(count) ~= "number") then
            Console.print("Invalid buff count.")
            return
        end

        local m_id = args[3]
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

        p:buff_remove(buff, count or 1)
    end
}