local Header = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n';

local PlistTag = '<plist version="1.0">';

local Tag(type, value) = '<' + type + '>' + value + '</' + type + '>';

local RealizeXML(obj) =
  if std.isObject(obj)
  then
    Tag('dict',
        std.foldl(function(l, r)
          l + Tag('key', r.key) + RealizeXML(r.value)),
        std.objectKeysValues(obj),
        '')
  else if std.isArray(obj)
  then
    Tag('array',
        std.foldl(function(l, r) l + RealizeXML(r), obj, ''))
  else if std.isString(obj)
  then
    Tag('string', obj)
  else if std.isNumber(obj)
  then
    Tag('number', obj)
  else if std.isBoolean(obj)
  then
    '<' + obj + '/>'  // we shouldn't really need this one
  else if obj == null
  then
    '<null/>'
  else obj;  // normally we don't reach this one

// main theme tag, also meant to be a root call
local Theme(name, description, author, o={}) =
  Header
  + PlistTag
  + RealizeXML({
    name: name,
    description: description,
    originalAuthor: author,
    settings: o,
  })
  + '</plist>';

// exporting
{
  Theme(name, description, author, o={})::
    Theme(name, description, author, o),
}
