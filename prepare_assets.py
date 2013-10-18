import os
import re

from gears.environment import Environment
from gears.finders import FileSystemFinder
from gears.processors import hexdigest_paths

#hack to exclude 3rd party css from external locations
hexdigest_paths.URL_RE = re.compile(r"""url\((?!//)(['"]?)\s*(.*?)\s*\1\)""")

ROOT_DIR = os.path.abspath(os.path.dirname(__file__))
SOURCE_DIR = os.path.join(ROOT_DIR, '_public')
DEST_DIR = os.path.join(ROOT_DIR, '_out')


def delete_unused_files(manifest):
  for k, v in manifest.files.items():
    if k.endswith('html'):
      path = os.path.join(DEST_DIR, v)
    else:
      path = os.path.join(DEST_DIR, k)

    os.remove(path)


if __name__ == '__main__':
  public_assets_config = (
    lambda path: any(path.endswith(ext) for ext in ('.css', '.js', '.html')),
  )

  #defines where files will be emitted
  env = Environment(DEST_DIR, public_assets=public_assets_config)
  env.finders.register(FileSystemFinder([SOURCE_DIR]))
  env.register_defaults()

  env.save()
  delete_unused_files(env.manifest)
