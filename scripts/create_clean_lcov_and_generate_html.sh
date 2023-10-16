#!/bin/bash
set -e
flutter pub get
sh scripts/import_files_coverage.sh lcov_test
flutter test --coverage
lcov --remove coverage/lcov.info \
'lib/bootstrap.dart' \
'lib/main_development.dart' \
'lib/main_production.dart' \
'lib/main_staging.dart' \
'lib/*/*.g.dart' \
'lib/helpers/*.dart' \
'lib/*/view/*.dart' \
-o coverage/lcov.info
if [ -n "$1" ]
then
    if [ "$1" = true ]
    then
        genhtml coverage/lcov.info -o coverage
        open coverage/index.html
    fi
fi