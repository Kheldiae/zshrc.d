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
    lib.Menu('Log journals', 'text-x-generic-symbolic', [
      lib.Command('Systemd logging journal',
                  'emblem-system-symbolic',
                  true,
                  "kitty 'journalctl -eb0'"),  // FIXME
      lib.Separator(),
    ]),
    lib.Separator(),
    lib.Menu('Services', 'preferences-other-symbolic', [
      lib.SystemdService('PostgreSQL DB',
                         'printer-network-symbolic',
                         'postgresql.service'),
      lib.Separator(),
    ]),
    lib.Separator(),
  ],
}
