local Command(name, icon, singleInstance = false, cmd) = {
    type: "command",
    label: name,
    icon: icon,
    singleInstance: singleInstance,
    command: cmd
};

local Menu(name, icon, content = []) = {
    type: "menu",
    label: name,
    icon: icon,
    content: content
};

local SystemdService(label, icon, name) = {
    type: "switch"
    label: label,
    icon: icon,
    name: name
};

{
}
