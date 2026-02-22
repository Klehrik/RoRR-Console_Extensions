Console.new{
    "item_take (item) [count] [temporary] [m_id]",
    {
        "Take stacks of an item from a player.",
        {"(item)",      "string", "The namespace-identifier of the item (e.g., <y>meatNugget</c> or <y>ror-meatNugget</c>)."},
        {"[count]",     "number", "The number of stacks to take. <y>1</c> by default."},
        {"[temporary]", "bool",   "If <y>true</c>, removes temporary stacks. <y>false</c> by default."},
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
            Console.print("Enter a valid item.")
            return
        end

        local id, ns = nsid_split(args[1])
        local item = Item.find(id, ns)
        if not item then
            Console.print("Item '"..args[1].."' not found.")
            return
        end

        local count = args[2]
        if count and (type(count) ~= "number") then
            Console.print("Invalid item count.")
            return
        end

        local temp = args[3]
        if temp and (type(temp) ~= "boolean") then
            Console.print("Invalid value for temporary.")
            return
        end

        local m_id = args[4]
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

        p:item_take(item, count or 1, (temp and Item.StackKind.TEMPORARY_BLUE) or Item.StackKind.NORMAL)
    end
}