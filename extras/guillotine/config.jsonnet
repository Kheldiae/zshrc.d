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
    lib.Command('Icons Browser',
                'emblem-system-symbolic',
                false,
                'gtk3-icon-browser'),
    lib.Separator(),
    lib.Command('Last boot logs',
                'emblem-system-symbolic',
                true,
                "gnome-terminal -e 'journalctl -eb0'"),
    lib.Menu('Software logs', 'open-menu-symbolic', [
      lib.Command('PostgreSQL',
                  'printer-network-symbolic',
                  true,
                  "gnome-terminal -e 'journalctl -xeu postgresql.service'"),
      lib.Command('Docker containers',
                  'system-run-symbolic',
                  true,
                  "gnome-terminal -e 'journalctl -xeu docker.service'"),
    ]),
    lib.Separator(),
    lib.Menu('Services', 'system-run-symbolic', [
      lib.SystemdService('PostgreSQL',
                         'printer-network-symbolic',
                         'postgresql'),
      lib.SystemdService('Docker containers',
                         'system-run-symbolic',
                         'docker'),
    ]),
    lib.SystemdService('RustDesk remote',
                       'preferences-desktop-remote-desktop-symbolic',
                       'rustdesk'),
    lib.Separator(),
  ],
}
