Console.new{
    "gold (amount)",
    {
        "Set the amount of gold the local player has.",
        {"(amount)", "number", "The amount of gold to set."},
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        local hud = Instance.find(gm.constants.oHUD)
        if hud == Instance.INVALID then
            Console.print("HUD does not exist.")
            return
        end
        
        if type(args[1]) ~= "number" or args[1] < 0 then
            Console.print("Enter a valid amount.")
            return
        end

        hud.gold = args[1]
    end
}