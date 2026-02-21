Console.new{
    "item_give (item) [count] [temporary]",
    {
        "Give stacks of an item to the local player.",
        {"(item)",      "string", "The namespace-identifier of the item (e.g., <y>meatNugget</c> or <y>ror-meatNugget</c>)."},
        {"[count]",     "number", "The number of stacks to give. <y>1</c> by default."},
        {"[temporary]", "bool",   "If <y>true</c>, the stacks will be temporary. <y>false</c> by default."},
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        local p = Player.get_local()
        if not Instance.exists(p) then
            Console.print("Local player does not exist.")
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

        p:item_give(item, count or 1, (temp and Item.StackKind.TEMPORARY_BLUE) or Item.StackKind.NORMAL)
    end
}