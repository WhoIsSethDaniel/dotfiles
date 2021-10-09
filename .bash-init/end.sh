# source any available bash completion recipes
if [ -r /etc/bash_completion ] ; then
  . /etc/bash_completion
fi

set_export_post_path_var PATH ~/.npm-global/bin
set_export_post_path_var PATH ~/.local/bin

set_export_path_var PYTHONPATH ~/lib/python3.8/site-packages/

# clean up paths
clean_path PATH
clean_path MANPATH
clean_path LD_LIBRARY_PATH
