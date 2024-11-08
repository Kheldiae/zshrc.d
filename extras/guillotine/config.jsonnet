local lib = import './guillotine.libsonnet';

{
  settings: {
    loglevel: 'error',
    notificationLevel: 'error',
    icon: 'emblem-system-symbolic',
    keepMenuOpen: 'switch',
  },
  menu: [
    lib.Command('Refresh music library',
                'audio-x-generic-symbolic',
                false,
                'touch $HOME/Musique/*'),
    lib.Separator(),
    lib.Command('Last boot logs',
                'emblem-system-symbolic',
                true,
                'kitty journalctl -eb0'),
    lib.Menu('Software logs', 'open-menu-symbolic', [
      lib.LogCmd('postgresql', 'printer-network-symbolic'),
      lib.LogCmd('podman', ''),
    ]),
    lib.Separator(),
    lib.Menu('Services', 'system-run-symbolic', [
      lib.SystemdService('PostgreSQL',
                         'printer-network-symbolic',
                         'postgresql'),
    ]),
    lib.SystemdService('RustDesk remote',
                       'preferences-desktop-remote-desktop-symbolic',
                       'rustdesk'),
    lib.Separator(),
  ],
}
