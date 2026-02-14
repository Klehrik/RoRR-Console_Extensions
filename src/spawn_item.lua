Console.new{
    "spawn_item (item) [count]",
    {
        "Spawn an item drop(s) at the current mouse position.",
        {"(item)",  "string", "The namespace-identifier of the item (e.g., <y>ror-meatNugget</c>). Namespace is not required for vanilla items."},
        {"[count]", "number", "The number of drops to spawn. <y>1</c> by default."},
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
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
        if count and (type(count) ~= "number" or count <= 0) then
            Console.print("Invalid item count.")
            return
        end

        local x, y = Global.mouse_x, Global.mouse_y
        for i = 1, (count or 1) do
            item:create(x, y)
        end
    end
}