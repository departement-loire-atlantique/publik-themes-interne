#! /usr/bin/env python

import base64
import os
import sys


def data_uri(sourcepath):
  path = os.getcwd()
  os.chdir(sourcepath)
  data_uris = []
  for filename in os.listdir('.'):
    varname, filetype = os.path.splitext(filename)
    mimetype = {
        '.png': 'image/png',
        '.svg': 'image/svg+xml'
    }.get(filetype)
    if not mimetype:
        continue
    filesize = os.stat(filename).st_size
    if filesize > 10000:
        continue
    filecontent = open(filename).read()
    b64 = base64.encodestring(filecontent).replace('\n', '')
    data_uris.append('$data_uri_%(varname)s: "data:%(mimetype)s;base64,%(b64)s";' % locals())
  os.chdir(path)
  return data_uris

all_data_uris = data_uri(sys.argv[1])
all_data_uris += data_uri(sys.argv[2])

open(sys.argv[3], 'w').write('\n'.join(all_data_uris))
