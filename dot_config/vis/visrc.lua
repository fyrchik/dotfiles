require('vis')

function make_executable(file, path)
    vis:command("!chmod +x " .. path)
    vis.events.unsubscribe(vis.events.FILE_SAVE_POST, make_executable)
end

function insert_header(win)
    local file = win.file
    if file.size == 0 and file.path then
        local data
        if string.sub(file.path, -3) == ".sh" then
            data = "#!/bin/sh\nset -euo pipefail\n\n\n"
        elseif string.sub(file.path, -5) == ".bash" then
            data = "#!/bin/bash\nset -euo pipefail\n\n\n"
        else
            return
        end

        file:insert(0, data)
        win.selection.pos = #data - 1
        vis.events.subscribe(vis.events.FILE_SAVE_POST, make_executable)
    end
end

vis.events.subscribe(vis.events.WIN_OPEN, insert_header)
