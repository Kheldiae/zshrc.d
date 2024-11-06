local Command(name, icon, singleInstance=false, cmd) = {
  type: 'command',
  title: name,
  icon: icon,
  instancing: if singleInstance then 'singleInstance' else 'multipleInstances',
  command: cmd,
};

local Menu(name, icon, content=[]) = {
  type: 'submenu',
  title: name,
  icon: icon,
  items: content,
};

local Separator() = { type: 'separator' };

local Switch(label, icon, name, start, stop, check, interval_s=5) = {
  type: 'switch',
  title: label,
  icon: icon,
  start: start,
  stop: stop,
  check: check,
  interval_s: interval_s,
};

local SystemdService(label, icon, name) =
  Switch(label,
         icon,
         name,
         start='systemctl start ' + name + '.service',
         stop='systemctl stop ' + name + '.service',
         check='systemctl is-active ' + name + '.service');

// TODO add kitty launch
local LogCmd(service, icon) =
  Command(service,
          icon,
          true,
          'kitty journalctl -xu ' + service + '.service');

{
  Separator():: Separator(),
  Command(name, icon, singleInstance, cmd):: Command(name,
                                                     icon,
                                                     singleInstance,
                                                     cmd),
  Menu(name, icon, content):: Menu(name, icon, content),
  SystemdService(label, icon, name):: SystemdService(label, icon, name),
  LogCmd(service, icon):: LogCmd(service, icon),
}
