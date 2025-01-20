local lib = import './theme.libsonnet';

lib.Theme('Daeser (Dark)',
          'Custom theme inspired by Daeser and Gruvbox for nvim',
          'kheldae (https://github.com/Khelda)',
          [{
            settings: {
              background: '#282828',
              caret: '#a89984',
              foreground: '#ebdbb226',
              invisibles: '#ebdbb226',
              lineHighlight: '#3c3836',
              highlight: '#fbf1c7',
              selectionBorder: '#3c3836',
            },
          }, {
            name: 'Text and Source Base Colors',
            scope: lib.mkOpts([
              'meta.group',
              'meta.method-call.source.cs',
              'meta.method.attribute.source.cs',
              'meta.method.body.java',
              'meta.method.body.source.cs',
              'meta.method.source.cs',
              'none',
              'source',
              'text',
            ]),
            settings: { foreground: '#fbf1c7' },
          }])
