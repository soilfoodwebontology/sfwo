robot export -vvv --input sfwo.owl \
  --add-prefix "SFWO: http://purl.org/sfwo/SFWO_" \
  --header "ID|LABEL|definition|SYNONYMS|SubClass Of|Equivalent Class|comment" \
  --sort "ID" \
  --include "classes properties" \
  --export sfwo.csv
