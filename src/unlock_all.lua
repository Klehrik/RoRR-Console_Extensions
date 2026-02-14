Console.new{
    "unlock_all",
    {
        "Unlock all achievements.",
    },
    function(args)
        if args[1] ~= "confirm" then
            Console.print("Are you sure? This will permanently alter your save data! \nType <y>unlock_all confirm</c> to confirm.")
            return
        end

        for i = 0, (Global.count_achievement - 1) do
			GM.achievement_force_set_unlocked(i, true)
		end

        Console.print("Unlocked all achievements.")
    end
}