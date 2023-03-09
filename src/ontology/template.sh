robot template \
  --template tg_template.csv \
  --template punning_template.csv \
  --input sfwo-edit.owl \
  --prefix "SFWO: http://purl.org/sfwo/SFWO_" \
  --merge-before \
  --output sfwo-edit-test.owl

# robot template --template general_equivalence.csv  \
#   --input sfwo-edit.owl \
#   --prefix "SFWO: http://purl.org/sfwo/SFWO_" \
#   --merge-before \
#   --output sfwo-edit.owl

