-- Capture commands during parsing; execute them only when Hyprland starts.
return function(command)
    hl.on("hyprland.start", function()
        hl.exec_cmd(command)
    end)
end
