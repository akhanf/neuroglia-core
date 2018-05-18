#!/usr/bin/env python
'''Install gradunwarp and dependencies

Note: need FSL installed to run gradient_unwarp.py
'''


import os

os.system('pip install numpy')
os.system('pip install scipy')
os.system('pip install nibabel')
os.system('pip install pydicom')
os.system('pip install nose')
os.system('pip install sphinx')

if os.path.exists('/tmp/gradunwarp'):
    os.system('rm -rf /tmp/gradunwarp')

os.system('git clone https://github.com/kaitj/gradunwarp.git /tmp/gradunwarp'
          ' && cd /tmp/gradunwarp'
          ' && rm -rf build'
          ' && python setup.py install'
          ' && cd')
