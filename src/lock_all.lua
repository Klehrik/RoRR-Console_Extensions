Console.new{
    "lock_all",
    {
        "Locks all achievements.",
    },
    function(args)
        if args[1] ~= "confirm" then
            Console.print("Are you sure? This will permanently alter your save data! \nType <y>lock_all confirm</c> to confirm.")
            return
        end

        for i = 0, (Global.count_achievement - 1) do
			GM.achievement_force_set_unlocked(i, false)
		end

        Achievement.find("unlock_commando"):add_progress()
        Achievement.find("unlock_huntress"):add_progress()

        Console.print("Locked all achievements.")
    end
}