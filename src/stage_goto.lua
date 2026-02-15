Console.new{
    "stage_goto (stage) [variant]",
    {
        "Go to a stage.",
        {"(stage)",   "string", "The namespace-identifier of the stage (e.g., <y>ror-desolateForest</c>). Namespace is not required for vanilla stages."},
        {"[variant]", "number", "The variant to go to, indexed from 1. Random variant by default."},
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        if (#args < 1)
        or (type(args[1]) ~= "string") then
            Console.print("Enter a valid stage.")
            return
        end

        local id, ns = nsid_split(args[1])
        local stage = Stage.find(id, ns)
        if not stage then
            Console.print("Stage '"..args[1].."' not found.")
            return
        end

        local variant = args[2]
        if variant and (type(variant) ~= "number" or variant <= 0) then
            Console.print("Invalid variant.")
            return
        end

        gm.stage_goto(stage.value, (variant or 1) - 1)
    end
}