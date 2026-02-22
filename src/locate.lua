Console.new{
    "locate (object) [n]",
    {
        "Teleport the local player to an instance of an object.",
        {"(object)", "string", "The namespace-identifier of the object (e.g., <y>Chest1</c> or <y>ror-Chest1</c>)."},
        {"[n]",      "number", "The n-th instance, indexed from 1. <y>1</c> by default."},
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

        local p = Player.get_local()
        if not Instance.exists(p) then
            Console.print("Local player does not exist.")
            return
        end

        if (#args < 1)
        or (type(args[1]) ~= "string") then
            Console.print("Enter a valid object.")
            return
        end

        local id, ns = nsid_split(args[1])
        local obj = Object.find(id, ns)
        if not obj then
            Console.print("Object '"..args[1].."' not found.")
            return
        end

        local n = args[2]
        if n and (type(n) ~= "number" or n <= 0) then
            Console.print("Invalid value for n.")
            return
        end

        local inst = Instance.find(obj, n or 1)
        if inst == Instance.INVALID then
            Console.print("Instance #"..n.." of '"..args[1].."' does not exist.")
            return
        end

        p.x = inst.x
        p.y = inst.y - 12
    end
}