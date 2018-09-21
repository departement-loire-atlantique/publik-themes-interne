#! /usr/bin/env python

import base64
import os
import sys

os.chdir(sys.argv[1])

data_uris = []
for filename in os.listdir('images/'):
    varname, filetype = os.path.splitext(filename)
    mimetype = {
        '.png': 'image/png',
        '.svg': 'image/svg+xml'
    }.get(filetype)
    if not mimetype:
        continue
    filesize = os.stat('images/' + filename).st_size
    if filesize > 10000:
        continue
    filecontent = open('images/' + filename).read()
    b64 = base64.encodestring(filecontent).replace('\n', '')
    data_uris.append('$data_uri_%(varname)s: "data:%(mimetype)s;base64,%(b64)s";' % locals())

open('_data_uris.scss', 'w').write('\n'.join(data_uris))
