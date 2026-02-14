Console.new{
    "kill_all [object]",
    {
        "Kill all actors (of a specified actor object). \nDefaults to all enemies if not specified.",
        {"[object]", "string", "The namespace-identifier of the actor object (e.g., <y>ror-lizard</c>). Namespace is not required for vanilla objects."}
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        if #args < 1 then
            local actors = Instance.find_all(gm.constants.pActor)
            for _, actor in ipairs(actors) do
                if actor.team == 2 then
                    actor:kill()
                end
            end

        else
            if type(args[1]) ~= "string" then
                Console.print("Enter a valid object.")
                return
            end

            local id, ns = nsid_split(args[1])
            local obj = Object.find(id, ns)
            if not obj then
                Console.print("Object '"..args[1].."' not found.")
                return
            end

            if gm.object_is_ancestor(obj.value, gm.constants.pActor) ~= 1 then
                Console.print("Object '"..args[1].."' is not an actor object.")
                return
            end

            local actors = Instance.find_all(obj)
            for _, actor in ipairs(actors) do
                actor:kill()
            end

        end
    end
}