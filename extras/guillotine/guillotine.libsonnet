local Command(name, icon, singleInstance=false, cmd) = {
  type: 'command',
  title: name,
  icon: icon,
  instancing: if singleInstance then 'singleInstance' else 'multipleInstances',
  command: cmd,
};

local Menu(name, icon, content=[]) = {
  type: 'menu',
  title: name,
  icon: icon,
  item: content,
};

local Separator() = { type: 'separator' };

local Toggle(label, icon, name, start, stop, check, interval=5) = {
  type: 'switch',
  title: label,
  icon: icon,
  start: start,
  stop: stop,
  check: check,
  interval_s: interval,
};

{
}
