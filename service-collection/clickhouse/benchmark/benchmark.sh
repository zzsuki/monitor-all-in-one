#!/bin/bash


# Load the data

clickhouse-client -h localhost -u zzsuki --password zzsuki < create.sql

wget --continue 'https://datasets.clickhouse.com/hits_compatible/hits.tsv.gz'
gzip -d hits.tsv.gz

clickhouse-client -h localhost -u zzsuki --password zzsuki --time --query "INSERT INTO hits FORMAT TSV" < hits.tsv

# Run the queries

./run.sh

clickhouse-client --query "SELECT total_bytes FROM system.tables WHERE name = 'hits' AND database = 'default'"
