define_arguments(prog, |args)

fn kill_win(height, width)
    notify-send("W: ${width} | H: ${height}")
    let HW = height / width
    let WH = width / height
    notify-send("H/W: ${HW} | W/H: ${WH}")
    swaymsg("kill")
end

let width  = +swaymsg("-t get_tree") -> jq(".. | select(.type?) | select(.focused==true) | .rect.width"):out
let height = +swaymsg("-t get_tree") -> jq(".. | select(.type?) | select(.focused==true) | .rect.height"):out

foreach arg in args do
    if arg == "kill" then
        kill_win(height, width)
        exit()
    end
end

if height > width  then
    swaymsg("splitv")
else
    swaymsg("splith")
end

@prog()
exit()
