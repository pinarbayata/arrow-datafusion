#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set -ex
cd datafusion-examples/examples/
cargo fmt --all -- --check
cargo check --examples

files=$(ls .)
for filename in $files
do
  example_name=`basename $filename ".rs"`
  # Skip tests that rely on external storage and flight
  # todo: Currently, catalog.rs is placed in the external-dependence directory because there is a problem parsing
  # the parquet file of the external parquet-test that it currently relies on.
  # We will wait for this issue[https://github.com/apache/arrow-datafusion/issues/8041] to be resolved.
  if [ ! -d $filename ]; then
     cargo run --example $example_name
  fi
done
