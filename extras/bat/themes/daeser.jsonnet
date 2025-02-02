local lib = import './theme.libsonnet';

lib.Theme('Daeser (Dark)',
          'Custom theme inspired by Daeser and Gruvbox',
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
          }, {
            name: 'Punctuation',
            scope: lib.mkOpts([
              'entity.quasi.element meta.group.braces',
              'keyword.operator keyword.operator.neon',
              'keyword.operator operator.neon',
              'keyword.operator.accessor',
              'keyword.other.accessor',
              'meta.attribute-selector keyword.operator.stylus',
              'meta.brace',
              'meta.delimiter',
              'meta.group.braces',
              'meta.punctuation.separator',
              'meta.separator',
              'punctuation',
            ]),
            settings: { foreground: '#fb1c7' },
          }, {
            name: 'Comments',
            scope: lib.mkOpts([
              'comment',
              'comment text',
              'markup.strikethrough',
              'punctuation.definition.comment',
              'punctuation.whitespace.comment',
              'string.comment',
              'text.cancelled',
            ]),
            settings: { foreground: '#d5c4a1' },
          }, {
            name: 'Entity',
            scope: lib.mkOpts([
              'constant.language.name',
              'entity.name.type',
              'entity.other.inherited-class',
            ]),
            settings: { foreground: '#fabd2f' },
          }, {
            name: 'Keywords',
            scope: lib.mkOpts([
              'js.embedded.control.flow keyword.operator.js',
              'keyword',
              'keyword.control',
              'keyword.operator.logical.python',
              'meta.at-rule.media support.function.misc',
              'meta.prolog.haml',
              'meta.tag.sgml.doctype.html',
              'storage.type.function.jade',
              'storage.type.function.pug',
              'storage.type.import.haxe',
              'storage.type.import.include.jade',
              'storage.type.import.include.pug',
              'support.keyword.timing-direction',
              'variable.documentroot',
            ]),
            settings: { foreground: '#fb4934' },
          }, {
            name: 'Operators',
            scope: lib.mkOpts([
              'keyword.control.new',
              'keyword.control.operator',
              'keyword.operator',
              'keyword.other.arrow',
              'keyword.other.double-colon',
              'punctuation.operator',
            ]),
            settings: { foreground: '#8ec07c' },
          }, {
            name: 'Constants Punctuation',
            scope: lib.mkOpts([
              'constant.other.color punctuation.definition.constant',
              'constants.other.symbol punctuation.definition.constant',
              'constant.other.unit',
              'keyword.other.unit',
              'punctuation.section.flowtype',
              'support.constant.unicode-range.prefix',
            ]),
            settings: { foreground: '#b16286' },
          }, {
            name: 'Storage',
            scope: lib.mkOpts([
              'storage',
              'storage.type.annotation',
              'storage.type.primitive',
            ]),
            settings: { foreground: '#fb4934' },
          }, {
            name: 'Function Keyword',
            scope: lib.mkOpts([
              'entity.quasi.tag.name',
              'meta.function storage.type.matlab',
              'storage.type.function',
            ]),
            settings: { foreground: '#8ec07c' },
          }, {
            name: 'Variables',
            scope: lib.mkOpts([
              'entity.name.val.declaration',
              'entity.name.variable',
              'meta.definition.custom-property',
              'punctuation.definition.variable',
              'support.constant.custom-property-name.prefix',
              'variable.interpolation',
              'variable.other.dollar',
              'punctuation.dollar',
              'variable.other.object.dollar',
              'punctuation.dollar',
            ]),
            settings: { foreground: '#83a598' },
          }, {
            name: 'Variable - Punctuation',
            scope: lib.mkOpts([
              'keyword.other.custom-property.prefix',
              'punctuation.definition.custom-property',
              'punctuation.definition.variable',
              'support.constant.custom-property-name.prefix',
              'variable.interpolation',
              'variable.other.dollar punctuation.dollar',
              'variable.other.object.dollar punctuation.dollar',
            ]),
            settings: { foreground: '#458588' },
          }, {
            name: 'Function Declaration - Punctuation',
            scope: 'entity.name.function punctuation.dollar',
            settings: { foreground: '#fbf1c7' },
          }, {
            name: 'Object Properties',
            scope: 'meta.property.object',
            settings: { foreground: '#fbf1c7' },
          }, {
            name: 'Object Litteral Properties',
            scope: lib.mkOpts([
              'constant.other.object.key string',
              'meta.object-litteral.key',
            ]),
            settings: { foreground: '#fbf1c7' },
          }, {
            name: 'Parameters',
            scope: lib.mkOpts([
              'meta.parameters',
              'variable.parameter',
            ]),
            settings: { foreground: '#fbf1c7' },
          }, {
            name: 'Language Constants',
            scope: lib.mkOpts([
              'constant',
              'constant.numeric',
              'constant.other',
              'constant.other.color',
              'coonstant.other.symbol',
              'support.constant',
            ]),
            settings: { foreground: '#db3869b' },
          }, {
            name: 'Language Constants Punctuation',
            scope: 'variable.language punctuation.definition.variable',
            settings: { foreground: '#d3869b' },
          }, {
            name: 'User-Defined Constants',
            scope: lib.mkOpts([
              'entity.name.constant',
              'variable.other.constant',
            ]),
            settings: { foreground: '#fabd2f' },
          }, {
            name: 'Escaped Characters',
            scope: lib.mkOpts([
              'constant.character.escape',
              'constant.character.escaped',
              'constant.character.quoted',
              'constant.other.character-class.escape',
            ]),
            settings: { foreground: '#fb4934' },
          }, {
            name: 'Invalids and Illegals',
            scope: 'invalid',
            settings: { foreground: '#fb4934' },
          }, {
            name: 'Inner Scopes of Invalids and Illegals',
            scope: lib.mkOpts([
              'invalid keyword.other.custom-property.prefix',
              'invalid support.type.custom-property.name',
            ]),
            settings: { foreground: '#fbf1c7' },
          }])
