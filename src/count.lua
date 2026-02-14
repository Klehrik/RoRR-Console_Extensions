Console.new{
    "count (object)",
    {
        "Display the number of existing instances of an object.",
        {"(object)", "string", "The namespace-identifier of the object (e.g., <y>ror-chest1</c>). Namespace is not required for vanilla objects."},
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

        Console.print(math.floor(Instance.count(obj)))
    end
}