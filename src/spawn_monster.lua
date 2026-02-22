Console.new{
    "spawn_monster (card) [count] [elite]",
    {
        "Spawn an enemy(s) from a monster card at the current mouse position.",
        {"(card)",  "string", "The namespace-identifier of the monster card (e.g., <y>lemurian</c> or <y>ror-lemurian</c>)."},
        {"[count]", "number", "The number of instances to spawn. <y>1</c> by default."},
        {"[elite]", "string", "The namespace-identifier of the elite type (e.g., <y>blazing</c> or <y>ror-blazing</c>)."},
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
            Console.print("Enter a valid card.")
            return
        end

        local id, ns = nsid_split(args[1])
        local card = MonsterCard.find(id, ns)
        if not card then
            Console.print("Card '"..args[1].."' not found.")
            return
        end

        local count = args[2]
        if count and (type(count) ~= "number" or count <= 0) then
            Console.print("Invalid spawn count.")
            return
        end

        local elite
        if args[3] then
            if type(args[3]) ~= "string" then
                Console.print("Enter a valid elite type.")
                return
            end

            local id, ns = nsid_split(args[3])
            elite = Elite.find(id, ns)
            if not elite then
                Console.print("Elite '"..args[3].."' not found.")
                return
            end
        end

        local x, y = Global.mouse_x, Global.mouse_y
        for i = 1, (count or 1) do
            local inst = Instance.create(x, y, card.object_id)
            if elite then GM.elite_set(inst, elite) end
        end
    end
}