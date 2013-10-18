import os
import re

from bs4 import BeautifulSoup
from gears.environment import Environment
from gears.finders import FileSystemFinder
from gears.processors import hexdigest_paths, DirectivesProcessor



#hack to exclude 3rd party css from external locations
hexdigest_paths.URL_RE = re.compile(r"""url\((?!//)(['"]?)\s*(.*?)\s*\1\)""")

ROOT_DIR = os.path.abspath(os.path.dirname(__file__))
SOURCE_DIR = os.path.join(ROOT_DIR, '_public')
DEST_DIR = os.path.join(ROOT_DIR, '_out')


class FingerprintReferenceProcessor(DirectivesProcessor):
  def __call__(self, asset):
    self.asset = asset

    soup = BeautifulSoup(self.asset.processed_source)

    assets_to_rewrite = soup.findAll('script') + soup.findAll('link', {'rel': 'stylesheet'})

    for asset in assets_to_rewrite:
      path_type = 'src'
      path = asset.get(path_type)
      if not path:
        path_type = 'href'
        path = asset.get(path_type)

      #check if path exists - it might just be an inline style or script
      if path and not path.startswith('http'):

        #remove leading slash as that makes os.join use the root of the file system
        path = path.lstrip('/')

        self.asset.requirements.add(self.get_asset(*self.find(path)))

        fingerprint_path = self.asset.attributes.environment.manifest.files[path]

        asset[path_type] = fingerprint_path

    with open(self.asset.absolute_path, 'wb') as f:
                f.write(unicode(soup))

  def get_relative_path(self, require_path, is_directory=False):
    path = super(FingerprintReferenceProcessor, self).get_relative_path(require_path, is_directory).rstrip('.html')
    return path


def delete_unused_files(manifest):
  for k, v in manifest.files.items():
    if k.endswith('html'):
      #don't use the fingerprinted html files
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
  env.mimetypes.register('.html', 'text/html')
  env.postprocessors.register('text/html', FingerprintReferenceProcessor.as_handler())

  env.save()
  delete_unused_files(env.manifest)
