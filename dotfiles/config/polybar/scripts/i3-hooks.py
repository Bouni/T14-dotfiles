#!/usr/bin/env python3
import i3ipc
from subprocess import call

i3 = i3ipc.Connection()

def write_mode():
    layout = i3.get_tree().find_focused().parent.layout
    with open("/tmp/i3-tiling-indicator", "w") as f:
        if layout == 'splitv':
            f.write("")
        elif layout == 'splith':
            f.write("")
    call('polybar-msg hook tiling 1'.split(' '))


def on_event(self, _):
    write_mode()

write_mode()

# Subscribe to events
i3.on("window::focus", on_event)
i3.on("binding", on_event)

# Start the main loop and wait for events to come in.
i3.main()
