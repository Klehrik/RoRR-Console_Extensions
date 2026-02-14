Console.new{
    "spawn (object) [count]",
    {
        "Spawn an instance(s) of an object at the current mouse position.",
        {"(object)", "string", "The namespace-identifier of the object (e.g., <y>ror-lizard</c>). Namespace is not required for vanilla objects."},
        {"[count]",  "number", "The number of instances to spawn. <y>1</c> by default."},
    },
    function(args)
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

        local count = args[2]
        if count and (type(count) ~= "number" or count <= 0) then
            Console.print("Invalid spawn count.")
            return
        end

        local x, y = Global.mouse_x, Global.mouse_y
        for i = 1, (count or 1) do
            Instance.create(x, y, obj)
        end
    end
}