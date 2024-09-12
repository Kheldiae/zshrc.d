local lib = import './guillotine.libsonnet';

{
  settings: {
    loglevel: 'error',
    notificationLevel: 'error',
    icon: 'emblem-system-symbolic',
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
    lib.Menu('Software logs', '', [
      lib.Command('PostgreSQL',
                  'printer-network-symbolic',
                  true,
                  "gnome-terminal -e 'journalctl -xeu postgresql.service'"),
      lib.Separator(),
    ]),
    lib.Separator(),
    lib.Menu('Services', 'preferences-other-symbolic', [
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
