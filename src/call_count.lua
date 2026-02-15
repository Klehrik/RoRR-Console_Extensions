local hook
local hook_name = ""
local recent = {}
local recent_max = 30
local calls_this_frame = 0

Console.new{
    "call_count [script]",
    {
        "Monitor the average call count per frame for \na GML script, displayed in the top-left corner. \nIf no script is provided, turn off monitoring.",
        {"[script]", "string", "The script to monitor (e.g., <y>instance_create</c>, <y>gml_Object_oInit_Draw_73</c>, etc.)"},
    },
    function(args)
        if #args < 1 then
            if hook then
                hook:remove()
                hook = nil
                Console.print("Turned off script monitoring.")
            end
            return
        end

        if type(args[1]) ~= "string" then
            Console.print("Enter a valid script.")
            return
        end

        local script = gm.constants[args[1]] or args[1]
        if not script then
            Console.print("Script '"..args[1].."' not found.")
            return
        end

        local status, ret = pcall(function()
            hook = Hook.add_post(script, function()
                calls_this_frame = calls_this_frame + 1
            end)
            hook_name = args[1]
            Console.print("Now monitoring '"..args[1].."'.")
        end)

        if not status then
            Console.print("Error occured when trying to monitor '"..args[1].."': \n<r>"..ret)
        end
    end
}

Hook.add_post(gm.constants.__input_system_tick, function(self, other, result, args)
    table.insert(recent, calls_this_frame)
    if #recent > 30 then table.remove(recent, 1) end
    calls_this_frame = 0
end)

Hook.add_post("gml_Object_oInit_Draw_64", function(self, other, result, args)
    if not hook then return end

    local og_halign = gm.draw_get_halign()
    local og_valign = gm.draw_get_valign()
    local og_font = gm.draw_get_font()
    gm.draw_set_halign(0)
    gm.draw_set_valign(0)
    gm.draw_set_font(gm.constants.fntNormal)

    local avg = 0
    for _, n in ipairs(recent) do
        avg = avg + n
    end
    avg = avg / recent_max

    local scale = Global.___ui_mode_zoom_scale
    local c = Color.WHITE
    for i, text in ipairs{
        "Monitoring:        "..hook_name,
        "Average calls:    "..string.format("%.2f", avg),
        "Calls this frame: "..math.round(calls_this_frame),
    } do
        gm.draw_text_transformed_color(8 * scale, (4 + (16 * (i - 1))) * scale, text, scale, scale, 0, c, c, c, c, 1)
    end

    gm.draw_set_halign(og_halign)
    gm.draw_set_valign(og_valign)
    gm.draw_set_font(og_font)
end)