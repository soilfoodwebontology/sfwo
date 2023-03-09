robot export -vvv --input /work/sfwo.owl \
  --add-prefix "SFWO: http://purl.org/sfwo/SFWO_#" \
  --header "ID|LABEL|definition|SYNONYMS|SubClass Of|Equivalent Class|comment" \
  --sort "LABEL" \
  --include "classes properties" \
  --export /work/sfwo.csv