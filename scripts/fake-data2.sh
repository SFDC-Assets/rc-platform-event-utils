#!/bin/bash

# input
ORG_ALIAS=dev
#ORG_ALIAS=rc-assets
RECIPE=scripts/snowfakery/Opportunities2.recipe.yml
NUM_RECORDS=3

# run snowfakery recipe
echo "running snowfakery recipe: $RECIPE"
SECONDS=0
cci task run generate_and_load_from_yaml -o generator_yaml $RECIPE -o num_records $NUM_RECORDS -o num_records_tablename Account --org $ORG_ALIAS
#cci task run generate_and_load_from_yaml -o generator_yaml scripts/examples/Account.recipe.yml -o num_records 5 -o num_records_tablename Account --org dev
duration=$SECONDS
echo "snowfakery recipe complete - duration: $(($duration / 60)) minutes, $(($duration % 60)) seconds"