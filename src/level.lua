Console.new{
    "level (value)",
    {
        "Set the level of all players, triggering level-up effects per level gained. \nCannot set a lower value than current level.",
        {"(value)", "number", "The level to set."},
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

        local dir = Instance.find(gm.constants.oDirectorControl)
        if not Instance.exists(dir) then
            Console.print("Director does not exist.")
            return
        end
        
        if type(args[1]) ~= "number" or args[1] <= 0 then
            Console.print("Enter a valid level.")
            return
        end

        local count = args[1] - dir.player_level
        if count < 0 then
            Console.print("Cannot set level lower than current.")
            return
        end

        for i = 1, count do
            dir.player_level_up()
        end
    end
}