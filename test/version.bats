#!/usr/bin/env bats

SCRIPT=./out/bin/version

load helpers/print/bprint

@test "It should bump patch version" {
  run $SCRIPT v1.0.0 --patch

  [ $status -eq 0 ]
  [[ "$output" == v1.0.1 ]]
}

@test "It should bump minor version" {
  run $SCRIPT v1.0.0 --minor

  [ $status -eq 0 ]
  [[ "$output" == v1.1.0 ]]
}

@test "It should bump major version" {
  run $SCRIPT v1.0.0 --major

  [ $status -eq 0 ]
  [[ "$output" == v2.0.0 ]]
}

@test "It should put patch to zero when minor is bumped" {
  run $SCRIPT v1.0.1 --minor

  [ $status -eq 0 ]
  [[ "$output" == v1.1.0 ]]
}

@test "It should put patch to zero when major is bumped" {
  run $SCRIPT v1.0.1 --major

  [ $status -eq 0 ]
  [[ "$output" == v2.0.0 ]]
}

@test "It should put minor to zero when major is bumped" {
  run $SCRIPT v1.1.0 --major

  [ $status -eq 0 ]
  [[ "$output" == v2.0.0 ]]
}

@test "It should add an rc identifier and bump patch version" {
  run $SCRIPT v1.0.0 --rc

  [ $status -eq 0 ]
  [[ "$output" == v1.0.1-rc.1 ]]
}

@test "It should bump rc version and not patch version" {
  run $SCRIPT v1.0.0-rc.1 --rc

  [ $status -eq 0 ]
  [[ "$output" == v1.0.0-rc.2 ]]
}
