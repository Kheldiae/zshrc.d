local lib = import './guillotine.libsonnet';

{
  settings: {
    loglevel: 'error',
    icon: 'emblem-system-symbolic',
  },
  menu: [
    lib.Command('Icons browser',
                'view-grid-symbolic',
                true,
                'gtk3-icon-browser'),
    lib.Separator(),
    lib.Menu('Logs', 'text-x-generic symbolic', [
      lib.Command('System',
                  'emblem-system-symbolic',
                  true,
                  "kitty -e ''"),
    ]),
    lib.Separator(),
    lib.Menu('Services', '', [
    ]),
  ],
}
